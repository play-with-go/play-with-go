// Copyright 2020 The play-with-go.dev Authors. All rights reserved.  Use of
// this source code is governed by a BSD-style license that can be found in the
// LICENSE file.

package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"log"
	"net/http"
	"os"
	"path"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/load"
	"github.com/gorilla/securecookie"
	"github.com/kr/pretty"
	"github.com/play-with-go/preguide"
	"golang.org/x/sync/errgroup"
)

type config struct {
	guides   preguide.GuideStructures
	presteps preguide.PrestepServiceConfig
}

func (r *runner) mainerr() (err error) {
	defer HandleKnown(&err)
	if err := r.fs.Parse(os.Args[1:]); err != nil {
		return usageErr{err: err}
	}

	if !*r.fUnsafe {
		if *r.fHashKey == "" {
			raise("-hashKey is required in a non-development environment")
		}
		if *r.fBlockKey == "" {
			raise("-blockKey is required in a non-development environment")
		}
	}

	if len(r.fOrigins) == 0 {
		raise("must supply at least one -origin")
	}
	if len(r.fGuideConfigs) == 0 {
		raise("controller not provided with any -guideconfig flags")
	}
	if len(r.fPrestepConfigs) == 0 {
		raise("controller not provided with any -prestepconfig flags")
	}

	config, err := r.loadConfig()
	check(err, "failed to load config: %v", err)

	http.HandleFunc("/", func(resp http.ResponseWriter, req *http.Request) {
		defer r.handleKnownRequest(resp)
		if !strings.HasPrefix(req.URL.Path, "/guides") {
			resp.WriteHeader(http.StatusNotFound)
			return
		}

		// CORS
		if len(r.fOrigins) > 0 {
			reqOrigin := req.Header.Get("Origin")
			var set bool
			for _, o := range r.fOrigins {
				if !set && o == reqOrigin {
					resp.Header().Set("Access-Control-Allow-Origin", o)
					set = true
				}
			}
			if !set {
				// Abritrarily choose the first origin - it's a failure case
				resp.Header().Set("Access-Control-Allow-Origin", r.fOrigins[0])
			}
		}
		resp.Header().Set("Access-Control-Allow-Credentials", "true")
		if req.Method == "OPTIONS" {
			resp.Header().Set("Access-Control-Allow-Methods", "GET")
			resp.Header().Set("Access-Control-Allow-Headers", "Content-Type")
			return
		}

		// Authenticate the request only if it's not CORS
		if !*r.fUnsafe {
			type CookieID struct {
				Id         string `json:"id"`
				UserName   string `json:"user_name"`
				UserAvatar string `json:"user_avatar"`
				ProviderId string `json:"provider_id"`
			}
			var s *securecookie.SecureCookie
			s = securecookie.New([]byte(*r.fHashKey), []byte(*r.fBlockKey))
			cookie, err := req.Cookie("id")
			if err != nil {
				raiseHTTP(http.StatusUnauthorized, "failed to find cookie named id")
			}
			var cookieData CookieID
			if err := s.Decode("id", cookie.Value, &cookieData); err != nil {
				raiseHTTP(http.StatusUnauthorized, "failed to authenticate: %v", err)
			}
		}

		if req.Method != "POST" {
			raiseHTTP(http.StatusBadRequest, "must be a POST request")
		}

		if *r.fUnsafe {
			// Reload config on each request in dev mode
			config, err = r.loadConfig()
			if err != nil {
				raiseHTTP(http.StatusInternalServerError, "failed to load config: %v", err)
			}
		}

		var guideReq struct {
			// Guide is the guide name
			Guide string

			// Language is the language code, e.g. en
			Language string

			// Scenario is the scenario name
			Scenario string
		}

		dec := json.NewDecoder(req.Body)
		if err := dec.Decode(&guideReq); err != nil {
			raiseHTTP(http.StatusBadRequest, "failed to JSON decode body: %v", err)
		}

		// Now assert that there is nothing else in the body
		var i interface{}
		if err := dec.Decode(&i); err != io.EOF {
			raiseHTTP(http.StatusBadRequest, "only expected a single request object")
		}

		// Resolve the guide configuration
		guideConfig, ok := config.guides[guideReq.Guide]
		if !ok {
			raiseHTTP(http.StatusInternalServerError, "failed to find guide configuration for %v", pretty.Sprint(guideReq))
		}

		// Now try to resolve deployment configuration for any presteps
		//
		// TODO: should this be an eager check when config is loaded?
		type deployedPrestep struct {
			prestep  *preguide.Prestep
			endpoint *preguide.ServiceConfig
		}
		var presteps []deployedPrestep
		for _, ps := range guideConfig.Presteps {
			endpoint, ok := config.presteps[ps.Package]
			if !ok {
				raiseHTTP(http.StatusInternalServerError, "failed to find prestep deployment configuration for %q (for guide %q)", ps.Package, guideReq.Guide)
			}
			presteps = append(presteps, deployedPrestep{
				prestep:  ps,
				endpoint: endpoint,
			})
		}

		type terminalDetails struct {
			Selector  string `json:"selector"`
			ImageName string
		}

		// Prepare our response
		var answer struct {
			Delims    [2]string
			Terminals []terminalDetails
			Networks  []string
			Env       []string
		}
		for _, t := range guideConfig.Terminals {
			answer.Terminals = append(answer.Terminals, terminalDetails{
				ImageName: t.Scenarios[guideReq.Scenario].Image,
				Selector:  "." + t.Name,
			})
		}
		answer.Delims = guideConfig.Delims
		answer.Networks = guideConfig.Networks
		for _, e := range guideConfig.Env {
			if strings.Index(e, "=") == -1 {
				// We need to expand the env based on the controller's environment
				// but only if we are in dev mode
				if !*r.fUnsafe {
					continue
				}
				e += "=" + os.Getenv(e)
			}
			answer.Env = append(answer.Env, e)
		}
		// Now run the presteps and add their config
		type prestepResp struct {
			out preguide.PrestepOut
			err error
		}
		prestepAnswers := make([]prestepResp, len(presteps))
		g := new(errgroup.Group)
		for i, ps := range presteps {
			i := i
			var body bytes.Buffer
			enc := json.NewEncoder(&body)
			if err := enc.Encode(ps.prestep.Args); err != nil {
				// TODO: we could front-load checking that (and caching) prestep
				// args can be marshalled to JSON
				raiseHTTP(http.StatusInternalServerError, "failed to encode args for prestep %q: %v. Args were %v", ps.prestep.Package, err, pretty.Sprint(ps.prestep.Args))
			}
			u := *ps.endpoint.Endpoint
			u.Path += path.Join(u.Path, ps.prestep.Path)
			g.Go(func() error {
				answer, err := http.Post(u.String(), "application/json", &body)
				if err != nil {
					return fmt.Errorf("failed to create prestep request for %v: %v", u, err)
				}
				dec := json.NewDecoder(answer.Body)
				defer answer.Body.Close()
				if err := dec.Decode(&prestepAnswers[i].out); err != nil {
					return fmt.Errorf("failed to decode prestep reseponse from %v: %v", u, err)
				}
				// Now check nothing remains
				var i interface{}
				if err := dec.Decode(&i); err != io.EOF {
					return fmt.Errorf("expected a single object response from %v; got more", u)
				}
				return nil
			})
		}
		if err := g.Wait(); err != nil {
			raiseHTTP(http.StatusInternalServerError, "failed to execute all presteps: %v", err)
		}
		for _, a := range prestepAnswers {
			answer.Env = append(answer.Env, a.out.Vars...)
		}

		// Now encode the response
		enc := json.NewEncoder(resp)
		if err := enc.Encode(answer); err != nil {
			// No point debug-writing to the response here... only log to stderr
			fmt.Fprintf(os.Stderr, "failed to write response: %v", err)
		}
	})
	log.Fatal(http.ListenAndServe(":8080", nil))
	return nil
}

func (r *runner) logOrRespond(resp http.ResponseWriter, format string, args ...interface{}) {
	msg := fmt.Sprintf(format, args...)
	if msg == "" || msg[len(msg)-1] != '\n' {
		msg += "\n"
	}
	var w io.Writer = os.Stderr
	// If we are in development mode, also write the response to the HTTP request to
	// make debugging that bit easier. Assumes the status header has already been
	// written
	if *r.fUnsafe {
		w = io.MultiWriter(w, resp)
	}
	fmt.Fprintf(w, msg)
}

func (r *runner) loadConfig() (config, error) {
	var res config
	if err := r.loadConfigFromFlags(r.fGuideConfigs, r.schemas.GuideStructures, &res.guides); err != nil {
		return res, fmt.Errorf("failed to load guide config: %v", err)
	}
	if err := r.loadConfigFromFlags(r.fPrestepConfigs, r.schemas.PrestepServiceConfig, &res.presteps); err != nil {
		return res, fmt.Errorf("failed to load prestep config: %v", err)
	}
	return res, nil
}

// loadConfigFromFlags loads CUE inputs, unifies them against schema, and then
// Encodes the resulting value into value
func (r *runner) loadConfigFromFlags(inputs []string, schema cue.Value, value interface{}) error {
	var val cue.Value
	bis := load.Instances(inputs, &load.Config{AllCUEFiles: true})
	for i, bi := range bis {
		inst, err := r.runtime.Build(bi)
		if err != nil {
			return fmt.Errorf("failed to load config from %v: %v", inputs[i], err)
		}
		val = val.Unify(inst.Value())
	}
	// TODO: there is a bug with cuelang.org/go v0.2.2 whereby we can't
	// encode the result of val.Unify(schema) - some error:
	//
	//     undefined field "#Terminal"
	//
	// We work around this by only encoding the un-unified val. However,
	// we still check that unifying val with the schema succeeds.
	unifiedVal := val.Unify(schema)
	if err := unifiedVal.Validate(); err != nil {
		return fmt.Errorf("failed to validate config: %v", err)
	}
	if err := r.codec.Encode(val, value); err != nil {
		return fmt.Errorf("failed to decode config from CUE value: %v", err)
	}
	return nil
}

// check verifies that err is nil, else it parnics wrapping err in a knownErr
// (which is recovered by my mainerr). This allows clean, fluent code without
// lots of error handling, where that error handling would otherwise simply
// bubble an error up the stack.
func check(err error, format string, args ...interface{}) {
	if err != nil {
		if format != "" {
			err = fmt.Errorf(format, args...)
		}
		panic(KnownErr{Err: err})
	}
}

// raise raises a knownErr, wrapping a fmt.Errorf generated error using the
// provided format and args. See the documentation for check on why these
// functions exist.
func raise(format string, args ...interface{}) {
	panic(KnownErr{Err: fmt.Errorf(format, args...)})
}

// knownErr is the sentinel error type used by check and raise. Values of this
// type are recovered in mainerr. See thd documentation for check for more
// details.
type KnownErr struct{ Err error }

// handleKnown is a convenience function used in a defer to recover from a
// knownErr. See the usage in mainerr.
func HandleKnown(err *error) {
	switch r := recover().(type) {
	case nil:
	case KnownErr:
		*err = r.Err
	default:
		panic(r)
	}
}

type KnownHTTPErr struct {
	Status int
	Err    error
}

func (r *runner) handleKnownRequest(resp http.ResponseWriter) {
	switch err := recover().(type) {
	case nil:
	case KnownHTTPErr:
		resp.WriteHeader(err.Status)
		r.logOrRespond(resp, "%v", err.Err)
	default:
		panic(err)
	}
}

func raiseHTTP(status int, format string, args ...interface{}) {
	err := fmt.Errorf(format, args...)
	panic(KnownHTTPErr{
		Status: status,
		Err:    err,
	})
}
