// Copyright 2020 The play-with-go.dev Authors. All rights reserved.  Use of
// this source code is governed by a BSD-style license that can be found in the
// LICENSE file.

package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	"github.com/play-with-go/preguide"
)

func main() { os.Exit(main1()) }

func main1() int {
	r := newRunner()

	err := r.mainerr()
	if err == nil {
		return 0
	}
	switch err := err.(type) {
	case usageErr:
		if err.err != flag.ErrHelp {
			fmt.Fprintln(os.Stderr, err.err)
		}
		fmt.Fprint(os.Stderr, r.usage())
		return 2
	}
	fmt.Fprintln(os.Stderr, err)
	return 1
}

type usageErr struct {
	err error
}

func (u usageErr) Error() string {
	return u.err.Error()
}

type runner struct {
	fs *flag.FlagSet

	fUnsafe         *bool
	fGuideConfigs   []string
	fPrestepConfigs []string
	fOrigins        []string
	fHashKey        *string
	fBlockKey       *string

	context *cue.Context

	schemas preguide.Schemas
}

func newRunner() *runner {
	var err error
	fs := flag.NewFlagSet("controller", flag.ContinueOnError)
	r := &runner{
		fs:      fs,
		context: cuecontext.New(),
	}

	r.fUnsafe = fs.Bool("unsafe", false, "indicates we are running in development-mode and hence enable unsafe things")
	fs.Var(stringFlagList{&r.fGuideConfigs}, "guideconfig", "CUE configuration input for guides; can appear multiple times")
	fs.Var(stringFlagList{&r.fPrestepConfigs}, "prestepconfig", "CUE configuration input for presteps deployments; can appear multiple times")
	fs.Var(stringFlagList{&r.fOrigins}, "origin", "the origin to set in the Access-Control-Allow-Origin header. Empty means no CORS setup required")
	r.fHashKey = fs.String("hashKey", "", "hashKey is used to authenticate the cookie value using HMAC")
	r.fBlockKey = fs.String("blockKey", "", "blockKey (optional), used to encrypt the cookie value. Empty means implies not using encryption")

	r.schemas, err = preguide.LoadSchemas(r.context)
	check(err, "failed to load schemas: %v", err)

	return r
}

func (r *runner) usage() string {
	return fmt.Sprintf(`
Usage of controller:

    controller

In -unsafe mode, incomplete environment variables in a guide's configuration
are expanded as part of the environment returned to the caller. This allows for
things like machine-local root CAs to be passed into the running container.

%s`[1:], r.flagDefaults())
}

func (r *runner) flagDefaults() string {
	var b bytes.Buffer
	r.fs.SetOutput(&b)
	r.fs.PrintDefaults()
	r.fs.SetOutput(ioutil.Discard)
	s := b.String()
	const indent = "\t"
	if s == "" {
		return s
	}
	lines := strings.Split(s, "\n")
	for i, l := range lines {
		if strings.TrimSpace(l) == "" {
			lines[i] = ""
		} else {
			lines[i] = indent + strings.Replace(l, "\t", "    ", 1)
		}
	}
	return strings.Join(lines, "\n")
}

// stringFlagList is a supporting type for generating a string flag that can
// appear multiple times.
type stringFlagList struct {
	vals *[]string
}

func (s stringFlagList) String() string {
	if s.vals == nil {
		return ""
	}
	return strings.Join(*s.vals, " ")
}

func (s stringFlagList) Set(v string) error {
	*s.vals = append(*s.vals, v)
	return nil
}
