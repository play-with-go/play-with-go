---
layout: post
title:  "Using build flags for backwards compatibility"
excerpt: "How to leverage go build flags to avoid breaking downstream projects "
difficulty: Intermediate
category: Next steps
---

_By [Marcos Nils](https://twitter.com/marcosnils), [Docker Captain](https://www.docker.com/captains/marcos-lilljedahl), Hashicorp Ambassador, Go developer, and co-creator of `play-with-go.dev`._

Sometimes, when a new `go` version is released, it also ships with a bunch of changes and really interesting features in the standard library.
At the time of this article, [go 1.16](https://golang.org/doc/go1.16) has been released around two months ago which introduces some changes and
new features into the [core library](https://golang.org/doc/go1.16#library) like the new `io.FS` interface, the `go:embed` directive amongst others.

As a module author, how could I introduce these new features and at the same time provide some guarantees that
my module can still support the last N releases of go?

This guide explains how to deal with situations where you want to use new features of recent versions of `go`
and at the same time you don't want to force downstream dependats to upgrade. In this case we'll be using
conditional compilation through build tags in a real life scenario by using 1.16's new io.FS whilst retaining compatibility for users of `go` 1.15.

Here's a high level overview of the steps you'll accomplish following this guide:

- Create a `{{{ .public }}}` module that contains and exports a `{{{ .public_func }}}` function
- Create a `{{{ .gopher }}}` module that uses the `{{{ .public }}}`module
- Bump the `{{{ .public }}}` module to use `go` 1.16 features without any considerations
- Try updating the `{{{ .gopher }}}` module and show the observed errors
- Fix the `{{{ .public }}}` module by adding required buid tags.


### A simple go 1.15 program using ioutil.Discard

Verifying that we're using `go` 1.15 version:

{{{ step "go115version" }}}

Now, we'll also check that we have `go` 1.16 installed as well:

{{{ step "go116version" }}}


We'll start by setting `go` 1.15 as the default working version:

{{{ step "go115default" }}}

Start by a new `public` module:

{{{ step "public_init" }}}

Now, we'll upload a simple `go` program that uses 1.15 `ioutil.Discard` in a public function:

Create an initial version of the `{{{ .public_func }}}` in `{{{ .public_go }}}`:

{{{ step "public_go_initial" }}}

Commit and push this initial version:

{{{ step "public_initial_commit" }}}

### The `{{{ .gopher }}}` module

Now create a `{{{ .gopher }}}` module to try out the `{{{ .public }}}` module. Unlike
the `{{{ .public }}}` module, you will not publish the `{{{ .gopher }}}` module; it
will be local only:

{{{ step "gopher_init" }}}

Create an initial version of a `main` package that uses the previous public module, in `{{{ .gopher_go }}}`:

{{{ step "gopher_go_initial" }}}


Get the initial version of the `{{{.gopher}}}` module:

{{{ step "gopher_get" }}}

Now, we'll run the `{{{ .gopher }}}` module `main` package:

{{{ step "gopher_run" }}}


### Bumping the `{{{ .public }}}` dependency to `go` 1.16

`Go` 1.16 has been released, and as good developers we want to refactor our
code so it uses the new `io.Discard` variable instead of the deprecated `ioutil` one.


First, we set our `go` version to 1.16:

{{{ step "go116default" }}}

Now, we change our original `{{{ .public }}}` module to use the new variable.

{{{ step "public_bump_discard"}}}


Now we're good to release a new version of our `{{{ .public }}}` module
using the `go` 1.16 new package:

{{{ step "public_bump_commit"}}}


Let's go back to our `{{{ .gopher }}}` module in `go` 1.15, fetch the latest
version of the `{{{ .public }}}` dependecy and see what happens when we try and
run again:

{{{ step "go115default1" }}}

{{{ step "gopher_update" }}}

{{{ step "gopher_run_fail" }}}

As you can see, when trying to run our `{{{ .gopher }}}` project using the
latest `{{{.public}}}`, we got an error because in our case, we're still using
`go` 1.15 in the gopher project which doesn't support the new `io.Discard`
package.

How do we handle these situations where we shouldn't force our clients to update?
The right approach to tackle this is by using [build constraints](https://pkg.go.dev/go/build#hdr-Build_Constraints) so our `{{{ .public }}}`
clients can build their project regardless of the `go` version they're using


### Adding `build` tags to our `{{{ .public }}}` project

Let's go ahead and modify our `{{{ .public }}}` project so it now uses the
`// +build 1.16` tag.

First we rollback the changes to our original file to keep using the `ioutil.Discard`
pacage for `go` < 1.16 clients

{{{ step "public_rollback_mod" }}}

Additionally, we create a new file which has the correct build tag, so
newer clients can make use of the new package

{{{ step "public_add_buildtag" }}}

Let's now publish our fixed module

{{{ step "public_fix_commit"}}}


Now, we can go ahead and update our `{{{ .gopher }}}` without problems with the
benefit that `go` 1.16 clients and future clients will be able to use make
use of the newer `go` features and packages.

{{{ step "gopher_update_fix" }}}

{{{ step "gopher_run_fix" }}}


### Conclusion

This guide serves as an example on how to leverage on [build constraints](https://pkg.go.dev/go/build#hdr-Build_Constraints)
to provide a backwards compatbile module to your clients. Build constraints are a very
powerful pattern to achieve other tasks in `go`. We encourage the reader to check the official docs
for further examples.

As a next step you might like to consider:

* [Wokring with private modules](/working-with-private-modules_go115_en/)
* [Retract module versions](/retract-module-versions_go116_en/)
