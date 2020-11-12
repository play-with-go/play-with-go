---
category: What's coming in Go 1.16
difficulty: Intermediate
excerpt: Learn how to flag modules that shouldn't be used
guide: 2020-11-08-retract-module-versions
lang: en
layout: post
title: Retract Module Versions
---

_By [Jay Conrod](https://twitter.com/jayconrod), software engineer on the [Go](https://golang.org/) tools team, and
principal author of module retraction in the `go` command._

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Module authors need a way to indicate that published module versions should not be used. There are a number of reasons
this may be needed:

* A severe security vulnerability has been identified.
* A severe incompatibility or bug was discovered.
* The version was published accidentally or prematurely.

Authors can't simply delete version tags, since they remain available on module proxies. If an author were able to
delete a version from all proxies, it would break downstream users that depend on that version.

Authors also can't change versions after they've published. `go.sum` files and the checksum database verify that published
versions never change.

Instead, authors should be able to _retract_ module versions. A retracted module version is a version with an explicit
declaration from the module author that it should not be used. (The word retract is borrowed from academic literature: a
retracted research paper is still available, but it has problems and should not be the basis of future work).

Retracted versions should remain available in module proxies and origin repositories. Builds that depend on retracted
versions should continue to work. However, users should be notified when they depend on a retracted version (either
directly or indirectly). It should also be difficult to unintentionally upgrade to a retracted version.

This guide walks you through how to use module retractions. In the guide you will create two modules:

* `{% raw %}{{{.PROVERB}}}{% endraw %}` (part of a module at the same path) that provides various different wise proverbs. You will
  publish a number of versions of this module.
* `gopher`, a simple `main` package that uses `{% raw %}{{{.PROVERB}}}{% endraw %}`. You will not publish this module; it
  will be local-only.

This guide is running using:

```.term1
$ go version
go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### The `proverb` module

Start by initialising your `proverb` module:

```.term1
$ mkdir /home/gopher/proverb
$ cd /home/gopher/proverb
$ git init -q
$ git remote add origin https://{% raw %}{{{.PROVERB}}}{% endraw %}.git
$ go mod init {% raw %}{{{.PROVERB}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.PROVERB}}}{% endraw %}
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3Byb3ZlcmIKY2QgL2hvbWUvZ29waGVyL3Byb3ZlcmIKZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlBST1ZFUkJ9fX0uZ2l0CmdvIG1vZCBpbml0IHt7ey5QUk9WRVJCfX19Cg=="}

Create an initial version with a `Go` function that returns a Go proverb in the file `proverb.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="cHJvdmVyYi5nbw==:cGFja2FnZSBwcm92ZXJiCgovLyBHbyByZXR1cm5zIGEgR28gcHJvdmVyYgpmdW5jIEdvKCkgc3RyaW5nIHsKCXJldHVybiAiRG9uJ3QgY29tbXVuaWNhdGUgYnkgc2hhcmluZyBtZW1vcnksIHNoYXJkIG1lbW9yeSBieSBjb21tdW5pY2F0aW5nLiIKfQo=" data-upload-term=".term1"><code class="language-go">package proverb

// Go returns a Go proverb
func Go() string {
	return &#34;Don&#39;t communicate by sharing memory, shard memory by communicating.&#34;
}
</code></pre>

Commit and push this initial version:

```.term1
$ git add -A
$ git commit -q -m "Initial commit"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1xIC1tICJJbml0aWFsIGNvbW1pdCIKZ2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"}

It's early days for the `proverb` module, so you decide to tag it with a `v0` semantic version, indicating it
is not yet stable:

```.term1
$ git tag v0.1.0
$ git push -q origin v0.1.0
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHRhZyB2MC4xLjAKZ2l0IHB1c2ggLXEgb3JpZ2luIHYwLjEuMAo="}

With the first version of the `proverb` module published, it's time to create a first cut of your
`gopher` module.

### The `gopher` module

You are not going to publish the `gopher` module, so the setup is simpler:

```.term1
$ mkdir /home/gopher/gopher
$ cd /home/gopher/gopher
$ go mod init gopher
go: creating new go.mod: module gopher
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dvcGhlcgpjZCAvaG9tZS9nb3BoZXIvZ29waGVyCmdvIG1vZCBpbml0IGdvcGhlcgo="}

Notice how you skipped the `git` steps, and also how the module path is simply `gopher`. As this module
will be local-only, you can use any path you like.

Create an initial version of the `main` function in `gopher.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcg==" data-upload-src="Z29waGVyLmdv:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCgkie3t7LlBST1ZFUkJ9fX0iCikKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGxuKHByb3ZlcmIuR28oKSkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;

	&#34;{% raw %}{{{.PROVERB}}}{% endraw %}&#34;
)

func main() {
	fmt.Println(proverb.Go())
}
</code></pre>

In this code you:

* Import the `{% raw %}{{{.PROVERB}}}{% endraw %}` package. This declares the dependency on this package.
* Use the [`fmt.Println`](https://pkg.go.dev/fmt#Println) to print the proverb returned by `proverb.Go()`
  function.

Add a dependency on the `{% raw %}{{{.PROVERB}}}{% endraw %}` module:

```.term1
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v0.1.0
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v0.1.0
```
{:data-command-src="Z28gZ2V0IHt7ey5QUk9WRVJCfX19QHYwLjEuMAo="}

Run to make sure everything works:

```.term1
$ go run .
Don't communicate by sharing memory, shard memory by communicating.
```
{:data-command-src="Z28gcnVuIC4K"}

Looks great!

### A "better" initial version

After much debate with some friends, you decide that there is a better Go proverb to use in the initial version of your
`proverb` module.

Change back to the `proverb` module:

```.term1
$ cd /home/gopher/proverb
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL3Byb3ZlcmIK"}

Update `proverb.go` as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="cHJvdmVyYi5nbw==:cGFja2FnZSBwcm92ZXJiCgovLyBHbyByZXR1cm5zIGEgR28gcHJvdmVyYgpmdW5jIEdvKCkgc3RyaW5nIHsKCXJldHVybiAiQ29uY3VycmVuY3kgaXMgcGFyYWxsZWxpc20uIgp9Cg==" data-upload-term=".term1"><code class="language-go">package proverb

// Go returns a Go proverb
func Go() string {
<b>	return &#34;Concurrency is parallelism.&#34;</b>
}
</code></pre>

Commit and push this updated version:

```.term1
$ git add -A
$ git commit -q -m "Switch Go proverb to something more famous"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1xIC1tICJTd2l0Y2ggR28gcHJvdmVyYiB0byBzb21ldGhpbmcgbW9yZSBmYW1vdXMiCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCg=="}

Given there might be further changes to the `proverb` module before you mark it as `v1` stable, you decide to
publish `v0.2.0` to be on the safe side:

```.term1
$ git tag v0.2.0
$ git push -q origin v0.2.0
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHRhZyB2MC4yLjAKZ2l0IHB1c2ggLXEgb3JpZ2luIHYwLjIuMAo="}

With the second version of the `proverb` module now published, return to your `gopher` module and
try this out:

```.term1
$ cd /home/gopher/gopher
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v0.2.0
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v0.2.0
$ go run .
Concurrency is parallelism.
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dvcGhlcgpnbyBnZXQge3t7LlBST1ZFUkJ9fX1AdjAuMi4wCmdvIHJ1biAuCg=="}

Oops! That doesn't look right: the proverb should read _"Concurrency is **not** parallelism."_ Looks like you made a
mistake with the changes in `v0.2.0`. You can surely publish a new version of the `proverb`
module to correct the mistake, but how can you prevent your users from depending on this broken version?

Module retraction to the rescue.

### Retracting module versions

A module author can retract a version of a module by adding a `retract` directive to the `go.mod` file. The `retract`
directive simply lists retracted versions. The `go` command reads retractions from the highest release version of the
module.

To retract `v0.2.0` of the `proverb` module, you will therefore publish
`v0.3.0`. This new version will also fix the bug you found in `v0.2.0`.

Return to the `proverb` module:

```.term1
$ cd /home/gopher/proverb
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL3Byb3ZlcmIK"}

Rather than making the change to your `go.mod` file by hand, you can instead use
`go mod edit` as follows:

```.term1
$ go mod edit -retract=v0.2.0
```
{:data-command-src="Z28gbW9kIGVkaXQgLXJldHJhY3Q9djAuMi4wCg=="}

Inspect the `go.mod` to see the result:

```.term1
$ cat go.mod
module {% raw %}{{{.PROVERB}}}{% endraw %}

go 1.16

retract v0.2.0
```
{:data-command-src="Y2F0IGdvLm1vZAo="}

As is best practice, add a comment to the `retract` directive documenting why the retraction was
necessary:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="Z28ubW9k:bW9kdWxlIHt7ey5QUk9WRVJCfX19CgpnbyAxLjE2CgovLyBHbyBwcm92ZXJiIHdhcyB0b3RhbGx5IHdyb25nCnJldHJhY3QgdjAuMi4wCg==" data-upload-term=".term1"><code class="language-mod">module {% raw %}{{{.PROVERB}}}{% endraw %}

go 1.16

// Go proverb was totally wrong
retract v0.2.0
</code></pre>

The comment may be shown by tools like `go get` and `go list`. It will be shown by
[`gorelease`](https://pkg.go.dev/golang.org/x/exp/cmd/gorelease) and [`pkg.go.dev`](https://pkg.go.dev/) later on, too.

Fix the bug in `proverb.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="cHJvdmVyYi5nbw==:cGFja2FnZSBwcm92ZXJiCgovLyBHbyByZXR1cm5zIGEgR28gcHJvdmVyYgpmdW5jIEdvKCkgc3RyaW5nIHsKCXJldHVybiAiQ29uY3VycmVuY3kgaXMgbm90IHBhcmFsbGVsaXNtLiIKfQo=" data-upload-term=".term1"><code class="language-go">package proverb

// Go returns a Go proverb
func Go() string {
<b>	return &#34;Concurrency is not parallelism.&#34;</b>
}
</code></pre>

Commit, push and tag `v0.3.0`:

```.term1
$ git add -A
$ git commit -q -m "Fix severe error in Go proverb"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
$ git tag v0.3.0
$ git push -q origin v0.3.0
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1xIC1tICJGaXggc2V2ZXJlIGVycm9yIGluIEdvIHByb3ZlcmIiCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCmdpdCB0YWcgdjAuMy4wCmdpdCBwdXNoIC1xIG9yaWdpbiB2MC4zLjAK"}

Return to your `gopher` module to use this new version:

```.term1
$ cd /home/gopher/gopher
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v0.3.0
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v0.3.0
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dvcGhlcgpnbyBnZXQge3t7LlBST1ZFUkJ9fX1AdjAuMy4wCg=="}

This step also ensures that [proxy.golang.org](https://proxy.golang.org/) is now aware of `v0.3.0`.
Manually "pulling" a version of a module into the proxy using `go get` in this way means you (or indeed
others) do not have to rely or wait on the proxy automatically checking for later versions of a module.

Verify this new version fixes things:

```.term1
$ go run .
Concurrency is not parallelism.
```
{:data-command-src="Z28gcnVuIC4K"}

That's better.

So what exactly has happened to `v0.2.0`? Remember, you can't simply delete a version of the
`proverb` module, since it remains available on module proxies.  Let's use `go list` to dig a
bit deeper.

But first you need to wait for the proxy to update its state:

```.term1
$ sleep 1m
```
{:data-command-src="c2xlZXAgMW0K"}

Why? The FAQ on the [proxy website](https://proxy.golang.org/) explains:

> In order to improve the proxy's caching and serving latencies, new versions may not show up right away. If you want new
code to be immediately available in the mirror, then first make sure there is a semantically versioned tag for this
revision in the underlying source repository. Then explicitly request that version via go get module@version. After one
minute for caches to expire, the go command will see that tagged version. If this doesn't work for you, please file an
issue.

List the non-retracted, "usable" versions of the `{% raw %}{{{.PROVERB}}}{% endraw %}` module known to the proxy:

```.term1
$ go list -m -versions {% raw %}{{{.PROVERB}}}{% endraw %}
{% raw %}{{{.PROVERB}}}{% endraw %} v0.1.0 v0.3.0
```
{:data-command-src="Z28gbGlzdCAtbSAtdmVyc2lvbnMge3t7LlBST1ZFUkJ9fX0K"}

Notice that the newly published `v0.3.0` is in this list, but `v0.2.0` is not.

List _all_ versions versions (including any that are retracted):

```.term1
$ go list -m -versions -retracted {% raw %}{{{.PROVERB}}}{% endraw %}
{% raw %}{{{.PROVERB}}}{% endraw %} v0.1.0 v0.2.0 v0.3.0
```
{:data-command-src="Z28gbGlzdCAtbSAtdmVyc2lvbnMgLXJldHJhY3RlZCB7e3suUFJPVkVSQn19fQo="}

Ah, there is the mischievous `v0.2.0`.

So what would happen if you were to rely on the now retracted `v0.2.0`?

```.term1
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v0.2.0
go: warning: {% raw %}{{{.PROVERB}}}{% endraw %}@v0.2.0 is retracted: Go proverb was totally wrong
go: run 'go get {% raw %}{{{.PROVERB}}}{% endraw %}@latest' to switch to the latest unretracted version
```
{:data-command-src="Z28gZ2V0IHt7ey5QUk9WRVJCfX19QHYwLjIuMAo="}

A helpful message is printed, warning that you are now depending on a retracted version. Notice that this error message
includes the text from the comment you added to the `retract` directive.

But does the code run?

```.term1
$ go run .
Concurrency is parallelism.
```
{:data-command-src="Z28gcnVuIC4K"}

Interesting: your code continues to "work" as before.

So how do you tell if you are relying on retracted versions of a module? For this, you again turn to
`go list`:

```.term1
$ go list -m -u all
gopher
{% raw %}{{{.PROVERB}}}{% endraw %} v0.2.0 (retracted) [v0.3.0]
```
{:data-command-src="Z28gbGlzdCAtbSAtdSBhbGwK"}

Let's follow the advice of the warning message, and return to the latest un-retracted version:

```.term1
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@latest
```
{:data-command-src="Z28gZ2V0IHt7ey5QUk9WRVJCfX19QGxhdGVzdAo="}

### Another type of proverb

After consulting a wise friend, you decide that your `proverb` module needs to be a bit more rounded with
its advice, and that one more change is therefore required before you declare it stable at `v1`. Returning to the
`proverb` module:

```.term1
$ cd /home/gopher/proverb
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL3Byb3ZlcmIK"}

Update `proverb.go` as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="cHJvdmVyYi5nbw==:cGFja2FnZSBwcm92ZXJiCgovLyBHbyByZXR1cm5zIGEgR28gcHJvdmVyYgpmdW5jIEdvKCkgc3RyaW5nIHsKCXJldHVybiAiQ29uY3VycmVuY3kgaXMgbm90IHBhcmFsbGVsaXNtLiIKfQoKLy8gTGlmZSByZXR1cm5zIGEgcHJvdmVyYiB1c2VmdWwgZm9yIGRheS10by1kYXkgbGl2aW5nCmZ1bmMgTGlmZSgpIHN0cmluZyB7CglyZXR1cm4gIkEgYmlyZCBpbiB0aGUgaGFuZCBpcyB3b3J0aCB0d28gaW4gdGhlIGJ1c2guIgp9Cg==" data-upload-term=".term1"><code class="language-go">package proverb

// Go returns a Go proverb
func Go() string {
	return &#34;Concurrency is not parallelism.&#34;
}
<b></b>
<b>// Life returns a proverb useful for day-to-day living</b>
<b>func Life() string {</b>
<b>	return &#34;A bird in the hand is worth two in the bush.&#34;</b>
<b>}</b>
</code></pre>

Commit and push this updated version:

```.term1
$ git add -A
$ git commit -q -m "Add Life() proverb"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1xIC1tICJBZGQgTGlmZSgpIHByb3ZlcmIiCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCg=="}

To be safe, you decide to publish `v0.4.0` before committing to a `v1` stable version:

```.term1
$ git tag v1.0.0
$ git push -q origin v1.0.0
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHRhZyB2MS4wLjAKZ2l0IHB1c2ggLXEgb3JpZ2luIHYxLjAuMAo="}

Oh no! You accidentally tagged and pushed `v1.0.0` instead of `v0.4.0`. Users of
your module might mistakenly think the `proverb` API is stable and that there will not therefore be any
breaking changes. But you're not ready to make that sort of commitment!

Let's retract `v1.0.0` of the `proverb` module, but first publish with the correct version,
`v0.4.0`:

```.term1
$ git tag v0.4.0
$ git push -q origin v0.4.0
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHRhZyB2MC40LjAKZ2l0IHB1c2ggLXEgb3JpZ2luIHYwLjQuMAo="}

To retract `v1.0.0` you will need to publish `v1.0.1`. But that means you will _also_
need to retract version `v1.0.1`. You do so using a [closed
range](https://en.wikipedia.org/wiki/Interval_(mathematics)). Make this change by hand by editing the
`proverb` `go.mod` file, commenting the `retract` directive as is best practice:

<pre data-upload-path="L2hvbWUvZ29waGVyL3Byb3ZlcmI=" data-upload-src="Z28ubW9k:bW9kdWxlIHt7ey5QUk9WRVJCfX19CgpnbyAxLjE2CgpyZXRyYWN0ICgKCS8vIEdvIHByb3ZlcmIgd2FzIHRvdGFsbHkgd3JvbmcKCXYwLjIuMAoKCS8vIFB1Ymxpc2hlZCB2MSB0b28gZWFybHkKCVt2MS4wLjAsIHYxLjAuMV0KKQo=" data-upload-term=".term1"><code class="language-mod">module {% raw %}{{{.PROVERB}}}{% endraw %}

go 1.16

<b>retract (</b>
<b>	// Go proverb was totally wrong</b>
<b>	v0.2.0</b>
<b></b>
<b>	// Published v1 too early</b>
<b>	[v1.0.0, v1.0.1]</b>
<b>)</b>
</code></pre>

Commit, tag, push and publish `v1.0.1`:

```.term1
$ git add -A
$ git commit -q -m "Retract [v1.0.0, v1.0.1]"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
$ git tag v1.0.1
$ git push -q origin v1.0.1
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1xIC1tICJSZXRyYWN0IFt2MS4wLjAsIHYxLjAuMV0iCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCmdpdCB0YWcgdjEuMC4xCmdpdCBwdXNoIC1xIG9yaWdpbiB2MS4wLjEK"}

Return to the `gopher` module to experiment with the newly retracted versions:

```.term1
$ cd /home/gopher/gopher
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dvcGhlcgo="}

Ensure proxy.golang.org is aware of the new versions of `proverb` you just published. `go get`
`v0.4.0` last to leave that version as the current dependency (you will test it later).

```.term1
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v1.0.0
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v1.0.0
go: warning: {% raw %}{{{.PROVERB}}}{% endraw %}@v1.0.0 is retracted: Published v1 too early
go: run 'go get {% raw %}{{{.PROVERB}}}{% endraw %}@latest' to switch to the latest unretracted version
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v1.0.1
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v1.0.1
go: warning: {% raw %}{{{.PROVERB}}}{% endraw %}@v1.0.1 is retracted: Published v1 too early
go: run 'go get {% raw %}{{{.PROVERB}}}{% endraw %}@latest' to switch to the latest unretracted version
$ go get {% raw %}{{{.PROVERB}}}{% endraw %}@v0.4.0
go: downloading {% raw %}{{{.PROVERB}}}{% endraw %} v0.4.0
```
{:data-command-src="Z28gZ2V0IHt7ey5QUk9WRVJCfX19QHYxLjAuMApnbyBnZXQge3t7LlBST1ZFUkJ9fX1AdjEuMC4xCmdvIGdldCB7e3suUFJPVkVSQn19fUB2MC40LjAK"}

_Note: you might not see the warning about either `v1.0.0` or `v1.0.1` being
retracted versions. proxy.golang.org automatically updates periodically; depending on how lucky you are, an automatic
update may have occurred in the time since you published `v1.0.1` in which case you will see the
warning message, or it may not._

Now that you have pulled these versions through the proxy, wait for the proxy cache to update:

```.term1
$ sleep 1m
```
{:data-command-src="c2xlZXAgMW0K"}

List all versions of the `{% raw %}{{{.PROVERB}}}{% endraw %}` known to the proxy, including the retracted ones:

```.term1
$ go list -m -versions -retracted {% raw %}{{{.PROVERB}}}{% endraw %}
{% raw %}{{{.PROVERB}}}{% endraw %} v0.1.0 v0.2.0 v0.3.0 v0.4.0 v1.0.0 v1.0.1
```
{:data-command-src="Z28gbGlzdCAtbSAtdmVyc2lvbnMgLXJldHJhY3RlZCB7e3suUFJPVkVSQn19fQo="}

List the non-retracted versions of the `{% raw %}{{{.PROVERB}}}{% endraw %}` known to the proxy:

```.term1
$ go list -m -versions {% raw %}{{{.PROVERB}}}{% endraw %}
{% raw %}{{{.PROVERB}}}{% endraw %} v0.1.0 v0.3.0 v0.4.0
```
{:data-command-src="Z28gbGlzdCAtbSAtdmVyc2lvbnMge3t7LlBST1ZFUkJ9fX0K"}

This shows that `v0.4.0` is the latest version of the `proverb` module, as expected.

Update `gopher.go` to use the new proverb:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcg==" data-upload-src="Z29waGVyLmdv:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCgkie3t7LlBST1ZFUkJ9fX0iCikKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGYoIkdvIHByb3ZlcmI6ICV2XG4iLCBwcm92ZXJiLkdvKCkpCglmbXQuUHJpbnRmKCJMaWZlIGFkdmljZTogJXZcbiIsIHByb3ZlcmIuTGlmZSgpKQp9Cg==" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;

	&#34;{% raw %}{{{.PROVERB}}}{% endraw %}&#34;
)

func main() {
<b>	fmt.Printf(&#34;Go proverb: %v\n&#34;, proverb.Go())</b>
<b>	fmt.Printf(&#34;Life advice: %v\n&#34;, proverb.Life())</b>
}
</code></pre>

Finally, run `gopher` to verify everything works:

```.term1
$ go run .
Go proverb: Concurrency is not parallelism.
Life advice: A bird in the hand is worth two in the bush.
```
{:data-command-src="Z28gcnVuIC4K"}

Note that when you come to publish the "real" `v1.0.0` of the `proverb` module, it must
be published as `v1.0.2` since you cannot change or delete versions (retracted or not).

### Conclusion

That's it! This guide has introduced module retraction, demonstrating how to retract a simple bad version, as well as
retracting an accidental `v1`. For more information on module retraction, see [the modules
reference](https://golang.org/ref/mod).
<script>let pageGuide="2020-11-08-retract-module-versions"; let pageLanguage="en"; let pageScenario="go116";</script>
