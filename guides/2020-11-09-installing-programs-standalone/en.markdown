---
layout: post
title:  "Installing Go programs standalone"
excerpt: "Simple easy-to-remember way to install Go programs"
category: What's coming in Go 1.16
difficulty: Beginner
---

_By [Daniel Martí](https://twitter.com/mvdan_)_

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a simple one-liner they
can include at the top of their `README.md` files explaining how to get started.

Go 1.16 introduces a new, much simpler way to install Go programs standalone with the `go` command. This guide
introduces the new mode of `<!--ref:cmdgo.install-->` using the example of
[`<!--ref:staticcheck_pkg-->`](https://staticcheck.io/), and is suitable for end users and tool authors.

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Tutorial: Get started with Go](/get-started-with-go/)

This guide is running using:

<!--step: goversion-->

### Background

Prior to Go 1.16, tool authors who wanted to provide installation instructions in their projects' `README.md` files were
advised to use something like this:

<!--step: go115_staticcheck_install-->

There are a number of problems with this:

* It's ugly not at all user-friendly; it's not obvious to a newcomer to the language what is going on
* It's not cross platform, in particular this command is not guaranteed to work on Windows
* The use of `<!--ref:cmdgo.get-->` is confusing. `<!--ref:cmdgo.get-->` is used to download and install executables,
  but it‘s also responsible for managing dependencies in `go.mod` files

So what's going on in this command?

* The change to a temporary directory (`<!--ref:mktemp-->`) ensures that the remainder of the command is run outside of
  a module. Without this, it is possible that a user might run `<!--ref:cmdgo.get-->` within a module, and hence the
`<!--ref:cmdgo.get-->` command would update the current module's dependencies, rather than installing the tool
standalone
* The setting of `<!--ref:cmdgo.GO111MODULE-->` ensures that `<!--ref:cmdgo.get-->` runs in module mode outside of a
  module (if the variable is unset it will run in `GOPATH` mode)

The length of this explanation is reason enough to simplify things!

### `<!--ref:cmdgo.install-->` in Go 1.16

In Go 1.16, `<!--ref:cmdgo.install-->` command is used to install programs standalone, i.e. regardless of the current
module context:

<!--step: go116_staticcheck_install-->

For the purposes of this guide you are using a specific version (`<!--ref: staticcheck_version-->`). As an alternative,
the special `<!--ref:cmdgo.vlatest-->` version specified could be used to install the latest version.

Much like the previous behaviour of `<!--ref:cmdgo.get-->`, `<!--ref:cmdgo.install-->` installs binaries to
`$GOPATH/bin`, or `$GOBIN` if set. Let's confirm your setup using `<!--ref:cmdgo.env-->`:

<!--step: go_env_gopath-->

`GOBIN` is not set. Therefore as a one off, add `$GOPATH/bin` to your `PATH`:

<!--step: path_add_gopath_bin-->

Verify that `<!--ref:staticcheck-->` is now on your `PATH`:

<!--step: which_staticcheck-->

Run `<!--ref:staticcheck-->` to check everything is working:

<!--step: run_staticcheck-->

You can also use `<!--ref:cmdgo.version-->` to see the module dependencies used in building the program:

<!--step: goversion_staticcheck-->

To eliminate redundancy and confusion, the `<!--ref:cmdgo.get-->` approach used in Go 1.15 and before is being
deprecated.


