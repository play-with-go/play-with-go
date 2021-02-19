---
category: What's coming in Go 1.16
difficulty: Beginner
excerpt: Simple easy-to-remember way to install Go programs
guide: 2020-11-09-installing-go-programs-directly
lang: en
layout: post
title: Installing Go programs directly
---

_By [Daniel Martí](https://mvdan.cc), Go contributor, maintainer of [`encoding/json`](https://pkg.go.dev/encoding/json),
and tool author._

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a short one-liner they
can include at the top of their `README.md` explaining how to install the tool.

Go 1.16 introduces a new way to install Go programs directly with the `go` command. This guide
introduces the new mode of `go install` using the example of
[`filippo.io/mkcert`](https://mkcert.io/), and is suitable for both end users and tool authors.

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go115_en)

This guide is running with:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.16 linux/amd64
</code></pre>

### Background

Currently, tool authors who want to provide installation instructions in their projects' `README.md` typically include:

<pre data-command-src="Z28gZ2V0IGZpbGlwcG8uaW8vbWtjZXJ0QHYxLjQuMgo="><code class="language-.term1">$ go get filippo.io/mkcert@v1.4.2
go: downloading filippo.io/mkcert v1.4.2
go: downloading golang.org/x/net v0.0.0-20190620200207-3b0461eec859
go: downloading golang.org/x/tools v0.0.0-20191108193012-7d206e10da11
go: downloading honnef.co/go/tools v0.0.0-20191107024926-a9480a3ec3bc
go: downloading howett.net/plist v0.0.0-20181124034731-591f970eefbb
go: downloading software.sslmate.com/src/go-pkcs12 v0.0.0-20180114231543-2291e8f0f237
go: downloading golang.org/x/text v0.3.0
go: downloading github.com/BurntSushi/toml v0.3.1
</code></pre>

_Note: most `README.md` instructions that use `go get` do not specify a version. This results in the latest
version of a package being fetched. A specific version, `v1.4.2`, is used here to ensure this guide
remains reproducible._

There are a number of problems with this approach:

* A user might run the above `go get` within a module, which would
  update the current module's dependencies, rather than just installing the tool directly.
* `go get` might not be running in module mode at all, for example
  if the user previously modified `GO111MODULE`.
* The use of `go get` is confusing; it is used to download and install executables,
  but it's also responsible for managing dependencies in `go.mod` files.

Prior to Go 1.16, the general advice to fix the first two problems was to use a snippet
which runs `go get` in module mode and outside any module, by using a temporary directory:

<pre data-command-src="KGNkICQobWt0ZW1wIC1kKTsgR08xMTFNT0RVTEU9b24gZ28gZ2V0IGZpbGlwcG8uaW8vbWtjZXJ0QHYxLjQuMikK"><code class="language-.term1">$ (cd $(mktemp -d); GO111MODULE=on go get filippo.io/mkcert@v1.4.2)
</code></pre>

However, this new approach had its own problems:

* It's not user-friendly; the extra shell is confusing to newcomers, and hard to remember.
* It's not cross platform; the command is not guaranteed to work on Windows.

It is clear that neither method is satisfactory, especially for `README.md`
instructions which are meant to be brief and easy to follow.

### `go install` in Go 1.16

In Go 1.16, the `go install` command is now used to install programs directly, i.e. regardless of the current
module context:

<pre data-command-src="Z28gaW5zdGFsbCBmaWxpcHBvLmlvL21rY2VydEB2MS40LjIK"><code class="language-.term1">$ go install filippo.io/mkcert@v1.4.2
</code></pre>

For the purposes of this guide you are using a specific version (`v1.4.2`). Alternatively,
the special `latest` version can be used to install the latest release.

Much like the previous behaviour of `go get`, `go install` places binaries in `$GOPATH/bin`,
or in `$GOBIN` if set. See the _"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go115_en) to ensure
your `PATH` is set correctly.

Verify that `mkcert` is now on your `PATH`:

<pre data-command-src="d2hpY2ggbWtjZXJ0Cg=="><code class="language-.term1">$ which mkcert
/home/gopher/go/bin/mkcert
</code></pre>

Run `mkcert` to check everything is working:

<pre data-command-src="bWtjZXJ0IC12ZXJzaW9uCg=="><code class="language-.term1">$ mkcert -version
v1.4.2
</code></pre>

You can also use `go version` to see the module dependencies used in building the program:

<pre data-command-src="Z28gdmVyc2lvbiAtbSAkKHdoaWNoIG1rY2VydCkK"><code class="language-.term1">$ go version -m $(which mkcert)
/home/gopher/go/bin/mkcert: go1.16
	path	filippo.io/mkcert
	mod	filippo.io/mkcert	v1.4.2	h1:7mWofpFS4gzQS5bhE3KYBwzfceIPy2KJ4tMT31aPNeY=
	dep	golang.org/x/net	v0.0.0-20190620200207-3b0461eec859	h1:R/3boaszxrf1GEUWTVDzSKVwLmSJpwZ1yqXm8j0v2QI=
	dep	golang.org/x/text	v0.3.0	h1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
	dep	software.sslmate.com/src/go-pkcs12	v0.0.0-20180114231543-2291e8f0f237	h1:iAEkCBPbRaflBgZ7o9gjVUuWuvWeV4sytFWg9o+Pj2k=
</code></pre>

To eliminate redundancy and confusion, using `go get` to build or
install programs is being deprecated in Go 1.16.

### Conclusion

That's it! Time to sit back and wait for the release of Go 1.16!

As a next step you might like to consider:

* [Retract Module Versions](/retract-module-versions_go116_en/)
<script>let pageGuide="2020-11-09-installing-go-programs-directly"; let pageLanguage="en"; let pageScenario="go116";</script>
