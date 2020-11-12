---
layout: post
title:  "Installing Go programs directly"
excerpt: "Simple easy-to-remember way to install Go programs"
category: What's coming in Go 1.16
difficulty: Beginner
---

_By [Daniel Martí](https://mvdan.cc), contributor to Go, maintainer of [`encoding/json`](https://pkg.go.dev/encoding/json), and tool author._

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a short one-liner they
can include at the top of their `README.md` explaining how to install the tool.

Go 1.16 introduces a new way to install Go programs directly with the `go` command. This guide
introduces the new mode of `<!--ref:cmdgo.install-->` using the example of
[`<!--ref:staticcheck_pkg-->`](https://staticcheck.io/), and is suitable for both end users and tool authors.

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Tutorial: Get started with Go](/get-started-with-go/)

This guide is running with:

<!--step: goversion-->

### Background

Typically, tool authors who wanted to provide installation instructions in their
projects' `README.md` would include:

<!--step: go115_staticcheck_get-->

There are a number of problems with this approach:

* A user might run the above `<!--ref:cmdgo.get-->` within a module, which would
  update the current module's dependencies, rather than just installing the tool directly.
* `<!--ref:cmdgo.get-->` might not be running in module mode at all, for example
  if the user previously modified `<!--ref:cmdgo.GO111MODULE-->`.
* The use of `<!--ref:cmdgo.get-->` is confusing; it is used to download and install executables,
  but it's also responsible for managing dependencies in `go.mod` files.

Prior to Go 1.16, the general advice to fix the first two problems was to use a snippet
which runs `<!--ref:cmdgo.get-->` in module mode and outside any module, by using a temporary directory:

<!--step: go115_staticcheck_modules_get-->

However, this new approach had its own problems:

* It's not user-friendly; the extra shell is confusing to newcomers, and hard to remember.
* It's not cross platform; the command is not guaranteed to work on Windows.

It is clear that neither method is satisfactory, especially for `README.md`
instructions which are meant to be brief and easy to follow.

### `<!--ref:cmdgo.install-->` in Go 1.16

In Go 1.16, the `<!--ref:cmdgo.install-->` command is now used to install programs directly, i.e. regardless of the current
module context:

<!--step: go116_staticcheck_install-->

For the purposes of this guide you are using a specific version (`<!--ref: staticcheck_version-->`). Alternatively,
the special `<!--ref:cmdgo.vlatest-->` version can be used to install the latest release.

Much like the previous behaviour of `<!--ref:cmdgo.get-->`, `<!--ref:cmdgo.install-->` places binaries in
`$GOPATH/bin`, or in `$GOBIN` if set. Let's confirm your setup using `<!--ref:cmdgo.env-->`:

<!--step: go_env_gopath-->

`GOBIN` is not set. Therefore as a one off, add `$GOPATH/bin` to your `PATH`:

<!--step: path_add_gopath_bin-->

Verify that `<!--ref:staticcheck-->` is now on your `PATH`:

<!--step: which_staticcheck-->

Run `<!--ref:staticcheck-->` to check everything is working:

<!--step: run_staticcheck-->

You can also use `<!--ref:cmdgo.version-->` to see the module dependencies used in building the program:

<!--step: goversion_staticcheck-->

To eliminate redundancy and confusion, using `<!--ref:cmdgo.get-->` to build or
install programs is being deprecated in Go 1.16.
