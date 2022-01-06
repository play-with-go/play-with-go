---
category: Next steps
difficulty: Intermediate
excerpt: How to create, publish and work with non-public modules in your team.
guide: 2020-11-12-working-with-private-modules
lang: en
layout: post
title: Working with private modules
---

_By [Paul Jolly](https://twitter.com/_myitcv), Go contributor, and co-creator of `play-with-go.dev`._

The `go` command defaults to downloading modules from the public Go module mirror at
[proxy.golang.org](https://proxy.golang.org). It also defaults to validating downloaded modules, regardless of source,
against the public Go checksum database at [sum.golang.org](https://sum.golang.org).  These defaults work well for
publicly available source code.

But what happens if you and your fellow developers need to work with private modules?

This guide explains how to work with private modules. In the guide you will create three modules:

* `{% raw %}{{{.PUBLIC}}}{% endraw %}`, a publicly accessible module that provides a `Message()` function
* `{% raw %}{{{.PRIVATE}}}{% endraw %}`, a private module that provides a `Secret()` function
* `gopher`, a local-only module that uses `public` and `private` modules

### Prerequisites

You should already have completed:

* [Go Fundamentals](/go-fundamentals_go115_en)

This guide is running using:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.15.15 linux/amd64
</code></pre>

### The `public` and `private` modules

Start by initialising your  `public` module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3B1YmxpYwpjZCAvaG9tZS9nb3BoZXIvcHVibGljCmdvIG1vZCBpbml0IHt7ey5QVUJMSUN9fX0KZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlBVQkxJQ319fS5naXQK"><code class="language-.term1">$ mkdir /home/gopher/public
$ cd /home/gopher/public
$ go mod init &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
go: creating new go.mod: module &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
$ git init -q
$ git remote add origin https://&#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;.git
</code></pre>

Create an initial version of the `Message()` in `public.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3B1YmxpYw==" data-upload-src="cHVibGljLmdv:cGFja2FnZSBwdWJsaWMKCmZ1bmMgTWVzc2FnZSgpIHN0cmluZyB7CglyZXR1cm4gIlRoaXMgaXMgYSBwdWJsaWMgc2FmZXR5IGFubm91bmNlbWVudCEiCn0K" data-upload-term=".term1"><code class="language-go">package public

func Message() string &#123;
	return &#34;This is a public safety announcement!&#34;
&#125;
</code></pre>

Commit and push this initial version:

<pre data-command-src="Z2l0IGFkZCBwdWJsaWMuZ28gZ28ubW9kCmdpdCBjb21taXQgLXEgLW0gJ0luaXRpYWwgY29tbWl0IG9mIHB1YmxpYyBtb2R1bGUnCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCg=="><code class="language-.term1">$ git add public.go go.mod
$ git commit -q -m &#39;Initial commit of public module&#39;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>

Now do the same for the `private` module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3ByaXZhdGUKY2QgL2hvbWUvZ29waGVyL3ByaXZhdGUKZ28gbW9kIGluaXQge3t7LlBSSVZBVEV9fX0KZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlBSSVZBVEV9fX0uZ2l0Cg=="><code class="language-.term1">$ mkdir /home/gopher/private
$ cd /home/gopher/private
$ go mod init &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
go: creating new go.mod: module &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
$ git init -q
$ git remote add origin https://&#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;.git
</code></pre>

_Note: the `private` source code repository at https://{% raw %}{{{.PRIVATE}}}{% endraw %}.git was automatically created for you when this
guide loaded, much like https://{% raw %}{{{.PUBLIC}}}{% endraw %}.git was created for the `public` module. However, the
`private` module repository was marked as `Private: true`, hence authenticated access is required to access
https://{% raw %}{{{.PRIVATE}}}{% endraw %}.git._

Create an initial version of the `Secret()` in `private.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3ByaXZhdGU=" data-upload-src="cHJpdmF0ZS5nbw==:cGFja2FnZSBwcml2YXRlCgpmdW5jIFNlY3JldCgpIHN0cmluZyB7CglyZXR1cm4gIlRoaXMgaXMgYSB0b3Agc2VjcmV0IG1lc3NhZ2UuLi4gZm9yIHlvdXIgZXllcyBvbmx5Igp9Cg==" data-upload-term=".term1"><code class="language-go">package private

func Secret() string &#123;
	return &#34;This is a top secret message... for your eyes only&#34;
&#125;
</code></pre>

Commit and push this initial version:

<pre data-command-src="Z2l0IGFkZCBwcml2YXRlLmdvIGdvLm1vZApnaXQgY29tbWl0IC1xIC1tICdJbml0aWFsIGNvbW1pdCBvZiBwcml2YXRlIG1vZHVsZScKZ2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"><code class="language-.term1">$ git add private.go go.mod
$ git commit -q -m &#39;Initial commit of private module&#39;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>

### The `gopher` module

Now create a `gopher` module to try out the `public` and `private` modules. Unlike
the `public` and `private` modules, you will not publish the `gopher` module; it
will be local only:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dvcGhlcgpjZCAvaG9tZS9nb3BoZXIvZ29waGVyCmdvIG1vZCBpbml0IGdvcGhlcgo="><code class="language-.term1">$ mkdir /home/gopher/gopher
$ cd /home/gopher/gopher
$ go mod init gopher
go: creating new go.mod: module gopher
</code></pre>

Create an initial version of a `main` package that uses the two modules, in `gopher.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcg==" data-upload-src="Z29waGVyLmdv:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCgkie3t7LlBVQkxJQ319fSIKCSJ7e3suUFJJVkFURX19fSIKKQoKZnVuYyBtYWluKCkgewoJZm10LlByaW50ZigicHVibGljLk1lc3NhZ2UoKTogJXZcbiIsIHB1YmxpYy5NZXNzYWdlKCkpCglmbXQuUHJpbnRmKCJwcml2YXRlLlNlY3JldCgpOiAldlxuIiwgcHJpdmF0ZS5TZWNyZXQoKSkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;

	&#34;&#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;&#34;
	&#34;&#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;&#34;
)

func main() &#123;
	fmt.Printf(&#34;public.Message(): %v\n&#34;, public.Message())
	fmt.Printf(&#34;private.Secret(): %v\n&#34;, private.Secret())
&#125;
</code></pre>

At this point, let's take a small diversion to talk about proxies.

### Module proxies

The `go` command can fetch modules from a proxy or connect to source control
servers directly, according to the setting of the `GOPROXY` environment
variable (see `go help env`). You can see the default setting for `GOPROXY` by inspecting
the output of `go env`:

<pre data-command-src="Z28gZW52IEdPUFJPWFkK"><code class="language-.term1">$ go env GOPROXY
https://proxy.golang.org,direct
</code></pre>

This means it will try the Go module mirror run by Google and fall back to a direct connection if the proxy reports that
it does not have the module (HTTP error 404 or 410).

The `go` command also defaults to validating downloaded modules, regardless of source,
against the public Go checksum database at [sum.golang.org](https://sum.golang.org), something that is controlled by the
`GOSUMDB` environment variable. You can see the default for `GOSUMDB` by checking the
output of `go env`:

<pre data-command-src="Z28gZW52IEdPU1VNREIK"><code class="language-.term1">$ go env GOSUMDB
sum.golang.org
</code></pre>

Because your session is already configured with authentication credentials for the source control system that hosts
`{% raw %}{{{.PRIVATE}}}{% endraw %}`, attempting to `go get` that module will succeed because the `go` command will
fall back to the `direct` mode.

Let's simulate getting our module dependencies with no credentials by setting `GOPROXY` to only use the
public proxy, using the `go env` command:

<pre data-command-src="Z28gZW52IC13IEdPUFJPWFk9aHR0cHM6Ly9wcm94eS5nb2xhbmcub3JnCg=="><code class="language-.term1">$ go env -w GOPROXY=https://proxy.golang.org
</code></pre>

Add a dependency on the `public` module:

<pre data-command-src="Z28gZ2V0IHt7ey5QVUJMSUN9fX0K"><code class="language-.term1">$ go get &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125;
go: downloading &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
go: &#123;&#123;&#123;.PUBLIC&#125;&#125;&#125; upgrade =&gt; v0.0.0-20060102150405-abcedf12345
</code></pre>

As expected, that succeeded.

Try to add a dependency on the `private` module:

<pre data-command-src="Z28gZ2V0IHt7ey5QUklWQVRFfX19Cg=="><code class="language-.term1">$ go get &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
go get &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;: module &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;: reading https://proxy.golang.org/&#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;/@v/list: 404 Not Found
	server response:
	not found: module &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
		fatal: could not read Username for &#39;https://gopher.live&#39;: terminal prompts disabled
	Confirm the import path was entered correctly.
	If this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
</code></pre>

Thankfully, this failed.

Let's return `GOPROXY` to its default value:

<pre data-command-src="Z28gZW52IC13IEdPUFJPWFk9Cg=="><code class="language-.term1">$ go env -w GOPROXY=
</code></pre>

And try once again to add a dependency on the `private` module:

<pre data-command-src="Z28gZ2V0IHt7ey5QUklWQVRFfX19Cg=="><code class="language-.term1">$ go get &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
go: downloading &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
go get &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;: &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;@v0.0.0-20060102150405-abcedf12345: verifying module: &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;@v0.0.0-20060102150405-abcedf12345: reading https://sum.golang.org/lookup/&#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;@v0.0.0-20060102150405-abcedf12345: 404 Not Found
	server response:
	not found: &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;@v0.0.0-20060102150405-abcedf12345: invalid version: git ls-remote -q origin in /tmp/gopath/pkg/mod/cache/vcs/0123456789abcdef: exit status 128:
		fatal: could not read Username for &#39;https://gopher.live&#39;: terminal prompts disabled
	Confirm the import path was entered correctly.
	If this is a private repository, see https://golang.org/doc/faq#git_https for additional information.
</code></pre>

This fails because the checksum database is not able to access your `private` module. But it's worse than
that, because the `go` command "leaked" a request for `{% raw %}{{{.PRIVATE}}}{% endraw %}` to the public proxy. This might well be
fine for a trusted proxy like the Google proxy, but it isn't always the case.

### The `GOPRIVATE` environment variable

The `GOPRIVATE` environment variable controls which modules the `go` command
considers to be private (not available publicly) and should therefore not use the
proxy or checksum database. The variable is a comma-separated list of
glob patterns (in the syntax of Go's [`path.Match`](https://pkg.go.dev/path#Match)) of module path prefixes.

Let's tell the `go` command that `{% raw %}{{{.PRIVATE}}}{% endraw %}` by setting the `GOPRIVATE` environment
variable:

<pre data-command-src="Z28gZW52IC13IEdPUFJJVkFURT17e3suUFJJVkFURX19fQo="><code class="language-.term1">$ go env -w GOPRIVATE=&#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
</code></pre>

Try to get the latest version of the `private` module again (remember, the `public` module
succeeded):

<pre data-command-src="Z28gZ2V0IHt7ey5QUklWQVRFfX19Cg=="><code class="language-.term1">$ go get &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125;
go: downloading &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
go: &#123;&#123;&#123;.PRIVATE&#125;&#125;&#125; upgrade =&gt; v0.0.0-20060102150405-abcedf12345
</code></pre>

Success! As a final check, run the `gopher` module `main` package:

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
public.Message(): This is a public safety announcement!
private.Secret(): This is a top secret message... for your eyes only
</code></pre>

For more details on the `GOPRIVATE` environment variable and the values it can take, see
`go help module-private`, which also includes examples of how to use the `*` glob to match multiple sub domains
or modules.

The `GONOPROXY` and `GONOSUMDB` environment variables can be used for more fine
grained control. Again, see `go help module-private` for more information.

### Conclusion

This guide has provided you with a brief introduction to handling private modules.

As a next step you might like to consider:

* [Developer tools as module dependencies](/tools-as-dependencies_go115_en/)
* [How to use and tweak Staticcheck](/using-staticcheck_go115_en/)
* [Installing Go](/installing-go_go115_en/)
<script>let pageGuide="2020-11-12-working-with-private-modules"; let pageLanguage="en"; let pageScenario="go115";</script>
