---
layout: post
title:  "Installing Go programs directly"
excerpt: "Simple easy-to-remember way to install Go programs"
category: Next steps
difficulty: Beginner
redirect_from:
  - /installing-go-programs-directly_go115_en/
---

_By [Daniel Martí](https://mvdan.cc), Go contributor, maintainer of [`encoding/json`](https://pkg.go.dev/encoding/json),
and tool author._

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a short one-liner they
can include at the top of their `README.md` explaining how to install the tool.

Go 1.16 introduced a new way to install Go programs directly with the `go` command. This guide
introduces the new mode of `{{{ .cmdgo.install }}}` using the example of
[`{{{ .mkcert_pkg }}}`](https://{{{ .mkcert_pkg }}}), and is suitable for both end users and tool authors.

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go119_en)

This guide is running with:

{{{ step "goversion" }}}

### `{{{ .cmdgo.install }}}` in Go 1.16

As of Go 1.16, the `{{{ .cmdgo.install }}}` command is now used to install
programs directly, i.e. regardless of the current module context:

{{{ step "go119_mkcert_install" }}}

For the purposes of this guide you are using a specific version (`{{{ .mkcert_version }}}`). Alternatively,
the special `{{{ .cmdgo.vlatest }}}` version can be used to install the latest release.

Much like the previous behaviour of `{{{ .cmdgo.get }}}`, `{{{ .cmdgo.install }}}` places binaries in `$GOPATH/bin`,
or in `$GOBIN` if set. See the _"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go119_en) to ensure
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

That's it!

As a next step you might like to consider:

* [Retract Module Versions](/retract-module-versions_go119_en/)
