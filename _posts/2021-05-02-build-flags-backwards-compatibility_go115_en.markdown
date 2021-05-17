---
category: Next steps
difficulty: Intermediate
excerpt: 'How to leverage go build flags to avoid breaking downstream projects '
guide: 2021-05-02-build-flags-backwards-compatibility
lang: en
layout: post
title: Using build flags for backwards compatibility
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

- Create a `public` module that contains and exports a `DoSomething()` function
- Create a `gopher` module that uses the `public`module
- Bump the `public` module to use `go` 1.16 features without any considerations
- Try updating the `gopher` module and show the observed errors
- Fix the `public` module by adding required buid tags.


### A simple go 1.15 program using ioutil.Discard

Verifying that we're using `go` 1.15 version:

<pre data-command-src="Z28xMTUgdmVyc2lvbgo="><code class="language-.term1">$ go115 version
go version go1.15.8 linux/amd64
</code></pre>

Now, we'll also check that we have `go` 1.16 installed as well:

<pre data-command-src="Z28xMTYgdmVyc2lvbgo="><code class="language-.term1">$ go116 version
go version go1.16.3 linux/amd64
</code></pre>


We'll start by setting `go` 1.15 as the default working version:

<pre data-command-src="YWxpYXMgZ289Z28xMTUK"><code class="language-.term1">$ alias go=go115
</code></pre>

Start by a new `public` module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3B1YmxpYwpjZCAvaG9tZS9nb3BoZXIvcHVibGljCmdvIG1vZCBpbml0IHt7ey5QVUJMSUN9fX0KZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlBVQkxJQ319fS5naXQK"><code class="language-.term1">$ mkdir /home/gopher/public
$ cd /home/gopher/public
$ go mod init &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
go: creating new go.mod: module &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
$ git init -q
$ git remote add origin https://&#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;.git
</code></pre>

Now, we'll upload a simple `go` program that uses 1.15 `ioutil.Discard` in a public function:

Create an initial version of the `DoSomething()` in `public.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3B1YmxpYw==" data-upload-src="cHVibGljLmdv:cGFja2FnZSBwdWJsaWMKCmltcG9ydCAoCiAgICAiZm10IgogICAgImlvL2lvdXRpbCIKKQoKZnVuYyBEb1NvbWV0aGluZygpIHsKICAgIGZtdC5GcHJpbnRmKGlvdXRpbC5EaXNjYXJkLCAiVGhpcyBkb2Vzbid0IHByaW50IGFueXRoaW5nIikKfQ==" data-upload-term=".term1"><code class="language-go">package public

import (
    &#34;fmt&#34;
    &#34;io/ioutil&#34;
)

func DoSomething() &#123;
    fmt.Fprintf(ioutil.Discard, &#34;This doesn&#39;t print anything&#34;)
&#125;</code></pre>

Commit and push this initial version:

<pre data-command-src="Z2l0IGFkZCBwdWJsaWMuZ28gZ28ubW9kCmdpdCBjb21taXQgLXEgLW0gJ0luaXRpYWwgY29tbWl0IG9mIHB1YmxpYyBtb2R1bGUnCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCg=="><code class="language-.term1">$ git add public.go go.mod
$ git commit -q -m &#39;Initial commit of public module&#39;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>

### The `gopher` module

Now create a `gopher` module to try out the `public` module. Unlike
the `public` module, you will not publish the `gopher` module; it
will be local only:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dvcGhlcgpjZCAvaG9tZS9nb3BoZXIvZ29waGVyCmdvIG1vZCBpbml0IGdvcGhlcgo="><code class="language-.term1">$ mkdir /home/gopher/gopher
$ cd /home/gopher/gopher
$ go mod init gopher
go: creating new go.mod: module gopher
</code></pre>

Create an initial version of a `main` package that uses the previous public module, in `gopher.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcg==" data-upload-src="Z29waGVyLmdv:cGFja2FnZSBtYWluCgppbXBvcnQgKAoKInt7ey5QVUJMSUN9fX0iCikKCmZ1bmMgbWFpbigpIHsKICAgIHB1YmxpYy5Eb1NvbWV0aGluZygpCn0K" data-upload-term=".term1"><code class="language-go">package main

import (

&#34;&#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;&#34;
)

func main() &#123;
    public.DoSomething()
&#125;
</code></pre>


Get the initial version of the `gopher` module:

<pre data-command-src="Z28gZ2V0IC1kIHt7ey5QVUJMSUN9fX1AbGF0ZXN0Cg=="><code class="language-.term1">$ go get -d &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;@latest
go: downloading &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
go: &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; latest =&gt; v0.0.0-20060102150405-abcedf12345
</code></pre>

Now, we'll run the `gopher` module `main` package:

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
</code></pre>


### Bumping the `public` dependency to `go` 1.16

`Go` 1.16 has been released, and as good developers we want to refactor our
code so it uses the new `io.Discard` variable instead of the deprecated `ioutil` one.


First, we set our `go` version to 1.16:

<pre data-command-src="YWxpYXMgZ289Z28xMTYK"><code class="language-.term1">$ alias go=go116
</code></pre>

Now, we change our original `public` module to use the new variable.

<pre data-upload-path="L2hvbWUvZ29waGVyL3B1YmxpYw==" data-upload-src="cHVibGljLmdv:cGFja2FnZSBwdWJsaWMKCmltcG9ydCAoCiAgICAiZm10IgogICAgImlvIgopCgpmdW5jIERvU29tZXRoaW5nKCkgewogICAgZm10LkZwcmludGYoaW8uRGlzY2FyZCwgIlRoaXMgZG9lc24ndCBwcmludCBhbnl0aGluZyIpCn0=" data-upload-term=".term1"><code class="language-go">package public

import (
    &#34;fmt&#34;
    &#34;io&#34;
)

func DoSomething() &#123;
    fmt.Fprintf(io.Discard, &#34;This doesn&#39;t print anything&#34;)
&#125;</code></pre>


Now we're good to release a new version of our `public` module
using the `go` 1.16 new package:

<pre data-command-src="Y2QgL2hvbWUvZ29waGVyL3B1YmxpYwpnaXQgYWRkIHB1YmxpYy5nbyBnby5tb2QKZ2l0IGNvbW1pdCAtcSAtbSAnQnVtcCBwdWJsaWMgdG8gZ28xLjE2JwpnaXQgcHVzaCAtcSBvcmlnaW4gbWFpbgo="><code class="language-.term1">$ cd /home/gopher/public
$ git add public.go go.mod
$ git commit -q -m &#39;Bump public to go1.16&#39;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>


Let's go back to our `gopher` module in `go` 1.15, fetch the latest
version of the `public` dependecy and see what happens when we try and
run again:

<pre data-command-src="YWxpYXMgZ289Z28xMTUK"><code class="language-.term1">$ alias go=go115
</code></pre>

<pre data-command-src="Y2QgL2hvbWUvZ29waGVyL2dvcGhlcgpHT1BST1hZPWRpcmVjdCBnbyBnZXQgLWQge3t7LlBVQkxJQ319fUBsYXRlc3QK"><code class="language-.term1">$ cd /home/gopher/gopher
$ GOPROXY=direct go get -d &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;@latest
go: &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; latest =&gt; v0.0.0-20210516082250-842dcc186154
go: downloading &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; v0.0.0-20210516082250-842dcc186154
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
# &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
../go/pkg/mod/&#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;@v0.0.0-20210516082250-842dcc186154/public.go:9:17: undefined: io.Discard
</code></pre>

As you can see, when trying to run our `gopher` project using the
latest `public`, we got an error because in our case, we're still using
`go` 1.15 in the gopher project which doesn't support the new `io.Discard`
package.

How do we handle these situations where we shouldn't force our clients to update?
The right approach to tackle this is by using [build constraints](https://pkg.go.dev/go/build#hdr-Build_Constraints) so our `public`
clients can build their project regardless of the `go` version they're using


### Adding `build` tags to our `public` project

Let's go ahead and modify our `public` project so it now uses the
`// +build 1.16` tag.

First we rollback the changes to our original file to keep using the `ioutil.Discard`
pacage for `go` < 1.16 clients

<pre data-upload-path="L2hvbWUvZ29waGVyL3B1YmxpYw==" data-upload-src="cHVibGljLmdv:Ly8gK2J1aWxkICFnbzEuMTYKCnBhY2thZ2UgcHVibGljCgppbXBvcnQgKAogICAgImZtdCIKICAgICJpby9pb3V0aWwiCikKCmZ1bmMgRG9Tb21ldGhpbmcoKSB7CiAgICBmbXQuRnByaW50Zihpb3V0aWwuRGlzY2FyZCwgIlRoaXMgZG9lc24ndCBwcmludCBhbnl0aGluZyIpCn0=" data-upload-term=".term1"><code class="language-go">// +build !go1.16

package public

import (
    &#34;fmt&#34;
    &#34;io/ioutil&#34;
)

func DoSomething() &#123;
    fmt.Fprintf(ioutil.Discard, &#34;This doesn&#39;t print anything&#34;)
&#125;</code></pre>

Additionally, we create a new file which has the correct build tag, so
newer clients can make use of the new package

<pre data-upload-path="L2hvbWUvZ29waGVyL3B1YmxpYw==" data-upload-src="cHVibGljXzExNi5nbw==:Ly8gK2J1aWxkIGdvLjEuMTYKCnBhY2thZ2UgcHVibGljCgppbXBvcnQgKAogICAgImZtdCIKICAgICJpbyIKKQoKZnVuYyBEb1NvbWV0aGluZygpIHsKICAgIGZtdC5GcHJpbnRmKGlvLkRpc2NhcmQsICJUaGlzIGRvZXNuJ3QgcHJpbnQgYW55dGhpbmciKQp9" data-upload-term=".term1"><code class="language-go">// +build go.1.16

package public

import (
    &#34;fmt&#34;
    &#34;io&#34;
)

func DoSomething() &#123;
    fmt.Fprintf(io.Discard, &#34;This doesn&#39;t print anything&#34;)
&#125;</code></pre>

Let's now publish our fixed module

<pre data-command-src="Y2QgL2hvbWUvZ29waGVyL3B1YmxpYwpnaXQgYWRkIHB1YmxpYy5nbyBwdWJsaWNfMTE2LmdvIGdvLm1vZApnaXQgY29tbWl0IC1xIC1tICdGaXggcHVibGljIGJ1bXAgdG8gZ28xLjE2JwpnaXQgcHVzaCAtcSBvcmlnaW4gbWFpbgo="><code class="language-.term1">$ cd /home/gopher/public
$ git add public.go public_116.go go.mod
$ git commit -q -m &#39;Fix public bump to go1.16&#39;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>


Now, we can go ahead and update our `gopher` without problems with the
benefit that `go` 1.16 clients and future clients will be able to use make
use of the newer `go` features and packages.

<pre data-command-src="Y2QgL2hvbWUvZ29waGVyL2dvcGhlcgpHT1BST1hZPWRpcmVjdCBnbyBnZXQgLWQge3t7LlBVQkxJQ319fUBsYXRlc3QK"><code class="language-.term1">$ cd /home/gopher/gopher
$ GOPROXY=direct go get -d &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;@latest
go: &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; latest =&gt; v0.0.0-20060102150405-abcedf12345
go: downloading &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
</code></pre>


### Conclusion

This guide serves as an example on how to leverage on [build constraints](https://pkg.go.dev/go/build#hdr-Build_Constraints)
to provide a backwards compatbile module to your clients. Build constraints are a very
powerful pattern to achieve other tasks in `go`. We encourage the reader to check the official docs
for further examples.

As a next step you might like to consider:

* [Wokring with private modules](/working-with-private-modules_go115_en/)
* [Retract module versions](/retract-module-versions_go116_en/)
<script>let pageGuide="2021-05-02-build-flags-backwards-compatibility"; let pageLanguage="en"; let pageScenario="go115";</script>
