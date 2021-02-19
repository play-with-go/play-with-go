---
category: Next steps
difficulty: Intermediate
excerpt: Using static analysis to automatically find bugs and performance optimizations.
guide: 2020-11-09-using-staticcheck
lang: en
layout: post
title: How to use and tweak Staticcheck
---

_By [Dominik Honnef](https://dominik.honnef.co/), author of Staticcheck._

[Staticcheck](https://staticcheck.io/) is a state of the art linter for the Go programming language. Using [static
analysis](https://en.wikipedia.org/wiki/Static_program_analysis), it finds bugs and performance issues, offers
simplifications, and enforces style rules.

Its checks have been designed to be fast, precise and useful. When Staticcheck flags code, you can be sure that it isn't
wasting your time with unactionable warnings. While checks have been designed to be useful out of the box, they still
provide configuration where necessary, to fine-tune to your needs, without overwhelming you with hundreds of options.

Staticcheck can be used from the command line, in continuous integration (CI), and even directly [from your
editor](https://github.com/golang/tools/blob/master/gopls/doc/settings.md#staticcheck-boolean).

Staticcheck is open source and offered completely free of charge. Sponsors guarantee its continued development. The
`play-with-go.dev` project is proud to sponsor the Staticcheck project. If you, your employer or your company use
Staticcheck please consider [sponsoring](https://github.com/sponsors/dominikh) the project.

This guide gets you up and running with Staticcheck by analysing the `pets` module.

### Prerequisites

You should already have completed:

* [Go fundamentals](/go-fundamentals_go115_en)

This guide is running using:

<pre data-command-src="Z28gdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.15.8 linux/amd64
</code></pre>

### Installing Staticcheck

In this guide you will install Staticcheck to your `PATH`. For details on how to add development tools as a project
module dependency, please see the ["Developer tools as module dependencies" guide](/tools-as-dependencies_go115_en).

Use `go get` to install Staticcheck:

<pre data-command-src="KGNkICQobWt0ZW1wIC1kKTsgR08xMTFNT0RVTEU9b24gZ28gZ2V0IGhvbm5lZi5jby9nby90b29scy9jbWQvc3RhdGljY2hlY2tAdjAuMC4xLTIwMjAuMS42KQo="><code class="language-.term1">$ (cd $(mktemp -d); GO111MODULE=on go get honnef.co/go/tools/cmd/staticcheck@v0.0.1-2020.1.6)
go: downloading honnef.co/go/tools v0.0.1-2020.1.6
go: found honnef.co/go/tools/cmd/staticcheck in honnef.co/go/tools v0.0.1-2020.1.6
go: downloading golang.org/x/tools v0.0.0-20200410194907-79a7a3126eef
go: downloading github.com/BurntSushi/toml v0.3.1
go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
</code></pre>

_Note: so that this guide remains reproducible we have spcified an explicit version, `v0.0.1-2020.1.6`.
When running yourself you could use the special version `latest`._

The rather ugly use of a temporary directory ensures that `go get` is run outside of a module.  See the
_"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go115_en) to ensure your `PATH` is set correctly.

Check that `staticcheck` is on your `PATH`:

<pre data-command-src="d2hpY2ggc3RhdGljY2hlY2sK"><code class="language-.term1">$ which staticcheck
/home/gopher/go/bin/staticcheck
</code></pre>

Run `staticcheck` as a quick check:

<pre data-command-src="c3RhdGljY2hlY2sgLXZlcnNpb24K"><code class="language-.term1">$ staticcheck -version
staticcheck 2020.1.6
</code></pre>

You're all set!

### Create the `pets` module

Time to create an initial version of the `pets` module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3BldHMKY2QgL2hvbWUvZ29waGVyL3BldHMKZ28gbW9kIGluaXQgcGV0cwo="><code class="language-.term1">$ mkdir /home/gopher/pets
$ cd /home/gopher/pets
$ go mod init pets
go: creating new go.mod: module pets
</code></pre>

Because you are not going to publish this module (or import the `pets` package; it's just a toy
example), you do not need to initialise this directory as a `git` repository and can give the module whatever path you
like. Here, simply `pets`.

Create an inital version of the `pets` package in `pets.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:cGFja2FnZSBwZXRzCgppbXBvcnQgKAoJImVycm9ycyIKCSJmbXQiCikKCnR5cGUgQW5pbWFsIGludAoKY29uc3QgKAoJRG9nIEFuaW1hbCA9IGlvdGEKCVNuYWtlCikKCnR5cGUgUGV0IHN0cnVjdCB7CglLaW5kIEFuaW1hbAoJTmFtZSBzdHJpbmcKfQoKZnVuYyAocCBQZXQpIFdhbGsoKSBlcnJvciB7Cglzd2l0Y2ggcC5LaW5kIHsKCWNhc2UgRG9nOgoJCWZtdC5QcmludGYoIldpbGwgdGFrZSAldiBmb3IgYSB3YWxrIGFyb3VuZCB0aGUgYmxvY2tcbiIpCglkZWZhdWx0OgoJCXJldHVybiBlcnJvcnMuTmV3KGZtdC5TcHJpbnRmKCJDYW5ub3QgdGFrZSAldiBmb3IgYSB3YWxrIiwgcC5OYW1lKSkKCX0KCXJldHVybiBuaWwKfQoKZnVuYyAoc2VsZiBQZXQpIFN0cmluZygpIHN0cmluZyB7CglyZXR1cm4gZm10LlNwcmludGYoIiVzIiwgc2VsZi5OYW1lKQp9Cg==" data-upload-term=".term1"><code class="language-go">package pets

import (
	&#34;errors&#34;
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;)
	default:
		return errors.New(fmt.Sprintf(&#34;Cannot take %v for a walk&#34;, p.Name))
	&#125;
	return nil
&#125;

func (self Pet) String() string &#123;
	return fmt.Sprintf(&#34;%s&#34;, self.Name)
&#125;
</code></pre>

This code looks sensible enough. Build it to confirm there are no compile errors:

<pre data-command-src="Z28gYnVpbGQK"><code class="language-.term1">$ go build
</code></pre>

All good. Or is it? Let's run Staticcheck to see what it thinks.

Staticcheck can be run on code in several ways, mimicking the way the official Go tools work. At its core, it expects to
be run on well-formed Go packages. So let's run it on the current package, the `pets` package:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
pets.go:23:14: Printf format %v reads arg #1, but call has only 0 args (SA5009)
pets.go:25:10: should use fmt.Errorf(...) instead of errors.New(fmt.Sprintf(...)) (S1028)
pets.go:30:7: receiver name should be a reflection of its identity; don&#39;t use generic names such as &#34;this&#34; or &#34;self&#34; (ST1006)
pets.go:31:9: the argument is already a string, there&#39;s no need to use fmt.Sprintf (S1025)
</code></pre>

Oh dear, Staticcheck has found some issues!

As you can see from the output, Staticcheck reports errors much like the Go compiler. Each line represents a problem,
starting with a file position, then a description of the problem, with the Staticcheck check number in parentheses at the
end of the line.

Staticcheck checks fall into different categories, with each category identified by a different code prefix. Some are
listed below:

* Code simplification `S1???`
* Correctness issues `SA5???`
* Stylistic issues `ST1???`

The Staticcheck website [lists and documents all the categories and checks](https://staticcheck.io/docs/checks). Many of
the checks even have examples. You can also use the `-explain` flag to get details at the command
line:

<pre data-command-src="c3RhdGljY2hlY2sgLWV4cGxhaW4gU0E1MDA5Cg=="><code class="language-.term1">$ staticcheck -explain SA5009
Invalid Printf call

Available since
    2019.2

</code></pre>

Let's consider one of the problems reported, [`ST1006`](https://staticcheck.io/docs/checks#ST1006), documented as "Poorly
chosen receiver name". The Staticcheck check documentation quotes from the [Go Code Review Comments
wiki](https://github.com/golang/go/wiki/CodeReviewComments):

> The name of a method's receiver should be a reflection of its
identity; often a one or two letter abbreviation of its type
suffices (such as "c" or "cl" for "Client"). Don't use generic
names such as "me", "this" or "self", identifiers typical of
object-oriented languages that place more emphasis on methods as
opposed to functions. The name need not be as descriptive as that
of a method argument, as its role is obvious and serves no
documentary purpose. It can be very short as it will appear on
almost every line of every method of the type; familiarity admits
brevity. Be consistent, too: if you call the receiver "c" in one
method, don't call it "cl" in another.

Each error message explains the problem, but also indicates how to fix the problem. Let's fix up `pets.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:cGFja2FnZSBwZXRzCgppbXBvcnQgKAoJImZtdCIKKQoKdHlwZSBBbmltYWwgaW50Cgpjb25zdCAoCglEb2cgQW5pbWFsID0gaW90YQoJU25ha2UKKQoKdHlwZSBQZXQgc3RydWN0IHsKCUtpbmQgQW5pbWFsCglOYW1lIHN0cmluZwp9CgpmdW5jIChwIFBldCkgV2FsaygpIGVycm9yIHsKCXN3aXRjaCBwLktpbmQgewoJY2FzZSBEb2c6CgkJZm10LlByaW50ZigiV2lsbCB0YWtlICV2IGZvciBhIHdhbGsgYXJvdW5kIHRoZSBibG9ja1xuIiwgcC5OYW1lKQoJZGVmYXVsdDoKCQlyZXR1cm4gZm10LkVycm9yZigiY2Fubm90IHRha2UgJXYgZm9yIGEgd2FsayIsIHAuTmFtZSkKCX0KCXJldHVybiBuaWwKfQoKZnVuYyAocCBQZXQpIFN0cmluZygpIHN0cmluZyB7CglyZXR1cm4gcC5OYW1lCn0K" data-upload-term=".term1"><code class="language-go">package pets

import (
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
<b>		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)</b>
	default:
<b>		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)</b>
	&#125;
	return nil
&#125;

<b>func (p Pet) String() string &#123;</b>
<b>	return p.Name</b>
&#125;
</code></pre>

And re-run Staticcheck to confirm:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
</code></pre>

Excellent, much better.

### Configuring Staticcheck

Staticcheck works out of the box with some sensible, battle-tested defaults. However, various aspects of Staticcheck can
be customized with configuration files.

Whilst fixing up the problems Staticcheck reported, you notice that the `pets` package is missing a package
comment. You also happened to notice on the Staticcheck website that check
[`ST1000`](https://staticcheck.io/docs/checks#ST1000) covers exactly this
case, but that it is not enabled by default.

Staticcheck configuration files are named `staticcheck.conf` and contain
[TOML](https://github.com/toml-lang/toml).

Let's create a Staticcheck configuration file to enable check `ST1000`, inheriting from the
Staticcheck defaults:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="c3RhdGljY2hlY2suY29uZg==:Y2hlY2tzID0gWyJpbmhlcml0IiwgIlNUMTAwMCJdCg==" data-upload-term=".term1"><code class="language-toml">checks = [&#34;inherit&#34;, &#34;ST1000&#34;]
</code></pre>

Re-run Staticcheck to verify `ST1000` is reported:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
pets.go:1:1: at least one file in a package should have a package comment (ST1000)
</code></pre>

Excellent. Add a package comment to `pets.go` to fix the problem:


<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:Ly8gUGFja2FnZSBwZXRzIGNvbnRhaW5zIHVzZWZ1bCBmdW5jdGlvbmFsaXR5IGZvciBwZXQgb3duZXJzCnBhY2thZ2UgcGV0cwoKaW1wb3J0ICgKCSJmbXQiCikKCnR5cGUgQW5pbWFsIGludAoKY29uc3QgKAoJRG9nIEFuaW1hbCA9IGlvdGEKCVNuYWtlCikKCnR5cGUgUGV0IHN0cnVjdCB7CglLaW5kIEFuaW1hbAoJTmFtZSBzdHJpbmcKfQoKZnVuYyAocCBQZXQpIFdhbGsoKSBlcnJvciB7Cglzd2l0Y2ggcC5LaW5kIHsKCWNhc2UgRG9nOgoJCWZtdC5QcmludGYoIldpbGwgdGFrZSAldiBmb3IgYSB3YWxrIGFyb3VuZCB0aGUgYmxvY2tcbiIsIHAuTmFtZSkKCWRlZmF1bHQ6CgkJcmV0dXJuIGZtdC5FcnJvcmYoImNhbm5vdCB0YWtlICV2IGZvciBhIHdhbGsiLCBwLk5hbWUpCgl9CglyZXR1cm4gbmlsCn0KCmZ1bmMgKHAgUGV0KSBTdHJpbmcoKSBzdHJpbmcgewoJcmV0dXJuIHAuTmFtZQp9Cg==" data-upload-term=".term1"><code class="language-go"><b>// Package pets contains useful functionality for pet owners</b>
package pets

import (
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)
	default:
		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)
	&#125;
	return nil
&#125;

func (p Pet) String() string &#123;
	return p.Name
&#125;
</code></pre>

Re-run Staticcheck to confirm there are no further problems:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
</code></pre>


### Ignoring problems

Before going much further, you decide it's probably a good idea to be able to feed a pet, and so make the following
change to `pets.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:Ly8gUGFja2FnZSBwZXRzIGNvbnRhaW5zIHVzZWZ1bCBmdW5jdGlvbmFsaXR5IGZvciBwZXQgb3duZXJzCnBhY2thZ2UgcGV0cwoKaW1wb3J0ICgKCSJmbXQiCikKCnR5cGUgQW5pbWFsIGludAoKY29uc3QgKAoJRG9nIEFuaW1hbCA9IGlvdGEKCVNuYWtlCikKCnR5cGUgUGV0IHN0cnVjdCB7CglLaW5kIEFuaW1hbAoJTmFtZSBzdHJpbmcKfQoKZnVuYyAocCBQZXQpIFdhbGsoKSBlcnJvciB7Cglzd2l0Y2ggcC5LaW5kIHsKCWNhc2UgRG9nOgoJCWZtdC5QcmludGYoIldpbGwgdGFrZSAldiBmb3IgYSB3YWxrIGFyb3VuZCB0aGUgYmxvY2tcbiIsIHAuTmFtZSkKCWRlZmF1bHQ6CgkJcmV0dXJuIGZtdC5FcnJvcmYoImNhbm5vdCB0YWtlICV2IGZvciBhIHdhbGsiLCBwLk5hbWUpCgl9CglyZXR1cm4gbmlsCn0KCmZ1bmMgKHAgUGV0KSBGZWVkKGZvb2Qgc3RyaW5nKSB7Cglmb29kID0gZm9vZAoJZm10LlByaW50ZigiRmVlZGluZyAldiBzb21lICV2XG4iLCBwLk5hbWUsIGZvb2QpCn0KCmZ1bmMgKHAgUGV0KSBTdHJpbmcoKSBzdHJpbmcgewoJcmV0dXJuIHAuTmFtZQp9Cg==" data-upload-term=".term1"><code class="language-go">// Package pets contains useful functionality for pet owners
package pets

import (
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)
	default:
		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)
	&#125;
	return nil
&#125;

<b>func (p Pet) Feed(food string) &#123;</b>
<b>	food = food</b>
<b>	fmt.Printf(&#34;Feeding %v some %v\n&#34;, p.Name, food)</b>
<b>&#125;</b>
<b></b>
func (p Pet) String() string &#123;
	return p.Name
&#125;
</code></pre>

Re-run Staticcheck to verify all is still fine:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
pets.go:31:2: self-assignment of food to food (SA4018)
</code></pre>

Oops, that was careless. Whilst it's clear how you would fix this problem (and you really should!), is it possible to
tell Staticcheck to ignore problems of this kind?

In general, you shouldn't have to ignore problems reported by Staticcheck. Great care is taken to minimize the number of
false positives and subjective suggestions. Dubious code should be rewritten and genuine false positives should be
reported so that they can be fixed.

The reality of things, however, is that not all corner cases can be taken into consideration. Sometimes code just has to
look weird enough to confuse tools, and sometimes suggestions, though well-meant, just aren't applicable. For those rare
cases, there are several ways of ignoring unwanted problems.

This is not a rare or corner case, but let's use it as an opportunity to demonstrate linter directives.

The most fine-grained way of ignoring reported problems is to annotate the offending lines of code with linter directives. Let's
ignore `SA4018` using a line directive, updating `pets.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:Ly8gUGFja2FnZSBwZXRzIGNvbnRhaW5zIHVzZWZ1bCBmdW5jdGlvbmFsaXR5IGZvciBwZXQgb3duZXJzCnBhY2thZ2UgcGV0cwoKaW1wb3J0ICgKCSJmbXQiCikKCnR5cGUgQW5pbWFsIGludAoKY29uc3QgKAoJRG9nIEFuaW1hbCA9IGlvdGEKCVNuYWtlCikKCnR5cGUgUGV0IHN0cnVjdCB7CglLaW5kIEFuaW1hbAoJTmFtZSBzdHJpbmcKfQoKZnVuYyAocCBQZXQpIFdhbGsoKSBlcnJvciB7Cglzd2l0Y2ggcC5LaW5kIHsKCWNhc2UgRG9nOgoJCWZtdC5QcmludGYoIldpbGwgdGFrZSAldiBmb3IgYSB3YWxrIGFyb3VuZCB0aGUgYmxvY2tcbiIsIHAuTmFtZSkKCWRlZmF1bHQ6CgkJcmV0dXJuIGZtdC5FcnJvcmYoImNhbm5vdCB0YWtlICV2IGZvciBhIHdhbGsiLCBwLk5hbWUpCgl9CglyZXR1cm4gbmlsCn0KCmZ1bmMgKHAgUGV0KSBGZWVkKGZvb2Qgc3RyaW5nKSB7CgkvL2xpbnQ6aWdub3JlIFNBNDAxOCB0cnlpbmcgb3V0IGxpbmUtYmFzZWQgbGludGVyIGRpcmVjdGl2ZXMKCWZvb2QgPSBmb29kCglmbXQuUHJpbnRmKCJGZWVkaW5nICV2IHNvbWUgJXZcbiIsIHAuTmFtZSwgZm9vZCkKfQoKZnVuYyAocCBQZXQpIFN0cmluZygpIHN0cmluZyB7CglyZXR1cm4gcC5OYW1lCn0K" data-upload-term=".term1"><code class="language-go">// Package pets contains useful functionality for pet owners
package pets

import (
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)
	default:
		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)
	&#125;
	return nil
&#125;

func (p Pet) Feed(food string) &#123;
<b>	//lint:ignore SA4018 trying out line-based linter directives</b>
	food = food
	fmt.Printf(&#34;Feeding %v some %v\n&#34;, p.Name, food)
&#125;

func (p Pet) String() string &#123;
	return p.Name
&#125;
</code></pre>

Verify that Staticcheck no longer complains:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
</code></pre>

In some cases, however, you may want to disable checks for an entire file. For example, code generation may leave behind
a lot of unused code, as it simplifies the generation process. Instead of manually annotating every instance of unused
code, the code generator can inject a single, file-wide ignore directive to ignore the problem.

Let's change the line-based linter directive to a file-based one in `pets.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:Ly8gUGFja2FnZSBwZXRzIGNvbnRhaW5zIHVzZWZ1bCBmdW5jdGlvbmFsaXR5IGZvciBwZXQgb3duZXJzCnBhY2thZ2UgcGV0cwoKaW1wb3J0ICgKCSJmbXQiCikKCi8vbGludDpmaWxlLWlnbm9yZSBTQTQwMTggdHJ5aW5nIG91dCBmaWxlLWJhc2VkIGxpbnRlciBkaXJlY3RpdmVzCgp0eXBlIEFuaW1hbCBpbnQKCmNvbnN0ICgKCURvZyBBbmltYWwgPSBpb3RhCglTbmFrZQopCgp0eXBlIFBldCBzdHJ1Y3QgewoJS2luZCBBbmltYWwKCU5hbWUgc3RyaW5nCn0KCmZ1bmMgKHAgUGV0KSBXYWxrKCkgZXJyb3IgewoJc3dpdGNoIHAuS2luZCB7CgljYXNlIERvZzoKCQlmbXQuUHJpbnRmKCJXaWxsIHRha2UgJXYgZm9yIGEgd2FsayBhcm91bmQgdGhlIGJsb2NrXG4iLCBwLk5hbWUpCglkZWZhdWx0OgoJCXJldHVybiBmbXQuRXJyb3JmKCJjYW5ub3QgdGFrZSAldiBmb3IgYSB3YWxrIiwgcC5OYW1lKQoJfQoJcmV0dXJuIG5pbAp9CgpmdW5jIChwIFBldCkgRmVlZChmb29kIHN0cmluZykgewoJZm9vZCA9IGZvb2QKCWZtdC5QcmludGYoIkZlZWRpbmcgJXYgc29tZSAldlxuIiwgcC5OYW1lLCBmb29kKQp9CgpmdW5jIChwIFBldCkgU3RyaW5nKCkgc3RyaW5nIHsKCXJldHVybiBwLk5hbWUKfQo=" data-upload-term=".term1"><code class="language-go">// Package pets contains useful functionality for pet owners
package pets

import (
	&#34;fmt&#34;
)

<b>//lint:file-ignore SA4018 trying out file-based linter directives</b>
<b></b>
type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)
	default:
		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)
	&#125;
	return nil
&#125;

func (p Pet) Feed(food string) &#123;
	food = food
	fmt.Printf(&#34;Feeding %v some %v\n&#34;, p.Name, food)
&#125;

func (p Pet) String() string &#123;
	return p.Name
&#125;
</code></pre>

Verify that Staticcheck continues to ignore this check:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
</code></pre>

Great. That's both line and file-based linter directives covered, demonstrating how to ignore certain problems.

Finally, let's remove the linter directive, and fix up your code:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BldHM=" data-upload-src="cGV0cy5nbw==:Ly8gUGFja2FnZSBwZXRzIGNvbnRhaW5zIHVzZWZ1bCBmdW5jdGlvbmFsaXR5IGZvciBwZXQgb3duZXJzCnBhY2thZ2UgcGV0cwoKaW1wb3J0ICgKCSJmbXQiCikKCnR5cGUgQW5pbWFsIGludAoKY29uc3QgKAoJRG9nIEFuaW1hbCA9IGlvdGEKCVNuYWtlCikKCnR5cGUgUGV0IHN0cnVjdCB7CglLaW5kIEFuaW1hbAoJTmFtZSBzdHJpbmcKfQoKZnVuYyAocCBQZXQpIFdhbGsoKSBlcnJvciB7Cglzd2l0Y2ggcC5LaW5kIHsKCWNhc2UgRG9nOgoJCWZtdC5QcmludGYoIldpbGwgdGFrZSAldiBmb3IgYSB3YWxrIGFyb3VuZCB0aGUgYmxvY2tcbiIsIHAuTmFtZSkKCWRlZmF1bHQ6CgkJcmV0dXJuIGZtdC5FcnJvcmYoImNhbm5vdCB0YWtlICV2IGZvciBhIHdhbGsiLCBwLk5hbWUpCgl9CglyZXR1cm4gbmlsCn0KCmZ1bmMgKHAgUGV0KSBGZWVkKGZvb2Qgc3RyaW5nKSB7CglmbXQuUHJpbnRmKCJGZWVkaW5nICV2IHNvbWUgJXZcbiIsIHAuTmFtZSwgZm9vZCkKfQoKZnVuYyAocCBQZXQpIFN0cmluZygpIHN0cmluZyB7CglyZXR1cm4gcC5OYW1lCn0K" data-upload-term=".term1"><code class="language-go">// Package pets contains useful functionality for pet owners
package pets

import (
	&#34;fmt&#34;
)

type Animal int

const (
	Dog Animal = iota
	Snake
)

type Pet struct &#123;
	Kind Animal
	Name string
&#125;

func (p Pet) Walk() error &#123;
	switch p.Kind &#123;
	case Dog:
		fmt.Printf(&#34;Will take %v for a walk around the block\n&#34;, p.Name)
	default:
		return fmt.Errorf(&#34;cannot take %v for a walk&#34;, p.Name)
	&#125;
	return nil
&#125;

func (p Pet) Feed(food string) &#123;
	fmt.Printf(&#34;Feeding %v some %v\n&#34;, p.Name, food)
&#125;

func (p Pet) String() string &#123;
	return p.Name
&#125;
</code></pre>

And check that Staticcheck is happy one last time:

<pre data-command-src="c3RhdGljY2hlY2sgLgo="><code class="language-.term1">$ staticcheck .
</code></pre>

We can now be sure of lots of happy pets!

### Conclusion

This guide has provided you with an introduction to Staticcheck, and the power of static analysis. To learn more see:

* the ["Developer tools as module dependencies" guide](/tools-as-dependencies_go115_en) guide to see how to add tools
  like Staticcheck to a project.
* the [Staticcheck documentation](https://staticcheck.io/docs) for more details about Staticcheck itself.

As a next step you might like to consider:

* [Developer tools as module dependencies](/tools-as-dependencies_go115_en/)
* [Working with private modules](/working-with-private-modules_go115_en/)
* [Installing Go](/installing-go_go115_en/)






<script>let pageGuide="2020-11-09-using-staticcheck"; let pageLanguage="en"; let pageScenario="go115";</script>
