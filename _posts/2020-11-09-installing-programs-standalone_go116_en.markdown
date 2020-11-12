---
category: What's coming in Go 1.16
difficulty: Beginner
excerpt: Simple easy-to-remember way to install Go programs
guide: 2020-11-09-installing-programs-standalone
lang: en
layout: post
title: Installing Go programs standalone
---

_By [Daniel Martí](https://twitter.com/mvdan_)_

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a simple one-liner they
can include at the top of their `README.md` files explaining how to get started.

Go 1.16 introduces a new, much simpler way to install Go programs standalone with the `go` command. This guide
introduces the new mode of `go install` using the example of
[`honnef.co/go/tools/cmd/staticcheck`](https://staticcheck.io/), and is suitable for end users and tool authors.

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Tutorial: Get started with Go](/get-started-with-go/)

This guide is running using:

```.term1
$ go version
go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### Background

Prior to Go 1.16, tool authors who wanted to provide installation instructions in their projects' `README.md` files were
advised to use something like this:

```.term1
$ (cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6)
go: downloading honnef.co/go/tools v0.0.1-2020.1.6
go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
go: downloading github.com/BurntSushi/toml v0.3.1
```
{:data-command-src="KGNkICQobWt0ZW1wIC1kKTsgR08xMTFNT0RVTEU9b24gZ28gZ2V0IGhvbm5lZi5jby9nby90b29scy9jbWQvc3RhdGljY2hlY2tAdjAuMC4xLTIwMjAuMS42KQo="}

There are a number of problems with this:

* It's ugly not at all user-friendly; it's not obvious to a newcomer to the language what is going on
* It's not cross platform, in particular this command is not guaranteed to work on Windows
* The use of `go get` is confusing. `go get` is used to download and install executables,
  but it‘s also responsible for managing dependencies in `go.mod` files

So what's going on in this command?

* The change to a temporary directory (`mktemp -d`) ensures that the remainder of the command is run outside of
  a module. Without this, it is possible that a user might run `go get` within a module, and hence the
`go get` command would update the current module's dependencies, rather than installing the tool
standalone
* The setting of `GO111MODULE` ensures that `go get` runs in module mode outside of a
  module (if the variable is unset it will run in `GOPATH` mode)

The length of this explanation is reason enough to simplify things!

### `go install` in Go 1.16

In Go 1.16, `go install` command is used to install programs standalone, i.e. regardless of the current
module context:

```.term1
$ go install honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6
```
{:data-command-src="Z28gaW5zdGFsbCBob25uZWYuY28vZ28vdG9vbHMvY21kL3N0YXRpY2NoZWNrQHYwLjAuMS0yMDIwLjEuNgo="}

For the purposes of this guide you are using a specific version (`v0.0.1-2020.1.6`). As an alternative,
the special `latest` version specified could be used to install the latest version.

Much like the previous behaviour of `go get`, `go install` installs binaries to
`$GOPATH/bin`, or `$GOBIN` if set. Let's confirm your setup using `go env`:

```.term1
$ go env GOPATH
/home/gopher/go
$ go env GOBIN

```
{:data-command-src="Z28gZW52IEdPUEFUSApnbyBlbnYgR09CSU4K"}

`GOBIN` is not set. Therefore as a one off, add `$GOPATH/bin` to your `PATH`:

```.term1
$ export PATH="$(go env GOPATH)/bin:$PATH"
```
{:data-command-src="ZXhwb3J0IFBBVEg9IiQoZ28gZW52IEdPUEFUSCkvYmluOiRQQVRIIgo="}

Verify that `staticcheck` is now on your `PATH`:

```.term1
$ which staticcheck
/home/gopher/go/bin/staticcheck
```
{:data-command-src="d2hpY2ggc3RhdGljY2hlY2sK"}

Run `staticcheck` to check everything is working:

```.term1
$ staticcheck -version
staticcheck 2020.1.6
```
{:data-command-src="c3RhdGljY2hlY2sgLXZlcnNpb24K"}

You can also use `go version` to see the module dependencies used in building the program:

```.term1
$ go version -m $(which staticcheck)
/home/gopher/go/bin/staticcheck: devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000
	path	honnef.co/go/tools/cmd/staticcheck
	mod	honnef.co/go/tools	v0.0.1-2020.1.6	h1:W18jzjh8mfPez+AwGLxmOImucz/IFjpNlrKVnaj2YVc=
	dep	github.com/BurntSushi/toml	v0.3.1	h1:WXkYYl6Yr3qBf1K79EBnL4mak0OimBfB0XUf9Vl28OQ=
	dep	golang.org/x/tools	v0.0.0-20200410194907-79a7a3126eef	h1:RHORRhs540cYZYrzgU2CPUyykkwZM78hGdzocOo9P8A=
	dep	golang.org/x/xerrors	v0.0.0-20191204190536-9bdfabe68543	h1:E7g+9GITq07hpfrRu66IVDexMakfv52eLZ2CXBWiKr4=
```
{:data-command-src="Z28gdmVyc2lvbiAtbSAkKHdoaWNoIHN0YXRpY2NoZWNrKQo="}

To eliminate redundancy and confusion, the `go get` approach used in Go 1.15 and before is being
deprecated.


<script>let pageGuide="2020-11-09-installing-programs-standalone"; let pageLanguage="en"; let pageScenario="go116";</script>
