---
layout: post
title:  "Installing Go programs directly"
excerpt: "Simple easy-to-remember way to install Go programs"
category: What's coming in Go 1.16
difficulty: Beginner
---

_By [Daniel Martí](https://mvdan.cc), Go contributor, maintainer of [`encoding/json`](https://pkg.go.dev/encoding/json),
and tool author._

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a short one-liner they
can include at the top of their `README.md` explaining how to install the tool.

Go 1.16 introduces a new way to install Go programs directly with the `go` command. This guide
introduces the new mode of `{{{ .cmdgo.install }}}` using the example of
[`{{{ .mkcert_pkg }}}`](https://mkcert.io/), and is suitable for both end users and tool authors.

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go115_en)

This guide is running with:

{{{ step "goversion" }}}

### Background

Currently, tool authors who want to provide installation instructions in their projects' `README.md` typically include:

{{{ step "go115_mkcert_get" }}}

_Note: most `README.md` instructions that use `{{{ .cmdgo.get }}}` do not specify a version. This results in the latest
version of a package being fetched. A specific version, `{{{.mkcert_version}}}`, is used here to ensure this guide
remains reproducible._

There are a number of problems with this approach:

* A user might run the above `{{{ .cmdgo.get }}}` within a module, which would
  update the current module's dependencies, rather than just installing the tool directly.
* `{{{ .cmdgo.get }}}` might not be running in module mode at all, for example
  if the user previously modified `{{{ .cmdgo.GO111MODULE }}}`.
* The use of `{{{ .cmdgo.get }}}` is confusing; it is used to download and install executables,
  but it's also responsible for managing dependencies in `go.mod` files.

Prior to Go 1.16, the general advice to fix the first two problems was to use a snippet
which runs `{{{ .cmdgo.get }}}` in module mode and outside any module, by using a temporary directory:

{{{ step "go115_mkcert_modules_get" }}}

However, this new approach had its own problems:

* It's not user-friendly; the extra shell is confusing to newcomers, and hard to remember.
* It's not cross platform; the command is not guaranteed to work on Windows.

It is clear that neither method is satisfactory, especially for `README.md`
instructions which are meant to be brief and easy to follow.

### `{{{ .cmdgo.install }}}` in Go 1.16

In Go 1.16, the `{{{ .cmdgo.install }}}` command is now used to install programs directly, i.e. regardless of the current
module context:

{{{ step "go116_mkcert_install" }}}

For the purposes of this guide you are using a specific version (`{{{ .mkcert_version }}}`). Alternatively,
the special `{{{ .cmdgo.vlatest }}}` version can be used to install the latest release.

Much like the previous behaviour of `{{{ .cmdgo.get }}}`, `{{{ .cmdgo.install }}}` places binaries in `$GOPATH/bin`,
or in `$GOBIN` if set. See the _"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go115_en) to ensure
your `PATH` is set correctly.

Verify that `{{{ .mkcert }}}` is now on your `PATH`:

{{{ step "which_mkcert" }}}

Run `{{{ .mkcert }}}` to check everything is working:

{{{ step "run_mkcert" }}}

You can also use `{{{ .cmdgo.version }}}` to see the module dependencies used in building the program:

{{{ step "goversion_mkcert" }}}

To eliminate redundancy and confusion, using `{{{ .cmdgo.get }}}` to build or
install programs is being deprecated in Go 1.16.

### Conclusion

That's it! Time to sit back and wait for the release of Go 1.16!

As a next step you might like to consider:

* [Retract Module Versions](/retract-module-versions_go116_en/)
