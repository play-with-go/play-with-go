---
layout: post
title:  "Installing Go"
excerpt: "Ready to take the plunge and install Go on your system?!"
difficulty: Beginner
category: Next steps
---

So you're ready to take the plunge and install Go on your local system? Congratulations!

The official [_Download and Install_](https://golang.org/doc/install) instructions get you quickly up and running with Go.

This guide walks you through those steps, discusses the Go environment, and also explains how to setup your `PATH` for
running any Go programs you install.

### Installing Go

_Note: this guide is running on Linux. For Mac or Windows steps, see the official [Download and
Install](https://golang.org/doc/install) instructions._

Start in your home directory:

<!--step: start_dir-->

Download the latest version of Go:

<!--step: download_go-->

Extract and install:

<!--step: install_go-->

Add the install target to your profile `PATH`:

<!--step: add_install_to_path-->

Source your profile to test the new settings:

<!--step: source_profile-->

Verify the Go installation:

<!--step: go_version-->

### The Go environment

The `go` command and the tools it invokes consult environment variables
for configuration. If an environment variable is unset, the `go` command
uses a sensible default setting.

Let's examine the default settings in your setup:

<!--step: go_env-->

To see the effective setting of a specific variable, for example `GOBIN`, you can run:

<!--step: go_env_gopath-->

To change the default setting of a variable, for example `GOBIN`, you can run:

<!--step: go_env_set_gopath-->

Check the new value is set:

<!--step: go_env_check_gopath-->

Defaults changed in this way
are recorded in a Go environment configuration file stored in the
per-user configuration directory, as reported by [`os.UserConfigDir`](https://pkg.go.dev/os#UserConfigDir).
The location of the configuration file can be changed by setting
the environment variable `<!--ref:cmdgo.GOENV-->`.

Print the effective location of the configuration file:

<!--step: go_env_env-->

Note, you cannot change the default location of the configuration file.

Unset `GOBIN`, returning to its default value:

<!--step: go_env_unset_gopath-->

Check the effective value of `GOBIN` now:

<!--step: go_env_check_gopath_again-->

That is to say, `GOBIN` is not set by default.

See `<!--ref:go_help_env-->` for more details.

### Setting up your `PATH`

_Note: this section applies to Linux and Mac users only._

`<!--ref:cmdgo.get-->` and `<!--ref:cmdgo.install-->` install programs to `$<!--ref:cmdgo.GOPATH-->/bin`, or
`$<!--ref:cmdgo.GOBIN-->` if set. `GOBIN` is not set in the `play-with-go.dev` environment:

<!--step: gobin_not_set-->

So you need to add `$GOPATH/bin` to your profile `PATH`:

<!--step: add_gopath_bin_to_path-->

Source your profile again to test the new settings:

<!--step: source_profile_again-->

Verify the new setting of `PATH`:

<!--step: echo_path-->

### Conclusion

That's it! You're all set for working with Go on your local system.
