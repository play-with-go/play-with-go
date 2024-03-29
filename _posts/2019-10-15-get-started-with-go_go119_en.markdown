---
category: Start here
difficulty: Beginner
excerpt: You've completed the Go tour, so what next? This guide gives a brief introduction
  to Go programming
guide: 2019-10-15-get-started-with-go
lang: en
layout: post
redirect_from:
- /get-started-with-go_go115_en/
title: Get started with Go
---

_This guide is based on the official ["Getting started"](https://golang.org/doc/tutorial/getting-started.html)
tutorial._

In this guide we present a brief introduction to Go programming. You will:

* Write some simple "Hello, world" code
* Use the `go` command to run your code
* Use the Go package discovery site to find packages you can use in your own code
* Call functions of an external module

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev_go119_en/)

This guide is running using:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.19.1 linux/amd64
</code></pre>

### Write some code

As with all play-with-go.dev guides, we start in our home directory:

<pre data-command-src="cHdkCg=="><code class="language-.term1">$ pwd
/home/gopher
</code></pre>

Create a hello directory for your first Go source code:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2hlbGxvCmNkIC9ob21lL2dvcGhlci9oZWxsbwo="><code class="language-.term1">$ mkdir /home/gopher/hello
$ cd /home/gopher/hello
</code></pre>

Create the file `hello.go` in `/home/gopher/hello`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGxuKCJIZWxsbywgV29ybGQhIikKfQo=" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

func main() &#123;
	fmt.Println(&#34;Hello, World!&#34;)
&#125;
</code></pre>

This is your first `.go` file! In this code you:

* Declare a `main` package (a package is a way to group related code and concepts).
* Import the popular [`fmt`](https://golang.org/pkg/fmt/) package, which contains functions for formatting text,
  including printing to the console. This package is one of the [standard library](https://golang.org/pkg/) packages you
  got when you installed Go.
* Implement a `main` function to print a message to the console. A `main` function executes by default when you run code
  in the file.

Run your code to see the greeting:

<pre data-command-src="Z28gcnVuIGhlbGxvLmdvCg=="><code class="language-.term1">$ go run hello.go
Hello, World!
</code></pre>

### Call code in an external package

When you want your code to do something that might have been implemented by someone else, you can look for a package
that has the functionality you need.

Let's make your printed message a little more interesting by using a function from an another package.

1. Visit [pkg.go.dev](https://pkg.go.dev) and [search for a "quote" package](https://pkg.go.dev/search?q=quote).
1. Locate and click the `rsc.io/quote` package in search results (if you see `rsc.io/quote/v3`, ignore it for now).
1. On the **Doc** tab, under **Index**, note the list of functions you can call from your code. You will use the `Go`
   function.
1. At the top of this page, note that package quote is included in the `rsc.io/quote` module
1. On the **Versions** tab, note the list of available versions of the `rsc.io/quote` module.

Packages are published in modules -- like `rsc.io/quote` -- where others can use them. Modules are improved with new
versions over time, and you can upgrade your code to use the improved versions. You can use
[pkg.go.dev](https://pkg.go.dev) to discover published modules whose packages have functions you can use in your own
code.

_Modules can contain multiple packages. In the case of the the `rsc.io/quote` module, it contains just one package:
`rsc.io/quote`._

Let's import the `rsc.io/quote` package and add a call to its `Go` function:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCmltcG9ydCAicnNjLmlvL3F1b3RlIgoKZnVuYyBtYWluKCkgewoJZm10LlByaW50bG4ocXVvdGUuR28oKSkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

<b>import &#34;rsc.io/quote&#34;</b>
<b></b>
func main() &#123;
<b>	fmt.Println(quote.Go())</b>
&#125;
</code></pre>

To import packages from another module, your code must belong to a module. Go modules are identified by a `go.mod` file
in a directory. A `go.mod` file lists the specific modules and versions providing those packages. That file stays with
your code, including in your source code repository. We refer to `hello` as the current development
module.

To create a module and its `go.mod` file, run the `go mod init` command, giving it the name of the module your
code will be in (here, just use `hello`):

<pre data-command-src="Z28gbW9kIGluaXQgaGVsbG8K"><code class="language-.term1">$ go mod init hello
go: creating new go.mod: module hello
go: to add module requirements and sums:
	go mod tidy
</code></pre>

Our `main` package now belongs to the `hello` module.

We need to declare a dependency on the `rsc.io/quote` module, specifically version `v1.5.2`:

<pre data-command-src="Z28gZ2V0IHJzYy5pby9xdW90ZUB2MS41LjIK"><code class="language-.term1">$ go get rsc.io/quote@v1.5.2
go: downloading rsc.io/quote v1.5.2
go: downloading rsc.io/sampler v1.3.0
go: downloading golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
go: added golang.org/x/text v0.0.0-20170915032832-14c0d48ead0c
go: added rsc.io/quote v1.5.2
go: added rsc.io/sampler v1.3.0
</code></pre>

[`go get`](https://golang.org/cmd/go/#hdr-Add_dependencies_to_current_module_and_install_them) resolves and adds
dependencies to the current development module, `hello` in our case.

Re-run your code to see the message generated by the function you're calling.

<pre data-command-src="Z28gcnVuIGhlbGxvLmdvCg=="><code class="language-.term1">$ go run hello.go
Don&#39;t communicate by sharing memory, share memory by communicating.
</code></pre>

Notice that your code calls the Go function, printing a clever message about communication.

### Conclusion

With this quick introduction, you learned some of the basics.

As a next step you might like to consider:

* [Go Fundamentals](/go-fundamentals_go119_en)

<script>let pageGuide="2019-10-15-get-started-with-go"; let pageLanguage="en"; let pageScenario="go119";</script>
