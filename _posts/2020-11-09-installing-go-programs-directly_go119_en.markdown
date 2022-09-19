---
category: Next steps
difficulty: Beginner
excerpt: Simple easy-to-remember way to install Go programs
guide: 2020-11-09-installing-go-programs-directly
lang: en
layout: post
redirect_from:
- /installing-go-programs-directly_go115_en/
title: Installing Go programs directly
---

_By [Daniel Martí](https://mvdan.cc), Go contributor, maintainer of [`encoding/json`](https://pkg.go.dev/encoding/json),
and tool author._

Users need a simple, easy-to-remember way to install Go programs. Similarly, tool authors need a short one-liner they
can include at the top of their `README.md` explaining how to install the tool.

Go 1.16 introduced a new way to install Go programs directly with the `go` command. This guide
introduces the new mode of `go install` using the example of
[`filippo.io/mkcert`](https://filippo.io/mkcert), and is suitable for both end users and tool authors.

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go119_en)

This guide is running with:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.19.1 linux/amd64
</code></pre>

### `go install` in Go 1.16

As of Go 1.16, the `go install` command is now used to install
programs directly, i.e. regardless of the current module context:

<pre data-command-src="Z28gaW5zdGFsbCBmaWxpcHBvLmlvL21rY2VydEB2MS40LjQK"><code class="language-.term1">$ go install filippo.io/mkcert@v1.4.4
go: downloading filippo.io/mkcert v1.4.4
go: downloading golang.org/x/net v0.0.0-20220421235706-1d1ef9303861
go: downloading software.sslmate.com/src/go-pkcs12 v0.2.0
go: downloading golang.org/x/text v0.3.7
go: downloading golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29
</code></pre>

For the purposes of this guide you are using a specific version (`v1.4.4`). Alternatively,
the special `latest` version can be used to install the latest release.

Much like the previous behaviour of `go get`, `go install` places binaries in `$GOPATH/bin`,
or in `$GOBIN` if set. See the _"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go119_en) to ensure
your `PATH` is set correctly.

Verify that `mkcert` is now on your `PATH`:

<pre data-command-src="d2hpY2ggbWtjZXJ0Cg=="><code class="language-.term1">$ which mkcert
/home/gopher/go/bin/mkcert
</code></pre>

Run `mkcert` to check everything is working:

<pre data-command-src="bWtjZXJ0IC12ZXJzaW9uCg=="><code class="language-.term1">$ mkcert -version
v1.4.4
</code></pre>

You can also use `go version` to see the module dependencies used in building the program:

<pre data-command-src="Z28gdmVyc2lvbiAtbSAkKHdoaWNoIG1rY2VydCkK"><code class="language-.term1">$ go version -m $(which mkcert)
/home/gopher/go/bin/mkcert: go1.19.1
	path	filippo.io/mkcert
	mod	filippo.io/mkcert	v1.4.4	h1:8eVbbwfVlaqUM7OwuftKc2nuYOoTDQWqsoXmzoXZdbc=
	dep	golang.org/x/crypto	v0.0.0-20220331220935-ae2d96664a29	h1:tkVvjkPTB7pnW3jnid7kNyAMPVWllTNOf/qKDze4p9o=
	dep	golang.org/x/net	v0.0.0-20220421235706-1d1ef9303861	h1:yssD99+7tqHWO5Gwh81phT+67hg+KttniBr6UnEXOY8=
	dep	golang.org/x/text	v0.3.7	h1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=
	dep	software.sslmate.com/src/go-pkcs12	v0.2.0	h1:nlFkj7bTysH6VkC4fGphtjXRbezREPgrHuJG20hBGPE=
</code></pre>

To eliminate redundancy and confusion, using `go get` to build or
install programs is being deprecated in Go 1.16.

### Conclusion

That's it!

As a next step you might like to consider:

* [Retract Module Versions](/retract-module-versions_go119_en/)
<script>let pageGuide="2020-11-09-installing-go-programs-directly"; let pageLanguage="en"; let pageScenario="go119";</script>
