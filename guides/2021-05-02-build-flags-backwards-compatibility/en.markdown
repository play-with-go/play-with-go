---
layout: post
title:  "Using build flags for backwards compatibility"
excerpt: "How to leverage go build flags to avoid breaking downstream projects "
difficulty: Intermediate
category: Next steps
---

_By [Marcos Nils](https://twitter.com/marcosnils), [Docker Captain](https://www.docker.com/captains/marcos-lilljedahl), Hashicorp Ambassador, Go developer, and co-creator of `play-with-go.dev`._

Sometimes, when a new `go` version is released, it also ships with a bunch of changes and really interesting features on the standard library.
As the time of this article, [go 1.16](https://golang.org/doc/go1.16) has been released around two months ago which introduces some changes and
new features into the [core library](https://golang.org/doc/go1.16#library) like the new `io.FS` interface, the `embed` directive amongst others. 

It's usually common to see developers wanting to adopt all these new features and refactor their code so they can take
advantage of these interfaces to make their applications and libraries more modular, testable and sometimes
even more performant. However, it's important to understand how these changes, if not done carefuly, can
sometimes break downstream dependencies given that in the case of `go`, when you're importing a third party module,
you're forced to build your project with the latest version of the complete dependency tree. 

This guide explains how to deal with situations where you want to use new features of recent versions of `go`
and at the same time you don't want to force downstream dependecies to upgrade. In this case we'll be using 
conditional compilation through `go build` tags in a real case scenario by using `go` 1.15 and 1.16 new `io.FS`
package respectively. 


### A simple go 1.15 program using ioutil.Discard

Let's start by checking our current `go` 1.15 version:

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


Let's go back to our `{{{ .gopher }}}` module in `go` 1.15 and try to fetch
the latest version of the `{{{ .public }}}` dependecy and see what happens

{{{ step "go115default1" }}}

{{{ step "gopher_update_fail" }}}


As you can see, when trying to bump our `{{[ .gopher ]}}` project, we got an 
error because in our case, we're still using `go` 1.15 in our project which
doesn't support the new `io.Discard` package.

How do we handle these situations where we shouldn't force our clients to update?
The right approach to tackle this is by using `build tag` so our `{{{ .public }}}`
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

{{{ step "gopher_update_ok" }}}


### Conclusion

This guide has provided you with a brief introduction to handling private modules.

As a next step you might like to consider:

* [Developer tools as module dependencies](/tools-as-dependencies_go115_en/)
* [How to use and tweak Staticcheck](/using-staticcheck_go115_en/)
* [Installing Go](/installing-go_go115_en/)
