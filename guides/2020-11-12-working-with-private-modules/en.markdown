---
layout: post
title:  "Working with private modules"
excerpt: "How to create, publish and work with non-public modules in your team."
difficulty: Intermediate
category: Next steps
redirect_from:
  - /working-with-private-modules_go115_en/
---

_By [Paul Jolly](https://twitter.com/_myitcv), Go contributor, and co-creator of `play-with-go.dev`._

The `go` command defaults to downloading modules from the public Go module mirror at
[proxy.golang.org](https://proxy.golang.org). It also defaults to validating downloaded modules, regardless of source,
against the public Go checksum database at [sum.golang.org](https://sum.golang.org).  These defaults work well for
publicly available source code.

But what happens if you and your fellow developers need to work with private modules?

This guide explains how to work with private modules. In the guide you will create three modules:

* `{{{ .public_mod }}}`, a publicly accessible module that provides a `{{{ .public_message }}}` function
* `{{{ .private_mod }}}`, a private module that provides a `{{{ .private_secret }}}` function
* `{{{ .gopher_mod }}}`, a local-only module that uses `{{{ .public }}}` and `{{{ .private }}}` modules

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go119_en)

This guide is running using:

{{{ step "goversion" }}}

### The `public` and `private` modules

Start by initialising your  `public` module:

{{{ step "public_init" }}}

Create an initial version of the `{{{ .public_message }}}` in `{{{ .public_go }}}`:

{{{ step "public_go_initial" }}}

Commit and push this initial version:

{{{ step "public_initial_commit" }}}

Now do the same for the `{{{ .private }}}` module:

{{{ step "private_init" }}}

_Note: the `{{{ .private }}}` source code repository at {{{ .private_vcs }}} was automatically created for you when this
guide loaded, much like {{{ .public_vcs }}} was created for the `{{{ .public }}}` module. However, the
`{{{ .private }}}` module repository was marked as `Private: true`, hence authenticated access is required to access
{{{ .private_vcs }}}._

Create an initial version of the `{{{ .private_secret }}}` in `{{{ .private_go }}}`:

{{{ step "private_go_initial" }}}

Commit and push this initial version:

{{{ step "private_initial_commit" }}}

### The `{{{ .gopher }}}` module

Now create a `{{{ .gopher }}}` module to try out the `{{{ .public }}}` and `{{{ .private }}}` modules. Unlike
the `{{{ .public }}}` and `{{{ .private }}}` modules, you will not publish the `{{{ .gopher }}}` module; it
will be local only:

{{{ step "gopher_init" }}}

Create an initial version of a `main` package that uses the two modules, in `{{{ .gopher_go }}}`:

{{{ step "gopher_go_initial" }}}

At this point, let's take a small diversion to talk about proxies.

### Module proxies

The `go` command can fetch modules from a proxy or connect to source control
servers directly, according to the setting of the `{{{ .cmdgo.GOPROXY }}}` environment
variable (see `{{{ .go_help_env }}}`). You can see the default setting for `{{{ .cmdgo.GOPROXY }}}` by inspecting
the output of `{{{ .cmdgo.env }}}`:

{{{ step "go_env_check_goproxy" }}}

This means it will try the Go module mirror run by Google and fall back to a direct connection if the proxy reports that
it does not have the module (HTTP error 404 or 410).

The `go` command also defaults to validating downloaded modules, regardless of source,
against the public Go checksum database at [sum.golang.org](https://sum.golang.org), something that is controlled by the
`{{{ .cmdgo.GOSUMDB }}}` environment variable. You can see the default for `{{{ .cmdgo.GOSUMDB }}}` by checking the
output of `{{{ .cmdgo.env }}}`:

{{{ step "go_env_check_gosumdb" }}}

Because your session is already configured with authentication credentials for the source control system that hosts
`{{{ .private_mod }}}`, attempting to `{{{ .cmdgo.get }}}` that module will succeed because the `go` command will
fall back to the `direct` mode.

Let's simulate getting our module dependencies with no credentials by setting `{{{ .cmdgo.GOPROXY }}}` to only use the
public proxy, using the `{{{ .cmdgo.env }}}` command:

{{{ step "goproxy_proxy_only" }}}

Add a dependency on the `{{{ .public }}}` module:

{{{ step "gopher_get_public_initial" }}}

As expected, that succeeded.

Try to add a dependency on the `{{{ .private }}}` module:

{{{ step "gopher_get_private_initial" }}}

Thankfully, this failed.

Let's return `{{{ .cmdgo.GOPROXY }}}` to its default value:

{{{ step "goproxy_proxy_default" }}}

And try once again to add a dependency on the `{{{ .private }}}` module:

{{{ step "gopher_get_private_direct" }}}

This fails because the checksum database is not able to access your `{{{ .private }}}` module. But it's worse than
that, because the `go` command "leaked" a request for `{{{ .private_mod }}}` to the public proxy. This might well be
fine for a trusted proxy like the Google proxy, but it isn't always the case.

### The `{{{ .cmdgo.GOPRIVATE }}}` environment variable

The `{{{ .cmdgo.GOPRIVATE }}}` environment variable controls which modules the `go` command
considers to be private (not available publicly) and should therefore not use the
proxy or checksum database. The variable is a comma-separated list of
glob patterns (in the syntax of Go's [`path.Match`](https://pkg.go.dev/path#Match)) of module path prefixes.

Let's tell the `go` command that `{{{ .private_mod }}}` by setting the `{{{ .cmdgo.GOPRIVATE }}}` environment
variable:

{{{ step "goprivate_set_private" }}}

Try to get the latest version of the `{{{ .private }}}` module again (remember, the `{{{ .public }}}` module
succeeded):

{{{ step "gopher_get_private_goprivate" }}}

Success! As a final check, run the `{{{ .gopher }}}` module `main` package:

{{{ step "gopher_run" }}}

For more details on the `{{{ .cmdgo.GOPRIVATE }}}` environment variable and the values it can take, see
`{{{ .go_help_modprivate }}}`, which also includes examples of how to use the `*` glob to match multiple sub domains
or modules.

The `{{{ .cmdgo.GONOPROXY }}}` and `{{{ .cmdgo.GONOSUMDB }}}` environment variables can be used for more fine
grained control. Again, see `{{{ .go_help_modprivate }}}` for more information.

### Conclusion

This guide has provided you with a brief introduction to handling private modules.

As a next step you might like to consider:

* [Developer tools as module dependencies](/tools-as-dependencies_go119_en/)
* [How to use and tweak Staticcheck](/using-staticcheck_go119_en/)
* [Installing Go](/installing-go_go119_en/)
