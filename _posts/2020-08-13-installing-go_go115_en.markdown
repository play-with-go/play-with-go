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

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Get started with Go](/get-started-with-go/)

### Installing Go

_Note: this guide is running on Linux. For Mac or Windows steps, see the official [Download and
Install](https://golang.org/doc/install) instructions._

Start in your home directory:

<pre data-command-src="cHdkCg=="><code class="language-.term1">$ pwd
/home/gopher
</code></pre>

Download the latest version of Go:

<pre data-command-src="d2dldCAtcSBodHRwczovL2dvbGFuZy5vcmcvZGwvZ28xLjE1LjgubGludXgtYW1kNjQudGFyLmd6Cg=="><code class="language-.term1">$ wget -q https://golang.org/dl/go1.15.8.linux-amd64.tar.gz
</code></pre>

Extract and install:

<pre data-command-src="c3VkbyB0YXIgLUMgL3Vzci9sb2NhbCAteHpmIGdvMS4xNS44LmxpbnV4LWFtZDY0LnRhci5nego="><code class="language-.term1">$ sudo tar -C /usr/local -xzf go1.15.8.linux-amd64.tar.gz
</code></pre>

Add the install target to your profile `PATH`:

<pre data-command-src="ZWNobyBleHBvcnQgUEFUSD0iL3Vzci9sb2NhbC9nby9iaW46JFBBVEgiID4+JEhPTUUvLnByb2ZpbGUK"><code class="language-.term1">$ echo export PATH=&#34;/usr/local/go/bin:$PATH&#34; &gt;&gt;$HOME/.profile
</code></pre>

Source your profile to test the new settings:

<pre data-command-src="c291cmNlICRIT01FLy5wcm9maWxlCg=="><code class="language-.term1">$ source $HOME/.profile
</code></pre>

Verify the Go installation:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.15.8 linux/amd64
</code></pre>

### The Go environment

The `go` command and the tools it invokes consult environment variables
for configuration. If an environment variable is unset, the `go` command
uses a sensible default setting.

Let's examine the default settings in your setup:

<pre data-command-src="Z28gZW52Cg=="><code class="language-.term1">$ go env
GO111MODULE=&#34;&#34;
GOARCH=&#34;amd64&#34;
GOBIN=&#34;&#34;
GOCACHE=&#34;/home/gopher/.cache/go-build&#34;
GOENV=&#34;/home/gopher/.config/go/env&#34;
GOEXE=&#34;&#34;
GOFLAGS=&#34;&#34;
GOHOSTARCH=&#34;amd64&#34;
GOHOSTOS=&#34;linux&#34;
GOINSECURE=&#34;&#34;
GOMODCACHE=&#34;/home/gopher/go/pkg/mod&#34;
GONOPROXY=&#34;&#34;
GONOSUMDB=&#34;&#34;
GOOS=&#34;linux&#34;
GOPATH=&#34;/home/gopher/go&#34;
GOPRIVATE=&#34;&#34;
GOPROXY=&#34;https://proxy.golang.org,direct&#34;
GOROOT=&#34;/usr/local/go&#34;
GOSUMDB=&#34;sum.golang.org&#34;
GOTMPDIR=&#34;&#34;
GOTOOLDIR=&#34;/usr/local/go/pkg/tool/linux_amd64&#34;
GCCGO=&#34;gccgo&#34;
AR=&#34;ar&#34;
CC=&#34;gcc&#34;
CXX=&#34;g++&#34;
CGO_ENABLED=&#34;1&#34;
GOMOD=&#34;&#34;
CGO_CFLAGS=&#34;-g -O2&#34;
CGO_CPPFLAGS=&#34;&#34;
CGO_CXXFLAGS=&#34;-g -O2&#34;
CGO_FFLAGS=&#34;-g -O2&#34;
CGO_LDFLAGS=&#34;-g -O2&#34;
PKG_CONFIG=&#34;pkg-config&#34;
GOGCCFLAGS=&#34;-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build -gno-record-gcc-switches&#34;
</code></pre>

To see the effective setting of a specific variable, for example `GOBIN`, you can run:

<pre data-command-src="Z28gZW52IEdPQklOCg=="><code class="language-.term1">$ go env GOBIN

</code></pre>

To change the default setting of a variable, for example `GOBIN`, you can run:

<pre data-command-src="Z28gZW52IC13IEdPQklOPS9wYXRoL3RvL215L2dvYmluCg=="><code class="language-.term1">$ go env -w GOBIN=/path/to/my/gobin
</code></pre>

Check the new value is set:

<pre data-command-src="Z28gZW52IEdPQklOCg=="><code class="language-.term1">$ go env GOBIN
/path/to/my/gobin
</code></pre>

Defaults changed in this way
are recorded in a Go environment configuration file stored in the
per-user configuration directory, as reported by [`os.UserConfigDir`](https://pkg.go.dev/os#UserConfigDir).
The location of the configuration file can be changed by setting
the environment variable `GOENV`.

Print the effective location of the configuration file:

<pre data-command-src="Z28gZW52IEdPRU5WCg=="><code class="language-.term1">$ go env GOENV
/home/gopher/.config/go/env
</code></pre>

Note, you cannot change the default location of the configuration file.

Unset `GOBIN`, returning to its default value:

<pre data-command-src="Z28gZW52IC13IEdPQklOPQo="><code class="language-.term1">$ go env -w GOBIN=
</code></pre>

Check the effective value of `GOBIN` now:

<pre data-command-src="Z28gZW52IEdPQklOCg=="><code class="language-.term1">$ go env GOBIN

</code></pre>

That is to say, `GOBIN` is not set by default.

See `go help env` for more details.

### Setting up your `PATH`

_Note: this section applies to Linux and Mac users only._

`go get` and `go install` install programs to `$GOPATH/bin`, or
`$GOBIN` if set. `GOBIN` is not set in the `play-with-go.dev` environment:

<pre data-command-src="Z28gZW52IEdPQklOCg=="><code class="language-.term1">$ go env GOBIN

</code></pre>

So you need to add `$GOPATH/bin` to your profile `PATH`:

<pre data-command-src="ZWNobyBleHBvcnQgUEFUSD0iJChnbyBlbnYgR09QQVRIKS9iaW46JFBBVEgiID4+JEhPTUUvLnByb2ZpbGUK"><code class="language-.term1">$ echo export PATH=&#34;$(go env GOPATH)/bin:$PATH&#34; &gt;&gt;$HOME/.profile
</code></pre>

Source your profile again to test the new settings:

<pre data-command-src="c291cmNlICRIT01FLy5wcm9maWxlCg=="><code class="language-.term1">$ source $HOME/.profile
</code></pre>

Verify the new setting of `PATH`:

<pre data-command-src="ZWNobyAkUEFUSAo="><code class="language-.term1">$ echo $PATH
/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
</code></pre>

### Conclusion

That's it! You're all set for working with Go on your local system.

As a next step you might like to consider:

* [Go Fundamentals](/go-fundamentals_go115_en)
<script>let pageGuide="2020-08-13-installing-go"; let pageLanguage="en"; let pageScenario="go115";</script>
