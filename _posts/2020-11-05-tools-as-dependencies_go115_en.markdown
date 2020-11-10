---
categories: beginner
guide: 2020-11-05-tools-as-dependencies
lang: en
layout: post
title: Developer tools as module dependencies
---

Go modules support developer tools (commands) as dependencies. For example, your project might require a tool to help
with code generation, or to lint/vet your code for correctness. Adding developer tool dependencies ensures that all
develpoers use the same version of each tool.

This guide shows you how to manage developer tool dependencies with a Go module, specifically the code generator[
`stringer`](https://pkg.go.dev/golang.org/x/tools/cmd/stringer).

You will:

* create a module that contains a `main` package (your "project" for this guide)
* add the `stringer` tool as a dependency
* use `stringer` via a `go:generate` directive

### Prerequisites

You should already have completed:

* The [Go fundamentals Tutorial](/go-fundamentals_go115_en)

This guide is running using:

```.term1
$ go version
go version go1.15.3 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### Why `stringer`?

Let's motivate the use of `stringer` by getting started on your project. Your project will be a simple command line
application that gives advice on what painkillers to take for certain ailments. So let's name your module accordingly:

```.term1
$ mkdir painkiller
$ cd painkiller
$ go mod init painkiller
go: creating new go.mod: module painkiller
```
{:data-command-src="bWtkaXIgcGFpbmtpbGxlcgpjZCBwYWlua2lsbGVyCmdvIG1vZCBpbml0IHBhaW5raWxsZXIK"}

Start with a basic version of your application. Given that you are writing a command line application, you need to
declare a `main` package; do so in a file named `painkiller.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="cGFpbmtpbGxlci5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCnR5cGUgUGlsbCBpbnQKCmNvbnN0ICgKCVBsYWNlYm8gUGlsbCA9IGlvdGEKCUlidXByb2ZlbgopCgpmdW5jIG1haW4oKSB7CglmbXQuUHJpbnRmKCJGb3IgaGVhZGFjaGVzLCB0YWtlICV2XG4iLCBJYnVwcm9mZW4pCn0K" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

type Pill int

const (
	Placebo Pill = iota
	Ibuprofen
)

func main() {
	fmt.Printf(&#34;For headaches, take %v\n&#34;, Ibuprofen)
}
</code></pre>

This first version of your app provides some basic advice on what to take for headaches. Using integer types provides a
nice convenient way to define a sequence of constant values. Here you define the type `Pill`.

Run the program to see its output:

```.term1
$ go run .
For headaches, take 1
```
{:data-command-src="Z28gcnVuIC4K"}

Hmm, that's not particularly user friendly. The integer value of your constant is meaningless to your user.

You can improve this by making the `Pill` type implement the
[`fmt.Stringer`](https://pkg.go.dev/fmt#Stringer) interface:

<pre><code>type Stringer interface {
	String() string
}
</code></pre>

The `String()` method defines the "native" format for a
value.

Update your example to define a `String()` method on `Pill`:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="cGFpbmtpbGxlci5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCnR5cGUgUGlsbCBpbnQKCmZ1bmMgKHAgUGlsbCkgU3RyaW5nKCkgc3RyaW5nIHsKCXN3aXRjaCBwIHsKCWNhc2UgUGxhY2VibzoKCQlyZXR1cm4gIlBsYWNlYm8iCgljYXNlIElidXByb2ZlbjoKCQlyZXR1cm4gIklidXByb2ZlbiIKCWRlZmF1bHQ6CgkJcGFuaWMoZm10LkVycm9yZigidW5rbm93biBQaWxsIHZhbHVlICV2IiwgcCkpCgl9Cn0KCmNvbnN0ICgKCVBsYWNlYm8gUGlsbCA9IGlvdGEKCUlidXByb2ZlbgopCgpmdW5jIG1haW4oKSB7CglmbXQuUHJpbnRmKCJGb3IgaGVhZGFjaGVzLCB0YWtlICV2XG4iLCBJYnVwcm9mZW4pCn0K" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

type Pill int

<b>func (p Pill) String() string {</b>
<b>	switch p {</b>
<b>	case Placebo:</b>
<b>		return &#34;Placebo&#34;</b>
<b>	case Ibuprofen:</b>
<b>		return &#34;Ibuprofen&#34;</b>
<b>	default:</b>
<b>		panic(fmt.Errorf(&#34;unknown Pill value %v&#34;, p))</b>
<b>	}</b>
<b>}</b>
<b></b>
const (
	Placebo Pill = iota
	Ibuprofen
)

func main() {
	fmt.Printf(&#34;For headaches, take %v\n&#34;, Ibuprofen)
}
</code></pre>

Run the program to see the new output:

```.term1
$ go run .
For headaches, take Ibuprofen
```
{:data-command-src="Z28gcnVuIC4K"}

That's better. But as you can see there is a lot of repetition in your `String()` method. Adding more constants will
mean more manual, robotic effort... not to mention being error prone. Can we do better? Enter `stringer`.

`stringer` is a tool to automate the creation of methods that satisfy the
[`fmt.Stringer`](https://pkg.go.dev/fmt#Stringer) interface. Given the name of an (signed or unsigned) integer type `T`
that has constants defined, `stringer` will create a new self-contained Go source file implementing:

<pre><code>func (t T) String() string
</code></pre>

This sounds much better than maintaining a definition by hand, so let's add `stringer` as a dependency.

But before you do, remove the hand-written `String()` method:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="cGFpbmtpbGxlci5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCnR5cGUgUGlsbCBpbnQKCmNvbnN0ICgKCVBsYWNlYm8gUGlsbCA9IGlvdGEKCUlidXByb2ZlbgopCgpmdW5jIG1haW4oKSB7CglmbXQuUHJpbnRmKCJGb3IgaGVhZGFjaGVzLCB0YWtlICV2XG4iLCBJYnVwcm9mZW4pCn0K" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

type Pill int

const (
	Placebo Pill = iota
	Ibuprofen
)

func main() {
	fmt.Printf(&#34;For headaches, take %v\n&#34;, Ibuprofen)
}
</code></pre>

### Adding tool dependencies

Go modules establishes a convention for tool dependencies. You simply import the command as you would any other package,
but do so in a special file that is ignored by any of the `go` build commands. Again, by convention, these imports are
declared in a file called `tools.go` at the root of your module:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="dG9vbHMuZ28=:Ly8gK2J1aWxkIHRvb2xzCgpwYWNrYWdlIHRvb2xzCgppbXBvcnQgKAoJXyAiZ29sYW5nLm9yZy94L3Rvb2xzL2NtZC9zdHJpbmdlciIKKQo=" data-upload-term=".term1"><code class="language-go">// +build tools

package tools

import (
	_ &#34;golang.org/x/tools/cmd/stringer&#34;
)
</code></pre>

In this code you:

* Declare a [build constraint](https://pkg.go.dev/go/build#hdr-Build_Constraints) on the first line of
  `tools.go`. This tells the `go` command to only consider this file when the `tools`
build tag is provided. By convention, `tools` is used as the constraint name.
* Declare that `tools.go` belongs to the `tools` package. Because this file is going to
  be ignored by `go` build commands, it actually doesn't matter what package it belongs to. But again, by convention,
it is generally considered good practice to use `tools` as the package name.
* Import `golang.org/x/tools/cmd/stringer`, which declares a dependency relation between your `main` package and `stringer`.
  But hang on a minute: isn't `stringer` a command, and therefore a `main` package itself? How does this work? Again,
because this file is going to be ignore by `go` build commands the fact that you are importing a `main` package doesn't
actually matter. You are only importing `golang.org/x/tools/cmd/stringer` to declare the dependency on that package. And because
you don't use the imported `golang.org/x/tools/cmd/stringer` package, the blank identifier `_` is used to signal the import
exists solely for its side effects, in this case the declaration of the dependency.

With the package dependency declared, you can now add a dependency on the module that contains
`golang.org/x/tools/cmd/stringer`. Use `go get` to add a dependency:

```.term1
$ go get golang.org/x/tools/cmd/stringer@v0.0.0-20201105220310-78b158585360
go: downloading golang.org/x/tools v0.0.0-20201105220310-78b158585360
go: found golang.org/x/tools/cmd/stringer in golang.org/x/tools v0.0.0-20201105220310-78b158585360
go: downloading golang.org/x/mod v0.3.0
go: downloading golang.org/x/xerrors v0.0.0-20200804184101-5ec99f83aff1
```
{:data-command-src="Z28gZ2V0IGdvbGFuZy5vcmcveC90b29scy9jbWQvc3RyaW5nZXJAdjAuMC4wLTIwMjAxMTA1MjIwMzEwLTc4YjE1ODU4NTM2MAo="}

You can see your new dependency in the project's `go.mod` file:

```.term1
$ cat go.mod
module painkiller

go 1.15

require golang.org/x/tools v0.0.0-20201105220310-78b158585360 // indirect
```
{:data-command-src="Y2F0IGdvLm1vZAo="}

This guide uses a specific version of `stringer` so as to remain reproducible. In a real-world project you would almost
certainly omit the version to get the latest version, or explicitly use the special version `@latest`. Alternatively,
you could simply run `go mod tidy` instead of `go get`:

```.term1
$ go mod tidy
```
{:data-command-src="Z28gbW9kIHRpZHkK"}

Run `stringer` to see how it should be invoked:

```.term1
$ go run golang.org/x/tools/cmd/stringer -help
Usage of stringer:
	stringer [flags] -type T [directory]
	stringer [flags] -type T files... # Must be a single package
For more information, see:
	https://pkg.go.dev/golang.org/x/tools/cmd/stringer
Flags:
  -linecomment
    	use line comment text as printed text when present
  -output string
    	output file name; default srcdir/<type>_string.go
  -tags string
    	comma-separated list of build tags to apply
  -trimprefix prefix
    	trim the prefix from the generated constant names
  -type string
    	comma-separated list of type names; must be set
```
{:data-command-src="Z28gcnVuIGdvbGFuZy5vcmcveC90b29scy9jbWQvc3RyaW5nZXIgLWhlbHAK"}

As you can see, `Pill` must be passed as an argument to the `-type` flag:

```.term1
$ go run golang.org/x/tools/cmd/stringer -type Pill
```
{:data-command-src="Z28gcnVuIGdvbGFuZy5vcmcveC90b29scy9jbWQvc3RyaW5nZXIgLXR5cGUgUGlsbAo="}

Listing the directory contents reveals what `stringer` has generated for us:

```.term1
$ ls
go.mod	go.sum	painkiller.go  pill_string.go  tools.go
```
{:data-command-src="bHMK"}

Examine the contents of the `stringer`-generated file:

```.term1
$ cat pill_string.go
// Code generated by "stringer -type Pill"; DO NOT EDIT.

package main

import "strconv"

func _() {
	// An "invalid array index" compiler error signifies that the constant values have changed.
	// Re-run the stringer command to generate them again.
	var x [1]struct{}
	_ = x[Placebo-0]
	_ = x[Ibuprofen-1]
}

const _Pill_name = "PlaceboIbuprofen"

var _Pill_index = [...]uint8{0, 7, 16}

func (i Pill) String() string {
	if i < 0 || i >= Pill(len(_Pill_index)-1) {
		return "Pill(" + strconv.FormatInt(int64(i), 10) + ")"
	}
	return _Pill_name[_Pill_index[i]:_Pill_index[i+1]]
}
```
{:data-command-src="Y2F0IHBpbGxfc3RyaW5nLmdvCg=="}

Notice the first line of this generated file is a comment warning you against editing it by hand: this "header" is a
[standard convention](https://golang.org/cmd/go/#hdr-Generate_Go_files_by_processing_source) of generated files.

Run your program to verify it behaves as expected:

```.term1
$ go run .
For headaches, take Ibuprofen
```
{:data-command-src="Z28gcnVuIC4K"}

Success!

### Using `stringer` via a `go:generate` directive

It is not fair or realistic to expect your fellow developers to remember the command for re-running
`stringer`. A more scalable approach is to declare a
[`go:generate`](https://golang.org/cmd/go/#hdr-Generate_Go_files_by_processing_source) directive for each code
generation step needed for your project:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="cGFpbmtpbGxlci5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCi8vZ286Z2VuZXJhdGUgZ28gcnVuIGdvbGFuZy5vcmcveC90b29scy9jbWQvc3RyaW5nZXIgLXR5cGU9UGlsbAoKdHlwZSBQaWxsIGludAoKY29uc3QgKAoJUGxhY2VibyBQaWxsID0gaW90YQoJSWJ1cHJvZmVuCikKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGYoIkZvciBoZWFkYWNoZXMsIHRha2UgJXZcbiIsIElidXByb2ZlbikKfQo=" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

<b>//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill</b>
<b></b>
type Pill int

const (
	Placebo Pill = iota
	Ibuprofen
)

func main() {
	fmt.Printf(&#34;For headaches, take %v\n&#34;, Ibuprofen)
}
</code></pre>

Now you can re-run all code generation steps (there is currently only one, but still) for current package by running:

```.term1
$ go generate .
```
{:data-command-src="Z28gZ2VuZXJhdGUgLgo="}

Try this out by extending your program to give another piece of advice:

<pre data-upload-path="L2hvbWUvZ29waGVyL3BhaW5raWxsZXI=" data-upload-src="cGFpbmtpbGxlci5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCi8vZ286Z2VuZXJhdGUgZ28gcnVuIGdvbGFuZy5vcmcveC90b29scy9jbWQvc3RyaW5nZXIgLXR5cGU9UGlsbAoKdHlwZSBQaWxsIGludAoKY29uc3QgKAoJUGxhY2VibyBQaWxsID0gaW90YQoJSWJ1cHJvZmVuCglQYXJhY2V0YW1vbAopCgpmdW5jIG1haW4oKSB7CglmbXQuUHJpbnRmKCJGb3IgaGVhZGFjaGVzLCB0YWtlICV2XG4iLCBJYnVwcm9mZW4pCglmbXQuUHJpbnRmKCJGb3IgYSBmZXZlciwgdGFrZSAldlxuIiwgUGFyYWNldGFtb2wpCn0K" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

//go:generate go run golang.org/x/tools/cmd/stringer -type=Pill

type Pill int

const (
	Placebo Pill = iota
	Ibuprofen
<b>	Paracetamol</b>
)

func main() {
	fmt.Printf(&#34;For headaches, take %v\n&#34;, Ibuprofen)
<b>	fmt.Printf(&#34;For a fever, take %v\n&#34;, Paracetamol)</b>
}
</code></pre>

Re-run your code generation steps:

```.term1
$ go generate .
```
{:data-command-src="Z28gZ2VuZXJhdGUgLgo="}

Finally, check your program's output:

```.term1
$ go run .
For headaches, take Ibuprofen
For a fever, take Paracetamol
```
{:data-command-src="Z28gcnVuIC4K"}

### Conclusion

That's it! This guide has shown you how to add tool dependencies to a module, with a focus on the `stringer`
code generation tool and its use via `go generate`.


<script>let pageGuide="2020-11-05-tools-as-dependencies"; let pageLanguage="en"; let pageScenario="go115";</script>
