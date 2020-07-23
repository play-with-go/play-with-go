package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"

	"cuelang.org/go/cue"
	"cuelang.org/go/encoding/gocode/gocodec"
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

	fDev            *bool
	fGuideConfigs   []string
	fPrestepConfigs []string

	runtime cue.Runtime
	codec   *gocodec.Codec

	schemas preguide.Schemas
}

func newRunner() *runner {
	var err error
	fs := flag.NewFlagSet("controller", flag.ContinueOnError)
	r := &runner{
		fs: fs,
	}

	r.fDev = fs.Bool("dev", false, "indicates we are running in development-mode")
	fs.Var(stringFlagList{&r.fGuideConfigs}, "guideconfig", "CUE configuration input for guides; can appear multiple times")
	fs.Var(stringFlagList{&r.fPrestepConfigs}, "prestepconfig", "CUE configuration input for presteps deployments; can appear multiple times")

	r.codec = gocodec.New(&r.runtime, nil)

	r.schemas, err = preguide.LoadSchemas(&r.runtime)
	check(err, "failed to load schemas: %v", err)

	return r
}

func (r *runner) usage() string {
	return fmt.Sprintf(`
Usage of controller:

    controller

In -dev mode, incomplete environment variables in a guide's configuration
are expanded as part of the environment returned to the caller. This allows
for things like machine-local root CAs to be passed into the running
container.

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
