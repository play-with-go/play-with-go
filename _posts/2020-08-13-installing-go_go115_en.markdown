---
category: Next steps
difficulty: Beginner
excerpt: Ready to take the plunge and install Go on your system?!
guide: 2020-08-13-installing-go
lang: en
layout: post
title: Installing Go
---

So you're ready to take the plunge and install Go on your local system? Congratulations!

The official [_Download and Install_](https://golang.org/doc/install) instructions get you quickly up and running with Go.

This guide walks you through those steps, discusses the Go environment, and also explains how to setup your `PATH` for
running any Go programs you install.

### Installing Go

_Note: this guide is running on Linux. For Mac or Windows steps, see the official [Download and
Install](https://golang.org/doc/install) instructions._

Start in your home directory:

```.term1
$ pwd
/home/gopher
```
{:data-command-src="cHdkCg=="}

Download the latest version of Go:

```.term1
$ wget -q https://golang.org/dl/go1.15.5.linux-amd64.tar.gz
```
{:data-command-src="d2dldCAtcSBodHRwczovL2dvbGFuZy5vcmcvZGwvZ28xLjE1LjUubGludXgtYW1kNjQudGFyLmd6Cg=="}

Extract and install:

```.term1
$ sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz
```
{:data-command-src="c3VkbyB0YXIgLUMgL3Vzci9sb2NhbCAteHpmIGdvMS4xNS41LmxpbnV4LWFtZDY0LnRhci5nego="}

Add the install target to your profile `PATH`:

```.term1
$ echo export PATH="/usr/local/go/bin:$PATH" >>$HOME/.profile
```
{:data-command-src="ZWNobyBleHBvcnQgUEFUSD0iL3Vzci9sb2NhbC9nby9iaW46JFBBVEgiID4+JEhPTUUvLnByb2ZpbGUK"}

Source your profile to test the new settings:

```.term1
$ source $HOME/.profile
```
{:data-command-src="c291cmNlICRIT01FLy5wcm9maWxlCg=="}

Verify the Go installation:

```.term1
$ go version
go version go1.15.5 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### The Go environment

The `go` command and the tools it invokes consult environment variables
for configuration. If an environment variable is unset, the `go` command
uses a sensible default setting.

Let's examine the default settings in your setup:

```.term1
$ go env
GO111MODULE=""
GOARCH="amd64"
GOBIN=""
GOCACHE="/home/gopher/.cache/go-build"
GOENV="/home/gopher/.config/go/env"
GOEXE=""
GOFLAGS=""
GOHOSTARCH="amd64"
GOHOSTOS="linux"
GOINSECURE=""
GOMODCACHE="/home/gopher/go/pkg/mod"
GONOPROXY=""
GONOSUMDB=""
GOOS="linux"
GOPATH="/home/gopher/go"
GOPRIVATE=""
GOPROXY="https://proxy.golang.org,direct"
GOROOT="/usr/local/go"
GOSUMDB="sum.golang.org"
GOTMPDIR=""
GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
GCCGO="gccgo"
AR="ar"
CC="gcc"
CXX="g++"
CGO_ENABLED="1"
GOMOD=""
CGO_CFLAGS="-g -O2"
CGO_CPPFLAGS=""
CGO_CXXFLAGS="-g -O2"
CGO_FFLAGS="-g -O2"
CGO_LDFLAGS="-g -O2"
PKG_CONFIG="pkg-config"
GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build -gno-record-gcc-switches"
```
{:data-command-src="Z28gZW52Cg=="}

To see the effective setting of a specific variable, for example `GOBIN`, you can run:

```.term1
$ go env GOBIN

```
{:data-command-src="Z28gZW52IEdPQklOCg=="}

To change the default setting of a variable, for example `GOBIN`, you can run:

```.term1
$ go env -w GOBIN=/path/to/my/gopath
```
{:data-command-src="Z28gZW52IC13IEdPQklOPS9wYXRoL3RvL215L2dvcGF0aAo="}

Check the new value is set:

```.term1
$ go env GOBIN
/path/to/my/gopath
```
{:data-command-src="Z28gZW52IEdPQklOCg=="}

Defaults changed in this way
are recorded in a Go environment configuration file stored in the
per-user configuration directory, as reported by [`os.UserConfigDir`](https://pkg.go.dev/os#UserConfigDir).
The location of the configuration file can be changed by setting
the environment variable `GOENV`.

Print the effective location of the configuration file:

```.term1
$ go env GOENV
/home/gopher/.config/go/env
```
{:data-command-src="Z28gZW52IEdPRU5WCg=="}

Note, you cannot change the default location of the configuration file.

Unset `GOBIN`, returning to its default value:

```.term1
$ go env -w GOBIN=
```
{:data-command-src="Z28gZW52IC13IEdPQklOPQo="}

Check the effective value of `GOBIN` now:

```.term1
$ go env GOBIN

```
{:data-command-src="Z28gZW52IEdPQklOCg=="}

That is to say, `GOBIN` is not set by default.

See `go help env` for more details.

### Setting up your `PATH`

_Note: this section applies to Linux and Mac users only._

`go get` and `go install` install programs to `$GOPATH/bin`, or
`$GOBIN` if set. `GOBIN` is not set in the `play-with-go.dev` environment:

```.term1
$ go env GOBIN

```
{:data-command-src="Z28gZW52IEdPQklOCg=="}

So you need to add `$GOPATH/bin` to your profile `PATH`:

```.term1
$ echo export PATH="$(go env GOPATH)/bin:$PATH" >>$HOME/.profile
```
{:data-command-src="ZWNobyBleHBvcnQgUEFUSD0iJChnbyBlbnYgR09QQVRIKS9iaW46JFBBVEgiID4+JEhPTUUvLnByb2ZpbGUK"}

Source your profile again to test the new settings:

```.term1
$ source $HOME/.profile
```
{:data-command-src="c291cmNlICRIT01FLy5wcm9maWxlCg=="}

Verify the new setting of `PATH`:

```.term1
$ echo $PATH
/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
```
{:data-command-src="ZWNobyAkUEFUSAo="}

### Conclusion

That's it! You're all set for working with Go on your local system.
<script>let pageGuide="2020-08-13-installing-go"; let pageLanguage="en"; let pageScenario="go115";</script>
