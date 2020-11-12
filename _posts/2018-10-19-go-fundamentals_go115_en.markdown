---
category: Start here
difficulty: Beginner
excerpt: Primer on creating and using go modules
guide: 2018-10-19-go-fundamentals
lang: en
layout: post
title: 'Tutorial: Go fundamentals'
---

_This tutorial is based on the official ["Create a module"](https://golang.org/doc/tutorial/create-module) tutorial._

This tutorial introduces a few fundamental features of the Go language. If you're just getting started with Go, be sure
to take a look at the [getting started tutorial](/get-started-with-go/), which introduces the go command, Go modules,
and very simple Go code.

In this tutorial you'll create two modules. The first is a library which is intended to be imported by other libraries
or applications. The second is a caller application which will use the first.

This tutorial's sequence includes six brief topics that each illustrate a different part of the language.

1. Create a module -- Write a small module with functions you can call from another module.
1. Call your code from another module -- Import and use your new module.
1. Return and handle an error -- Add simple error handling.
1. Return a random greeting -- Handle data in slices (Go's dynamically-sized arrays).
1. Return greetings for multiple people -- Store key/value pairs in a map.
1. Add a test -- Use Go's built-in unit testing features to test your code.
1. Compile and install the application -- Compile and install your code locally.

This guide requires you to push code to remote source code repositories. A unique user, `{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}`, has
been automatically created for you, as have the repositories [`{% raw %}{{{.GREETINGS}}}{% endraw %}`](https://{% raw %}{{{.GREETINGS}}}{% endraw %}.git) and
[`{% raw %}{{{.HELLO}}}{% endraw %}`](https://{% raw %}{{{.HELLO}}}{% endraw %}.git). For more details on how `play-with-go.dev` guides work, please see the
[_Introduction to `play-with-go.dev` guides_](ntro-to-play-with-go-dev/) guide.

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Tutorial: Get started with Go](/get-started-with-go/)

This guide is running using:

```.term1
$ go version
go version go1.15.3 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### Create a module that others can use

Start by creating a [Go module](https://golang.org/doc/code.html#Organization). In a module, you collect one or more
related packages for a discrete and useful set of functions. For example, you might create a module with packages that
have functions for doing financial analysis so that others writing financial applications can use your work.

Go code is grouped into packages, and packages are grouped into modules. Your package's module specifies the context Go
needs to run the code, including the Go version the code is written for and the set of other modules it requires.

As you add or improve functionality in your module, you publish new versions of the module. Developers writing code that
calls functions in your module can import the module's updated packages and test with the new version before putting it
into production use.

As with all play-with-go.dev guides, you start in your home directory:

```.term1
$ pwd
/home/gopher
```
{:data-command-src="cHdkCg=="}

Create a `greetings` directory for your Go module source code. This is where you'll write your module code:

```.term1
$ mkdir /home/gopher/greetings
$ cd /home/gopher/greetings
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dyZWV0aW5ncwpjZCAvaG9tZS9nb3BoZXIvZ3JlZXRpbmdzCg=="}

Start your module using the [`go mod init`
command](https://golang.org/cmd/go/#hdr-Initialize_new_module_in_current_directory) to create a `go.mod` file.  In this
guide you will publish your greetings module to `{% raw %}{{{.GREETINGS}}}{% endraw %}`:

```.term1
$ go mod init {% raw %}{{{.GREETINGS}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.GREETINGS}}}{% endraw %}
```
{:data-command-src="Z28gbW9kIGluaXQge3t7LkdSRUVUSU5HU319fQo="}

The `go mod init` command creates a `go.mod` file that identifies your code as a module that might be used from
other code.  The file you just created includes only the name of your module and the Go version your code supports:

```.term1
$ cat go.mod
module {% raw %}{{{.GREETINGS}}}{% endraw %}

go 1.15
```
{:data-command-src="Y2F0IGdvLm1vZAo="}

As you add dependencies -- meaning packages from other modules -- the `go.mod` file will list the specific module
versions to use.  This keeps builds reproducible and gives you direct control over which module versions to use.

Now let's create greetings.go:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAiZm10IgoKLy8gSGVsbG8gcmV0dXJucyBhIGdyZWV0aW5nIGZvciB0aGUgbmFtZWQgcGVyc29uLgpmdW5jIEhlbGxvKG5hbWUgc3RyaW5nKSBzdHJpbmcgewoJLy8gUmV0dXJuIGEgZ3JlZXRpbmcgdGhhdCBlbWJlZHMgdGhlIG5hbWUgaW4gYSBtZXNzYWdlLgoJbWVzc2FnZSA6PSBmbXQuU3ByaW50ZigiSGksICV2LiBXZWxjb21lISIsIG5hbWUpCglyZXR1cm4gbWVzc2FnZQp9Cg==" data-upload-term=".term1"><code class="language-go">package greetings

import &#34;fmt&#34;

// Hello returns a greeting for the named person.
func Hello(name string) string {
	// Return a greeting that embeds the name in a message.
	message := fmt.Sprintf(&#34;Hi, %v. Welcome!&#34;, name)
	return message
}
</code></pre>

This is the first code for your module. It returns a greeting to any caller that asks for one. You'll write code that
calls this function in the next step.

In this code, you:

* Declare a `greetings` package to collect related functions.
* Implement a Hello function to return the greeting. This function takes a name parameter whose type is `string`, and
  returns a `string`. In Go, a function whose name starts with a capital letter can be called by a function not in the
  same package. This is known in Go as an [exported name](https://tour.golang.org/basics/3).
* Declare a `message` variable to hold your greeting. In Go, the `:=` operator is a shortcut for declaring and
  initializing a variable in one line (Go uses the value on the right to determine the variable's type). Let's rewrite
  this the long way:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAiZm10IgoKLy8gSGVsbG8gcmV0dXJucyBhIGdyZWV0aW5nIGZvciB0aGUgbmFtZWQgcGVyc29uLgpmdW5jIEhlbGxvKG5hbWUgc3RyaW5nKSBzdHJpbmcgewoJLy8gUmV0dXJuIGEgZ3JlZXRpbmcgdGhhdCBlbWJlZHMgdGhlIG5hbWUgaW4gYSBtZXNzYWdlLgoJdmFyIG1lc3NhZ2Ugc3RyaW5nCgltZXNzYWdlID0gZm10LlNwcmludGYoIkhpLCAldi4gV2VsY29tZSEiLCBuYW1lKQoJcmV0dXJuIG1lc3NhZ2UKfQo=" data-upload-term=".term1"><code class="language-go">package greetings

import &#34;fmt&#34;

// Hello returns a greeting for the named person.
func Hello(name string) string {
	// Return a greeting that embeds the name in a message.
<b>	var message string</b>
<b>	message = fmt.Sprintf(&#34;Hi, %v. Welcome!&#34;, name)</b>
	return message
}
</code></pre>

* Use the `fmt` package's [`Sprintf`](https://pkg.go.dev/fmt#Sprintf) function to create a greeting message. The first
  argument is a format string, and `Sprintf` substitutes the name parameter's value for the `%v` format verb. Inserting
  the value of the name parameter completes the greeting text.
* Return the formatted greeting text to the caller.

For people to be able to use your module you need to publish it. You publish a module by pushing a commit to a version
control system like [GitHub](https://github.com/). You will publish your module to [`{% raw %}{{{.GREETINGS}}}{% endraw %}`](https://{% raw %}{{{.GREETINGS}}}{% endraw %}.git).

Initialise a local  `git` repository for your `greetings` module:

```.term1
$ git init -q
$ git remote add origin https://{% raw %}{{{.GREETINGS}}}{% endraw %}.git
```
{:data-command-src="Z2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LkdSRUVUSU5HU319fS5naXQK"}

Add and commit the `greetings.go` file you created earlier:

```.term1
$ git add greetings.go
$ git commit -q -m 'Initial commit'
```
{:data-command-src="Z2l0IGFkZCBncmVldGluZ3MuZ28KZ2l0IGNvbW1pdCAtcSAtbSAnSW5pdGlhbCBjb21taXQnCg=="}

Publish this commit by pushing it to the remote repository:

```.term1
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"}



### Call your code from another module

You'll now write code that you can execute as an application, which makes calls to the `Hello` function in the `greetings` module you published to `{% raw %}{{{.GREETINGS}}}{% endraw %}`.

Create the directory `/home/gopher/hello` for your Go module source code. This is where you'll write your caller.

```.term1
$ mkdir /home/gopher/hello
$ cd /home/gopher/hello
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2hlbGxvCmNkIC9ob21lL2dvcGhlci9oZWxsbwo="}

Create a new module for this `hello` package using the `go mod init` command to create a `go.mod`
file as you did before, but this time using the unique path for the `hello` module:

```.term1
$ go mod init {% raw %}{{{.HELLO}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.HELLO}}}{% endraw %}
```
{:data-command-src="Z28gbW9kIGluaXQge3t7LkhFTExPfX19Cg=="}

Declare a dependency on `{% raw %}{{{.GREETINGS}}}{% endraw %}` using [`go get`](https://golang.org/ref/mod#go-get):

```.term1
$ go get {% raw %}{{{.GREETINGS}}}{% endraw %}
go: downloading {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345
go: {% raw %}{{{.GREETINGS}}}{% endraw %} upgrade => v0.0.0-20060102150405-abcedf12345
```
{:data-command-src="Z28gZ2V0IHt7ey5HUkVFVElOR1N9fX0K"}

Without any version specified, `go get` will retrieve the latest version of the `greetings` module. And
because you didn't publish a specific version, `go get` resolves a [pseudo
version](https://golang.org/ref/mod#pseudo-versions) from the commit you pushed, specifically:

```.term1
$ go list -m -f {% raw %}{{{% endraw %}.Version{% raw %}}}{% endraw %} {% raw %}{{{.GREETINGS}}}{% endraw %}
v0.0.0-20060102150405-abcedf12345
```
{:data-command-src="Z28gbGlzdCAtbSAtZiB7ey5WZXJzaW9ufX0ge3t7LkdSRUVUSU5HU319fQo="}

Create `hello.go` as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCgkie3t7LkdSRUVUSU5HU319fSIKKQoKZnVuYyBtYWluKCkgewoJLy8gR2V0IGEgZ3JlZXRpbmcgbWVzc2FnZSBhbmQgcHJpbnQgaXQuCgltZXNzYWdlIDo9IGdyZWV0aW5ncy5IZWxsbygiR2xhZHlzIikKCWZtdC5QcmludGxuKG1lc3NhZ2UpCn0K" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;

	&#34;{% raw %}{{{.GREETINGS}}}{% endraw %}&#34;
)

func main() {
	// Get a greeting message and print it.
	message := greetings.Hello(&#34;Gladys&#34;)
	fmt.Println(message)
}
</code></pre>

In this code, you:

* Declare a `main` package. In Go, code executed as an application must go in a `main` package.
* Import two packages: `{% raw %}{{{.GREETINGS}}}{% endraw %}` and `fmt`. This gives your code access to functions in those packages.
  Importing `{% raw %}{{{.GREETINGS}}}{% endraw %}` (the package contained in the module you created earlier) gives you access to the
`Hello` function. You also import `fmt`, with functions for handling input and output text (such as printing text to the
console).
* Get a greeting by calling the `greetings` package’s `Hello` function.

Build and run your program:

```.term1
$ go build
$ ./hello
Hi, Gladys. Welcome!
```
{:data-command-src="Z28gYnVpbGQKLi9oZWxsbwo="}

Congrats! You've written two functioning modules. Next you'll add some error handling.

### Return and handle an error

Handling errors is an essential feature of solid code. In this section, you'll add a bit of code to return an error from
the `greetings` module, then handle it in the caller.

Return to the `greetings` module directory:

```.term1
$ cd /home/gopher/greetings
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dyZWV0aW5ncwo="}

There's no sense sending a greeting back if you don't know who to greet. Return an error to the caller if the name is
empty. Update `greetings.go` as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkiZXJyb3JzIgoJImZtdCIKKQoKLy8gSGVsbG8gcmV0dXJucyBhIGdyZWV0aW5nIGZvciB0aGUgbmFtZWQgcGVyc29uLgpmdW5jIEhlbGxvKG5hbWUgc3RyaW5nKSAoc3RyaW5nLCBlcnJvcikgewoJLy8gSWYgbm8gbmFtZSB3YXMgZ2l2ZW4sIHJldHVybiBhbiBlcnJvciB3aXRoIGEgbWVzc2FnZS4KCWlmIG5hbWUgPT0gIiIgewoJCXJldHVybiAiIiwgZXJyb3JzLk5ldygiZW1wdHkgbmFtZSIpCgl9CgoJLy8gSWYgYSBuYW1lIHdhcyByZWNlaXZlZCwgcmV0dXJuIGEgdmFsdWUgdGhhdCBlbWJlZHMgdGhlIG5hbWUKCS8vIGluIGEgZ3JlZXRpbmcgbWVzc2FnZS4KCW1lc3NhZ2UgOj0gZm10LlNwcmludGYoIkhpLCAldi4gV2VsY29tZSEiLCBuYW1lKQoJcmV0dXJuIG1lc3NhZ2UsIG5pbAp9Cg==" data-upload-term=".term1"><code class="language-go">package greetings

<b>import (</b>
<b>	&#34;errors&#34;</b>
<b>	&#34;fmt&#34;</b>
<b>)</b>

// Hello returns a greeting for the named person.
<b>func Hello(name string) (string, error) {</b>
<b>	// If no name was given, return an error with a message.</b>
<b>	if name == &#34;&#34; {</b>
<b>		return &#34;&#34;, errors.New(&#34;empty name&#34;)</b>
<b>	}</b>
<b></b>
<b>	// If a name was received, return a value that embeds the name</b>
<b>	// in a greeting message.</b>
<b>	message := fmt.Sprintf(&#34;Hi, %v. Welcome!&#34;, name)</b>
<b>	return message, nil</b>
}
</code></pre>

In this code, you:

* Change the function so that it returns two values: a `string` and an `error`. Your caller will check the second value to
  see if an error occurred. (Any Go function can return multiple values.)
* Import the Go standard library `errors` package so you can use its `errors.New` function.
* Add an `if` statement to check for an invalid request (an empty string where the name should be) and return an error
  if the request is invalid. The `errors.New` function returns an error with your message inside.
* Add `nil` (meaning no error) as a second value in the successful return. That way, the caller can see that the
  function succeeded.

At this point your `hello` module is referring to a pseudo version that represents the previous commit you
pushed. Therefore, you need to publish a new version of the `greetings` module.

Add and commit the changes we made to `greetings.go`:

```.term1
$ git add greetings.go
$ git commit -q -m 'Added error handling'
```
{:data-command-src="Z2l0IGFkZCBncmVldGluZ3MuZ28KZ2l0IGNvbW1pdCAtcSAtbSAnQWRkZWQgZXJyb3IgaGFuZGxpbmcnCg=="}

Note the id of the commit we just created:

```.term1
$ greetings_error_commit=$(git rev-parse HEAD)
```
{:data-command-src="Z3JlZXRpbmdzX2Vycm9yX2NvbW1pdD0kKGdpdCByZXYtcGFyc2UgSEVBRCkK"}

Republish the `greetings` module:

```.term1
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"}

Return to the `hello` module directory to now use this new version:

```.term1
$ cd /home/gopher/hello
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2hlbGxvCg=="}

By default, `go get` uses [`proxy.golang.org`](https://proxy.golang.org/) to resolve and download modules. In order to
improve the proxy's caching and serving latencies, new versions may not show up right away. Therefore, to be sure you do
not resolve a stale latest version, use the latest commit of the `greetings` module as an explicit version:

```.term1
$ go get {% raw %}{{{.GREETINGS}}}{% endraw %}@$greetings_error_commit
go: {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
go: downloading {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345
```
{:data-command-src="Z28gZ2V0IHt7ey5HUkVFVElOR1N9fX1AJGdyZWV0aW5nc19lcnJvcl9jb21taXQK"}

In your hello.go, handle the error now returned by the `Hello` function, along with the non-error value:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCSJsb2ciCgoJInt7ey5HUkVFVElOR1N9fX0iCikKCmZ1bmMgbWFpbigpIHsKCS8vIFNldCBwcm9wZXJ0aWVzIG9mIHRoZSBwcmVkZWZpbmVkIExvZ2dlciwgaW5jbHVkaW5nCgkvLyB0aGUgbG9nIGVudHJ5IHByZWZpeCBhbmQgYSBmbGFnIHRvIGRpc2FibGUgcHJpbnRpbmcKCS8vIHRoZSB0aW1lLCBzb3VyY2UgZmlsZSwgYW5kIGxpbmUgbnVtYmVyLgoJbG9nLlNldFByZWZpeCgiZ3JlZXRpbmdzOiAiKQoJbG9nLlNldEZsYWdzKDApCgoJLy8gUmVxdWVzdCBhIGdyZWV0aW5nIG1lc3NhZ2UuCgltZXNzYWdlLCBlcnIgOj0gZ3JlZXRpbmdzLkhlbGxvKCIiKQoJLy8gSWYgYW4gZXJyb3Igd2FzIHJldHVybmVkLCBwcmludCBpdCB0byB0aGUgY29uc29sZSBhbmQKCS8vIGV4aXQgdGhlIHByb2dyYW0uCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoKCS8vIElmIG5vIGVycm9yIHdhcyByZXR1cm5lZCwgcHJpbnQgdGhlIHJldHVybmVkIG1lc3NhZ2UKCS8vIHRvIHRoZSBjb25zb2xlLgoJZm10LlByaW50bG4obWVzc2FnZSkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;
<b>	&#34;log&#34;</b>

	&#34;{% raw %}{{{.GREETINGS}}}{% endraw %}&#34;
)

func main() {
<b>	// Set properties of the predefined Logger, including</b>
<b>	// the log entry prefix and a flag to disable printing</b>
<b>	// the time, source file, and line number.</b>
<b>	log.SetPrefix(&#34;greetings: &#34;)</b>
<b>	log.SetFlags(0)</b>
<b></b>
<b>	// Request a greeting message.</b>
<b>	message, err := greetings.Hello(&#34;&#34;)</b>
<b>	// If an error was returned, print it to the console and</b>
<b>	// exit the program.</b>
<b>	if err != nil {</b>
<b>		log.Fatal(err)</b>
<b>	}</b>
<b></b>
<b>	// If no error was returned, print the returned message</b>
<b>	// to the console.</b>
	fmt.Println(message)
}
</code></pre>

In this code, you:

* Configure the [`log` package](https://golang.org/pkg/log/) to print the command name (`"greetings: "`) at the start of its log messages, without a time stamp or source file information.
* Assign both of the `Hello` return values, including the error, to variables.
* Change the `Hello` argument from Gladys’s name to an empty string, so you can try out your error-handling code.
* Look for a non-nil error value. There's no sense continuing in this case.
* Use the functions in the standard library's `log` package to output error information. If you get an error, you use
  the log package's `Fatal` function to print the error and stop the program.

Run hello.go to confirm that the code works; now that you're passing in an empty name, you'll get an error:

```.term1
$ go run hello.go
greetings: empty name
exit status 1
```
{:data-command-src="Z28gcnVuIGhlbGxvLmdvCg=="}

That's essentially how error handling in Go works: Return an error as a value so the caller can check for it. It's
pretty simple.

### Return a random greeting

Now you'll change your code so that instead of returning the same greeting every time, it returns one of several
predefined greeting messages.

To do this, you'll use a Go slice. A [slice](https://blog.golang.org/slices-intro) is like an array, except that it's
dynamically sized as you add and remove items. It's one of the most useful types in Go. You'll add a small slice to
contain three greeting messages, then have your code return one of the messages randomly.

Return to the `greetings` module:

```.term1
$ cd /home/gopher/greetings
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dyZWV0aW5ncwo="}

Update `greetings.go` as follows:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkiZXJyb3JzIgoJImZtdCIKCSJtYXRoL3JhbmQiCikKCi8vIEhlbGxvIHJldHVybnMgYSBncmVldGluZyBmb3IgdGhlIG5hbWVkIHBlcnNvbi4KZnVuYyBIZWxsbyhuYW1lIHN0cmluZykgKHN0cmluZywgZXJyb3IpIHsKCS8vIElmIG5vIG5hbWUgd2FzIGdpdmVuLCByZXR1cm4gYW4gZXJyb3Igd2l0aCBhIG1lc3NhZ2UuCglpZiBuYW1lID09ICIiIHsKCQlyZXR1cm4gbmFtZSwgZXJyb3JzLk5ldygiZW1wdHkgbmFtZSIpCgl9CgkvLyBDcmVhdGUgYSBtZXNzYWdlIHVzaW5nIGEgcmFuZG9tIGZvcm1hdC4KCW1lc3NhZ2UgOj0gZm10LlNwcmludGYocmFuZG9tRm9ybWF0KCksIG5hbWUpCglyZXR1cm4gbWVzc2FnZSwgbmlsCn0KCi8vIGluaXQgc2V0cyBpbml0aWFsIHZhbHVlcyBmb3IgdmFyaWFibGVzIHVzZWQgaW4gdGhlIGZ1bmN0aW9uLgpmdW5jIGluaXQoKSB7CgkvLyBGb3IgdHJ1bHkgcmFuZG9tIGdyZWV0aW5ncywgaW1wb3J0ICJ0aW1lIiBhbmQgcmVwbGFjZSB0aGUgY2FsbAoJLy8gdG8gcmFuZC5TZWVkIHdpdGg6CgkvLwoJLy8gcmFuZC5TZWVkKHRpbWUuTm93KCkuVW5peE5hbm8oKSkKCS8vCgkvLyBDYWxsaW5nIHJhbmQuU2VlZCB3aXRoIGEgY29uc3RhbnQgdmFsdWUgbWVhbnMgdGhhdCB3ZSBhbHdheXMKCS8vIGdlbmVyYXRlIHRoZSBzYW1lIHBzZXVkby1yYW5kb20gc2VxdWVuY2UuCglyYW5kLlNlZWQoMSkKfQoKLy8gcmFuZG9tRm9ybWF0IHJldHVybnMgb25lIG9mIGEgc2V0IG9mIGdyZWV0aW5nIG1lc3NhZ2VzLiBUaGUgcmV0dXJuZWQKLy8gbWVzc2FnZSBpcyBzZWxlY3RlZCBhdCByYW5kb20uCmZ1bmMgcmFuZG9tRm9ybWF0KCkgc3RyaW5nIHsKCS8vIEEgc2xpY2Ugb2YgbWVzc2FnZSBmb3JtYXRzLgoJZm9ybWF0cyA6PSBbXXN0cmluZ3sKCQkiSGksICV2LiBXZWxjb21lISIsCgkJIkdyZWF0IHRvIHNlZSB5b3UsICV2ISIsCgkJIkhhaWwsICV2ISBXZWxsIG1ldCEiLAoJfQoKCS8vIFJldHVybiBvbmUgb2YgdGhlIG1lc3NhZ2UgZm9ybWF0cyBzZWxlY3RlZCBhdCByYW5kb20uCglyZXR1cm4gZm9ybWF0c1tyYW5kLkludG4obGVuKGZvcm1hdHMpKV0KfQo=" data-upload-term=".term1"><code class="language-go">package greetings

<b>import (</b>
<b>	&#34;errors&#34;</b>
<b>	&#34;fmt&#34;</b>
<b>	&#34;math/rand&#34;</b>
<b>)</b>

// Hello returns a greeting for the named person.
<b>func Hello(name string) (string, error) {</b>
<b>	// If no name was given, return an error with a message.</b>
<b>	if name == &#34;&#34; {</b>
<b>		return name, errors.New(&#34;empty name&#34;)</b>
<b>	}</b>
<b>	// Create a message using a random format.</b>
<b>	message := fmt.Sprintf(randomFormat(), name)</b>
<b>	return message, nil</b>
}
<b></b>
<b>// init sets initial values for variables used in the function.</b>
<b>func init() {</b>
<b>	// For truly random greetings, import &#34;time&#34; and replace the call</b>
<b>	// to rand.Seed with:</b>
<b>	//</b>
<b>	// rand.Seed(time.Now().UnixNano())</b>
<b>	//</b>
<b>	// Calling rand.Seed with a constant value means that we always</b>
<b>	// generate the same pseudo-random sequence.</b>
<b>	rand.Seed(1)</b>
<b>}</b>
<b></b>
<b>// randomFormat returns one of a set of greeting messages. The returned</b>
<b>// message is selected at random.</b>
<b>func randomFormat() string {</b>
<b>	// A slice of message formats.</b>
<b>	formats := []string{</b>
<b>		&#34;Hi, %v. Welcome!&#34;,</b>
<b>		&#34;Great to see you, %v!&#34;,</b>
<b>		&#34;Hail, %v! Well met!&#34;,</b>
<b>	}</b>
<b></b>
<b>	// Return one of the message formats selected at random.</b>
<b>	return formats[rand.Intn(len(formats))]</b>
<b>}</b>
</code></pre>

In this code, you:

* Add a `randomFormat` function that returns a randomly selected format for a greeting message. Note that `randomFormat`
  starts with a lowercase letter, making it accessible only to code in its own package (in other words, it's not
exported).
* In `randomFormat`, declare a `formats` slice with three message formats. When declaring a slice, you omit its size in
  the brackets, like this: `[]string`. This tells Go that the array underlying a slice can be dynamically sized.
* Use the `math/rand` package to generate a random number for selecting an item from the slice.
* Add an `init` function to seed the rand package. Go executes `init` functions automatically at program startup, after
  global variables have been initialized.
* In `Hello`, call the `randomFormat` function to get a format for the message you'll return, then use the format and
  name value together to create the message.
* Return the message (or an `error`) as you did before.

Note that you are seeding the `math/rand` package with a constant seed. This means the code will always generate the same
pseudo-random sequence.

You now need to re-publish the updated `greetings` module so that we can use it in our `hello`
module.

Add and commit the changes you just made:

```.term1
$ git add greetings.go
$ git commit -q -m 'Added random format'
```
{:data-command-src="Z2l0IGFkZCBncmVldGluZ3MuZ28KZ2l0IGNvbW1pdCAtcSAtbSAnQWRkZWQgcmFuZG9tIGZvcm1hdCcK"}

Note the id of the commit we just created:

```.term1
$ greetings_random_commit=$(git rev-parse HEAD)
```
{:data-command-src="Z3JlZXRpbmdzX3JhbmRvbV9jb21taXQ9JChnaXQgcmV2LXBhcnNlIEhFQUQpCg=="}

Republish the `greetings` module:

```.term1
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"}

Return to the `hello` module directory and use this new version:

```.term1
$ cd /home/gopher/hello
$ go get {% raw %}{{{.GREETINGS}}}{% endraw %}@$greetings_random_commit
go: {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345 => v0.0.0-20060102150405-abcedf12345
go: downloading {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2hlbGxvCmdvIGdldCB7e3suR1JFRVRJTkdTfX19QCRncmVldGluZ3NfcmFuZG9tX2NvbW1pdAo="}

Re-add Gladys's name as an argument to the `Hello` function call in `hello.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCSJsb2ciCgoJInt7ey5HUkVFVElOR1N9fX0iCikKCmZ1bmMgbWFpbigpIHsKCS8vIFNldCBwcm9wZXJ0aWVzIG9mIHRoZSBwcmVkZWZpbmVkIExvZ2dlciwgaW5jbHVkaW5nCgkvLyB0aGUgbG9nIGVudHJ5IHByZWZpeCBhbmQgYSBmbGFnIHRvIGRpc2FibGUgcHJpbnRpbmcKCS8vIHRoZSB0aW1lLCBzb3VyY2UgZmlsZSwgYW5kIGxpbmUgbnVtYmVyLgoJbG9nLlNldFByZWZpeCgiZ3JlZXRpbmdzOiAiKQoJbG9nLlNldEZsYWdzKDApCgoJLy8gUmVxdWVzdCBhIGdyZWV0aW5nIG1lc3NhZ2UuCgltZXNzYWdlLCBlcnIgOj0gZ3JlZXRpbmdzLkhlbGxvKCJHbGFkeXMiKQoJLy8gSWYgYW4gZXJyb3Igd2FzIHJldHVybmVkLCBwcmludCBpdCB0byB0aGUgY29uc29sZSBhbmQKCS8vIGV4aXQgdGhlIHByb2dyYW0uCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoKCS8vIElmIG5vIGVycm9yIHdhcyByZXR1cm5lZCwgcHJpbnQgdGhlIHJldHVybmVkIG1lc3NhZ2UKCS8vIHRvIHRoZSBjb25zb2xlLgoJZm10LlByaW50bG4obWVzc2FnZSkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;
	&#34;log&#34;

	&#34;{% raw %}{{{.GREETINGS}}}{% endraw %}&#34;
)

func main() {
	// Set properties of the predefined Logger, including
	// the log entry prefix and a flag to disable printing
	// the time, source file, and line number.
	log.SetPrefix(&#34;greetings: &#34;)
	log.SetFlags(0)

	// Request a greeting message.
<b>	message, err := greetings.Hello(&#34;Gladys&#34;)</b>
	// If an error was returned, print it to the console and
	// exit the program.
	if err != nil {
		log.Fatal(err)
	}

	// If no error was returned, print the returned message
	// to the console.
	fmt.Println(message)
}
</code></pre>

Run `hello.go` to confirm the code works. Notice that because of the constant seed, running the program
always gives the same greeting format. We will come back to that shortly:

```.term1
$ go run hello.go
Hail, Gladys! Well met!
$ go run hello.go
Hail, Gladys! Well met!
```
{:data-command-src="Z28gcnVuIGhlbGxvLmdvCmdvIHJ1biBoZWxsby5nbwo="}

That's an introduction to a Go slice. To get even more use out of this type, you'll use a slice to greet multiple
people, where we will start to see some "real" pseudo-random greetings!

### Return greetings for multiple people

In the last changes you'll make to the `greetings` module code, you'll add support for getting greetings for
multiple people in one request. In other words, you'll handle a multiple-value input and pair values with a
multiple-value output.

Change back to the `greetings` module:

```.term1
$ cd /home/gopher/greetings
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dyZWV0aW5ncwo="}

To do this, you'll need to pass a set of names to a function that can return a greeting for each of them. Changing the
`Hello` function's parameter from a single name to a set of names would change the function signature. Given that you
have already published the greetings module, other users might already have written code calling `Hello`, that change
would break their programs.  In this situation, a better choice is to give new functionality a new name.

Add a new function `Hellos` that takes a set of names. For the sake of simplicity, have the new function call the
existing one. Keeping both functions in the package leaves the original for existing callers (or future callers who only
need one greeting) and adds a new one for callers that want the expanded functionality:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkiZXJyb3JzIgoJImZtdCIKCSJtYXRoL3JhbmQiCikKCi8vIEhlbGxvIHJldHVybnMgYSBncmVldGluZyBmb3IgdGhlIG5hbWVkIHBlcnNvbi4KZnVuYyBIZWxsbyhuYW1lIHN0cmluZykgKHN0cmluZywgZXJyb3IpIHsKCS8vIElmIG5vIG5hbWUgd2FzIGdpdmVuLCByZXR1cm4gYW4gZXJyb3Igd2l0aCBhIG1lc3NhZ2UuCglpZiBuYW1lID09ICIiIHsKCQlyZXR1cm4gbmFtZSwgZXJyb3JzLk5ldygiZW1wdHkgbmFtZSIpCgl9CgkvLyBDcmVhdGUgYSBtZXNzYWdlIHVzaW5nIGEgcmFuZG9tIGZvcm1hdC4KCW1lc3NhZ2UgOj0gZm10LlNwcmludGYocmFuZG9tRm9ybWF0KCksIG5hbWUpCglyZXR1cm4gbWVzc2FnZSwgbmlsCn0KCi8vIEhlbGxvcyByZXR1cm5zIGEgbWFwIHRoYXQgYXNzb2NpYXRlcyBlYWNoIG9mIHRoZSBuYW1lZCBwZW9wbGUKLy8gd2l0aCBhIGdyZWV0aW5nIG1lc3NhZ2UuCmZ1bmMgSGVsbG9zKG5hbWVzIFtdc3RyaW5nKSAobWFwW3N0cmluZ11zdHJpbmcsIGVycm9yKSB7CgkvLyBBIG1hcCB0byBhc3NvY2lhdGUgbmFtZXMgd2l0aCBtZXNzYWdlcy4KCW1lc3NhZ2VzIDo9IG1ha2UobWFwW3N0cmluZ11zdHJpbmcpCgkvLyBMb29wIHRocm91Z2ggdGhlIHJlY2VpdmVkIHNsaWNlIG9mIG5hbWVzLCBjYWxsaW5nCgkvLyB0aGUgSGVsbG8gZnVuY3Rpb24gdG8gZ2V0IGEgbWVzc2FnZSBmb3IgZWFjaCBuYW1lLgoJZm9yIF8sIG5hbWUgOj0gcmFuZ2UgbmFtZXMgewoJCW1lc3NhZ2UsIGVyciA6PSBIZWxsbyhuYW1lKQoJCWlmIGVyciAhPSBuaWwgewoJCQlyZXR1cm4gbmlsLCBlcnIKCQl9CgkJLy8gSW4gdGhlIG1hcCwgYXNzb2NpYXRlIHRoZSByZXRyaWV2ZWQgbWVzc2FnZSB3aXRoCgkJLy8gdGhlIG5hbWUuCgkJbWVzc2FnZXNbbmFtZV0gPSBtZXNzYWdlCgl9CglyZXR1cm4gbWVzc2FnZXMsIG5pbAp9CgovLyBpbml0IHNldHMgaW5pdGlhbCB2YWx1ZXMgZm9yIHZhcmlhYmxlcyB1c2VkIGluIHRoZSBmdW5jdGlvbi4KZnVuYyBpbml0KCkgewoJLy8gRm9yIHRydWx5IHJhbmRvbSBncmVldGluZ3MsIGltcG9ydCAidGltZSIgYW5kIHJlcGxhY2UgdGhlIGNhbGwKCS8vIHRvIHJhbmQuU2VlZCB3aXRoOgoJLy8KCS8vIHJhbmQuU2VlZCh0aW1lLk5vdygpLlVuaXhOYW5vKCkpCgkvLwoJLy8gQ2FsbGluZyByYW5kLlNlZWQgd2l0aCBhIGNvbnN0YW50IHZhbHVlIG1lYW5zIHRoYXQgd2UgYWx3YXlzCgkvLyBnZW5lcmF0ZSB0aGUgc2FtZSBwc2V1ZG8tcmFuZG9tIHNlcXVlbmNlLgoJcmFuZC5TZWVkKDEpCn0KCi8vIHJhbmRvbUZvcm1hdCByZXR1cm5zIG9uZSBvZiBhIHNldCBvZiBncmVldGluZyBtZXNzYWdlcy4gVGhlIHJldHVybmVkCi8vIG1lc3NhZ2UgaXMgc2VsZWN0ZWQgYXQgcmFuZG9tLgpmdW5jIHJhbmRvbUZvcm1hdCgpIHN0cmluZyB7CgkvLyBBIHNsaWNlIG9mIG1lc3NhZ2UgZm9ybWF0cy4KCWZvcm1hdHMgOj0gW11zdHJpbmd7CgkJIkhpLCAldi4gV2VsY29tZSEiLAoJCSJHcmVhdCB0byBzZWUgeW91LCAldiEiLAoJCSJIYWlsLCAldiEgV2VsbCBtZXQhIiwKCX0KCgkvLyBSZXR1cm4gb25lIG9mIHRoZSBtZXNzYWdlIGZvcm1hdHMgc2VsZWN0ZWQgYXQgcmFuZG9tLgoJcmV0dXJuIGZvcm1hdHNbcmFuZC5JbnRuKGxlbihmb3JtYXRzKSldCn0K" data-upload-term=".term1"><code class="language-go">package greetings

import (
	&#34;errors&#34;
	&#34;fmt&#34;
	&#34;math/rand&#34;
)

// Hello returns a greeting for the named person.
func Hello(name string) (string, error) {
	// If no name was given, return an error with a message.
	if name == &#34;&#34; {
		return name, errors.New(&#34;empty name&#34;)
	}
	// Create a message using a random format.
	message := fmt.Sprintf(randomFormat(), name)
	return message, nil
}

<b>// Hellos returns a map that associates each of the named people</b>
<b>// with a greeting message.</b>
<b>func Hellos(names []string) (map[string]string, error) {</b>
<b>	// A map to associate names with messages.</b>
<b>	messages := make(map[string]string)</b>
<b>	// Loop through the received slice of names, calling</b>
<b>	// the Hello function to get a message for each name.</b>
<b>	for _, name := range names {</b>
<b>		message, err := Hello(name)</b>
<b>		if err != nil {</b>
<b>			return nil, err</b>
<b>		}</b>
<b>		// In the map, associate the retrieved message with</b>
<b>		// the name.</b>
<b>		messages[name] = message</b>
<b>	}</b>
<b>	return messages, nil</b>
<b>}</b>
<b></b>
// init sets initial values for variables used in the function.
func init() {
	// For truly random greetings, import &#34;time&#34; and replace the call
	// to rand.Seed with:
	//
	// rand.Seed(time.Now().UnixNano())
	//
	// Calling rand.Seed with a constant value means that we always
	// generate the same pseudo-random sequence.
	rand.Seed(1)
}

// randomFormat returns one of a set of greeting messages. The returned
// message is selected at random.
func randomFormat() string {
	// A slice of message formats.
	formats := []string{
		&#34;Hi, %v. Welcome!&#34;,
		&#34;Great to see you, %v!&#34;,
		&#34;Hail, %v! Well met!&#34;,
	}

	// Return one of the message formats selected at random.
	return formats[rand.Intn(len(formats))]
}
</code></pre>

In this code, you:

* Add a `Hellos` function whose parameter is a slice of names rather than a single name. Also, you change one of its
  return types from a `string` to a `map` so you can return names mapped to greeting messages.
* Have the new `Hellos` function call the existing `Hello` function. This leaves both functions in place.
* Create a `messages` [map](https://blog.golang.org/map) to associate each of the received names (as a key) with a
  generated message (as a value). In Go, you initialize a map with the following syntax:
`make(map[key-type]value-type`).  You have the `Hello` function return this map to the caller.
* Loop through the names your function received, checking that each has a non-empty value, then associate a message with
  each. In this `for` loop, `range` returns two values: the index of the current item in the loop and a copy of the
item's value. You don't need the index, so you use the Go [blank identifier (an
underscore)](https://golang.org/doc/effective_go.html#blank) to ignore it.

Instead of republishing the `greetings` module, let's add a [`replace`
directive](https://golang.org/ref/mod#go-mod-file-replace) in our `hello` module that tells the `go` command
to use a local directory instead of a published module.

First return to the `hello` module:

```.term1
$ cd /home/gopher/hello
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2hlbGxvCg=="}

Now add a `replace` directive using `go mod edit`:

```.term1
$ go mod edit -replace {% raw %}{{{.GREETINGS}}}{% endraw %}=/home/gopher/greetings
```
{:data-command-src="Z28gbW9kIGVkaXQgLXJlcGxhY2Uge3t7LkdSRUVUSU5HU319fT0vaG9tZS9nb3BoZXIvZ3JlZXRpbmdzCg=="}

We can see the result in the `hello` module `go.mod` file:

```.term1
$ cat go.mod
module {% raw %}{{{.HELLO}}}{% endraw %}

go 1.15

require {% raw %}{{{.GREETINGS}}}{% endraw %} v0.0.0-20060102150405-abcedf12345

replace {% raw %}{{{.GREETINGS}}}{% endraw %} => /home/gopher/greetings
```
{:data-command-src="Y2F0IGdvLm1vZAo="}

In your `hello.go` calling code, pass a slice of names, then print the contents of the names/messages map you
get back:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="aGVsbG8uZ28=:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImZtdCIKCSJsb2ciCgoJInt7ey5HUkVFVElOR1N9fX0iCikKCmZ1bmMgbWFpbigpIHsKCS8vIFNldCBwcm9wZXJ0aWVzIG9mIHRoZSBwcmVkZWZpbmVkIExvZ2dlciwgaW5jbHVkaW5nCgkvLyB0aGUgbG9nIGVudHJ5IHByZWZpeCBhbmQgYSBmbGFnIHRvIGRpc2FibGUgcHJpbnRpbmcKCS8vIHRoZSB0aW1lLCBzb3VyY2UgZmlsZSwgYW5kIGxpbmUgbnVtYmVyLgoJbG9nLlNldFByZWZpeCgiZ3JlZXRpbmdzOiAiKQoJbG9nLlNldEZsYWdzKDApCgoJLy8gQSBzbGljZSBvZiBuYW1lcy4KCW5hbWVzIDo9IFtdc3RyaW5neyJHbGFkeXMiLCAiU2FtYW50aGEiLCAiRGFycmluIn0KCgkvLyBSZXF1ZXN0IGdyZWV0aW5nIG1lc3NhZ2VzIGZvciB0aGUgbmFtZXMuCgltZXNzYWdlcywgZXJyIDo9IGdyZWV0aW5ncy5IZWxsb3MobmFtZXMpCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoJLy8gSWYgbm8gZXJyb3Igd2FzIHJldHVybmVkLCBwcmludCB0aGUgcmV0dXJuZWQgbWFwIG9mCgkvLyBtZXNzYWdlcyB0byB0aGUgY29uc29sZS4KCWZtdC5QcmludGxuKG1lc3NhZ2VzKQp9Cg==" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;fmt&#34;
	&#34;log&#34;

	&#34;{% raw %}{{{.GREETINGS}}}{% endraw %}&#34;
)

func main() {
	// Set properties of the predefined Logger, including
	// the log entry prefix and a flag to disable printing
	// the time, source file, and line number.
	log.SetPrefix(&#34;greetings: &#34;)
	log.SetFlags(0)

<b>	// A slice of names.</b>
<b>	names := []string{&#34;Gladys&#34;, &#34;Samantha&#34;, &#34;Darrin&#34;}</b>
<b></b>
<b>	// Request greeting messages for the names.</b>
<b>	messages, err := greetings.Hellos(names)</b>
	if err != nil {
		log.Fatal(err)
	}
<b>	// If no error was returned, print the returned map of</b>
<b>	// messages to the console.</b>
<b>	fmt.Println(messages)</b>
}
</code></pre>

With these changes, you:

* Create a `names` variable as a slice type holding three names.
* Pass the `names` variable as the argument to the `Hellos` function.

Run `hello.go` to confirm that the code works, the output should be a string representation of the map
associating names with messages:

```.term1
$ go run hello.go
map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]
```
{:data-command-src="Z28gcnVuIGhlbGxvLmdvCg=="}

This section introduced maps for representing name/value pairs. It also introduced the idea of preserving backward
compatibility by implementing a new function for new or changed functionality in a module. In the next section, you'll
use built-in features to create a unit test for your code.

### Add a test

Now that you've gotten your code to a stable place (nicely done, by the way), add a test. Testing your code during
development can expose bugs that find their way in as you make changes. In this topic, you add a test for the `Hello`
function.

Go's built-in support for unit testing makes it easier to test as you go. Specifically, using naming conventions, Go's
`testing` package, and the `go test` command, you can quickly write and execute tests. You will create this test in the
`greetings` module.

Return to the `greetings` module:

```.term1
$ cd /home/gopher/greetings
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2dyZWV0aW5ncwo="}

Create a file called `greetings_test.go`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzX3Rlc3QuZ28=:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkicmVnZXhwIgoJInRlc3RpbmciCikKCi8vIFRlc3RIZWxsb05hbWUgY2FsbHMgZ3JlZXRpbmdzLkhlbGxvIHdpdGggYSBuYW1lLCBjaGVja2luZwovLyBmb3IgYSB2YWxpZCByZXR1cm4gdmFsdWUuCmZ1bmMgVGVzdEhlbGxvTmFtZSh0ICp0ZXN0aW5nLlQpIHsKCW5hbWUgOj0gIkdsYWR5cyIKCXdhbnQgOj0gcmVnZXhwLk11c3RDb21waWxlKGBcYmAgKyBuYW1lICsgYFxiYCkKCW1zZywgZXJyIDo9IEhlbGxvKG5hbWUpCglpZiAhd2FudC5NYXRjaFN0cmluZyhtc2cpIHx8IGVyciAhPSBuaWwgewoJCXQuRmF0YWxmKGBIZWxsbygiR2xhZHlzIikgPSAlcSwgJXYsIHdhbnQgbWF0Y2ggZm9yICUjcSwgPG5pbD5gLCBtc2csIGVyciwgd2FudCkKCX0KfQoKLy8gVGVzdEhlbGxvRW1wdHkgY2FsbHMgZ3JlZXRpbmdzLkhlbGxvIHdpdGggYW4gZW1wdHkgc3RyaW5nLAovLyBjaGVja2luZyBmb3IgYW4gZXJyb3IuCmZ1bmMgVGVzdEhlbGxvRW1wdHkodCAqdGVzdGluZy5UKSB7Cgltc2csIGVyciA6PSBIZWxsbygiIikKCWlmIG1zZyAhPSAiIiB8fCBlcnIgPT0gbmlsIHsKCQl0LkZhdGFsZihgSGVsbG8oIiIpID0gJXEsICV2LCB3YW50ICIiLCBlcnJvcmAsIG1zZywgZXJyKQoJfQp9Cg==" data-upload-term=".term1"><code class="language-go">package greetings

import (
	&#34;regexp&#34;
	&#34;testing&#34;
)

// TestHelloName calls greetings.Hello with a name, checking
// for a valid return value.
func TestHelloName(t *testing.T) {
	name := &#34;Gladys&#34;
	want := regexp.MustCompile(`\b` + name + `\b`)
	msg, err := Hello(name)
	if !want.MatchString(msg) || err != nil {
		t.Fatalf(`Hello(&#34;Gladys&#34;) = %q, %v, want match for %#q, &lt;nil&gt;`, msg, err, want)
	}
}

// TestHelloEmpty calls greetings.Hello with an empty string,
// checking for an error.
func TestHelloEmpty(t *testing.T) {
	msg, err := Hello(&#34;&#34;)
	if msg != &#34;&#34; || err == nil {
		t.Fatalf(`Hello(&#34;&#34;) = %q, %v, want &#34;&#34;, error`, msg, err)
	}
}
</code></pre>

If this code, you:

* Implement test functions in the same package as the code you're testing.
* Create two test functions to test the `greetings.Hello` function. Test function names have the form
  `TestName`, where `Name` is specific to the test. Also, test functions take a pointer to the [`testing`
package's](https://golang.org/pkg/testing/) `testing.T` as a parameter. You use this parameter's methods for reporting
and logging from your test.
* Implement `TestHelloName`. `TestHelloName` calls the `Hello` function, passing a `name` value with which the function
  should be able to return a valid response message. If the call returns an error or an unexpected response message (one
that doesn't include the name you passed in), you use the t parameter's [`Fatalf`
method](https://golang.org/pkg/testing/#T.Fatalf) to print a message to the console and end execution.
* Implement `TestHelloEmpty`. `TestHelloEmpty` calls the `Hello` function with an empty string. This test is designed to
  confirm that your error handling works. If the call returns a non-empty string or no error, you use the t parameter's
`Fatalf` method to print a message to the console and end execution.

At the command line in the greetings directory, run the `go test` command to execute the test. The
`go test` command executes test functions (whose names begin with `Test`) in test files (whose names end with
`_test.go`). You can add the `-v` flag to get verbose output that lists all of the tests and their results.

The tests should pass:

```.term1
$ go test
PASS
ok  	{% raw %}{{{.GREETINGS}}}{% endraw %}	0.042s
$ go test -v
=== RUN   TestHelloName
--- PASS: TestHelloName (0.042s)
=== RUN   TestHelloEmpty
--- PASS: TestHelloEmpty (0.042s)
PASS
ok  	{% raw %}{{{.GREETINGS}}}{% endraw %}	0.042s
```
{:data-command-src="Z28gdGVzdApnbyB0ZXN0IC12Cg=="}

You will now break the `greetings.Hello` function to view a failing test. The `TestHelloName` test function
checks the return value for the name you specified as a `Hello` function parameter. To view a failing test result, change
the `greetings.Hello` function so that it no longer includes the name:

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkiZXJyb3JzIgoJImZtdCIKCSJtYXRoL3JhbmQiCikKCi8vIEhlbGxvIHJldHVybnMgYSBncmVldGluZyBmb3IgdGhlIG5hbWVkIHBlcnNvbi4KZnVuYyBIZWxsbyhuYW1lIHN0cmluZykgKHN0cmluZywgZXJyb3IpIHsKCS8vIElmIG5vIG5hbWUgd2FzIGdpdmVuLCByZXR1cm4gYW4gZXJyb3Igd2l0aCBhIG1lc3NhZ2UuCglpZiBuYW1lID09ICIiIHsKCQlyZXR1cm4gbmFtZSwgZXJyb3JzLk5ldygiZW1wdHkgbmFtZSIpCgl9CgkvLyBDcmVhdGUgYSBtZXNzYWdlIHVzaW5nIGEgcmFuZG9tIGZvcm1hdC4KCS8vIG1lc3NhZ2UgOj0gZm10LlNwcmludGYocmFuZG9tRm9ybWF0KCksIG5hbWUpCgltZXNzYWdlIDo9IGZtdC5TcHJpbnQocmFuZG9tRm9ybWF0KCkpCglyZXR1cm4gbWVzc2FnZSwgbmlsCn0KCi8vIEhlbGxvcyByZXR1cm5zIGEgbWFwIHRoYXQgYXNzb2NpYXRlcyBlYWNoIG9mIHRoZSBuYW1lZCBwZW9wbGUKLy8gd2l0aCBhIGdyZWV0aW5nIG1lc3NhZ2UuCmZ1bmMgSGVsbG9zKG5hbWVzIFtdc3RyaW5nKSAobWFwW3N0cmluZ11zdHJpbmcsIGVycm9yKSB7CgkvLyBBIG1hcCB0byBhc3NvY2lhdGUgbmFtZXMgd2l0aCBtZXNzYWdlcy4KCW1lc3NhZ2VzIDo9IG1ha2UobWFwW3N0cmluZ11zdHJpbmcpCgkvLyBMb29wIHRocm91Z2ggdGhlIHJlY2VpdmVkIHNsaWNlIG9mIG5hbWVzLCBjYWxsaW5nCgkvLyB0aGUgSGVsbG8gZnVuY3Rpb24gdG8gZ2V0IGEgbWVzc2FnZSBmb3IgZWFjaCBuYW1lLgoJZm9yIF8sIG5hbWUgOj0gcmFuZ2UgbmFtZXMgewoJCW1lc3NhZ2UsIGVyciA6PSBIZWxsbyhuYW1lKQoJCWlmIGVyciAhPSBuaWwgewoJCQlyZXR1cm4gbmlsLCBlcnIKCQl9CgkJLy8gSW4gdGhlIG1hcCwgYXNzb2NpYXRlIHRoZSByZXRyaWV2ZWQgbWVzc2FnZSB3aXRoCgkJLy8gdGhlIG5hbWUuCgkJbWVzc2FnZXNbbmFtZV0gPSBtZXNzYWdlCgl9CglyZXR1cm4gbWVzc2FnZXMsIG5pbAp9CgovLyBpbml0IHNldHMgaW5pdGlhbCB2YWx1ZXMgZm9yIHZhcmlhYmxlcyB1c2VkIGluIHRoZSBmdW5jdGlvbi4KZnVuYyBpbml0KCkgewoJLy8gRm9yIHRydWx5IHJhbmRvbSBncmVldGluZ3MsIGltcG9ydCAidGltZSIgYW5kIHJlcGxhY2UgdGhlIGNhbGwKCS8vIHRvIHJhbmQuU2VlZCB3aXRoOgoJLy8KCS8vIHJhbmQuU2VlZCh0aW1lLk5vdygpLlVuaXhOYW5vKCkpCgkvLwoJLy8gQ2FsbGluZyByYW5kLlNlZWQgd2l0aCBhIGNvbnN0YW50IHZhbHVlIG1lYW5zIHRoYXQgd2UgYWx3YXlzCgkvLyBnZW5lcmF0ZSB0aGUgc2FtZSBwc2V1ZG8tcmFuZG9tIHNlcXVlbmNlLgoJcmFuZC5TZWVkKDEpCn0KCi8vIHJhbmRvbUZvcm1hdCByZXR1cm5zIG9uZSBvZiBhIHNldCBvZiBncmVldGluZyBtZXNzYWdlcy4gVGhlIHJldHVybmVkCi8vIG1lc3NhZ2UgaXMgc2VsZWN0ZWQgYXQgcmFuZG9tLgpmdW5jIHJhbmRvbUZvcm1hdCgpIHN0cmluZyB7CgkvLyBBIHNsaWNlIG9mIG1lc3NhZ2UgZm9ybWF0cy4KCWZvcm1hdHMgOj0gW11zdHJpbmd7CgkJIkhpLCAldi4gV2VsY29tZSEiLAoJCSJHcmVhdCB0byBzZWUgeW91LCAldiEiLAoJCSJIYWlsLCAldiEgV2VsbCBtZXQhIiwKCX0KCgkvLyBSZXR1cm4gb25lIG9mIHRoZSBtZXNzYWdlIGZvcm1hdHMgc2VsZWN0ZWQgYXQgcmFuZG9tLgoJcmV0dXJuIGZvcm1hdHNbcmFuZC5JbnRuKGxlbihmb3JtYXRzKSldCn0K" data-upload-term=".term1"><code class="language-go">package greetings

import (
	&#34;errors&#34;
	&#34;fmt&#34;
	&#34;math/rand&#34;
)

// Hello returns a greeting for the named person.
func Hello(name string) (string, error) {
	// If no name was given, return an error with a message.
	if name == &#34;&#34; {
		return name, errors.New(&#34;empty name&#34;)
	}
	// Create a message using a random format.
<b>	// message := fmt.Sprintf(randomFormat(), name)</b>
<b>	message := fmt.Sprint(randomFormat())</b>
	return message, nil
}

// Hellos returns a map that associates each of the named people
// with a greeting message.
func Hellos(names []string) (map[string]string, error) {
	// A map to associate names with messages.
	messages := make(map[string]string)
	// Loop through the received slice of names, calling
	// the Hello function to get a message for each name.
	for _, name := range names {
		message, err := Hello(name)
		if err != nil {
			return nil, err
		}
		// In the map, associate the retrieved message with
		// the name.
		messages[name] = message
	}
	return messages, nil
}

// init sets initial values for variables used in the function.
func init() {
	// For truly random greetings, import &#34;time&#34; and replace the call
	// to rand.Seed with:
	//
	// rand.Seed(time.Now().UnixNano())
	//
	// Calling rand.Seed with a constant value means that we always
	// generate the same pseudo-random sequence.
	rand.Seed(1)
}

// randomFormat returns one of a set of greeting messages. The returned
// message is selected at random.
func randomFormat() string {
	// A slice of message formats.
	formats := []string{
		&#34;Hi, %v. Welcome!&#34;,
		&#34;Great to see you, %v!&#34;,
		&#34;Hail, %v! Well met!&#34;,
	}

	// Return one of the message formats selected at random.
	return formats[rand.Intn(len(formats))]
}
</code></pre>

Note that the highlighted lines change the value that the function returns, as if the `name` argument had been
accidentally removed.

At the command line in the greetings directory, run `go test` to execute the test. This time, run go test
without the `-v` flag. The output will include results for only the tests that failed, which can be useful when you have
a lot of tests. The `TestHelloName` test should fail -- `TestHelloEmpty` still passes:

```.term1
$ go test
--- FAIL: TestHelloName (0.042s)
    greetings_test.go:15: Hello("Gladys") = "Hail, %v! Well met!", <nil>, want match for `\bGladys\b`, <nil>
FAIL
exit status 1
FAIL	{% raw %}{{{.GREETINGS}}}{% endraw %}	0.042s
```
{:data-command-src="Z28gdGVzdAo="}

Let's restore `greetings.Hello` to a working state

<pre data-upload-path="L2hvbWUvZ29waGVyL2dyZWV0aW5ncw==" data-upload-src="Z3JlZXRpbmdzLmdv:cGFja2FnZSBncmVldGluZ3MKCmltcG9ydCAoCgkiZXJyb3JzIgoJImZtdCIKCSJtYXRoL3JhbmQiCikKCi8vIEhlbGxvIHJldHVybnMgYSBncmVldGluZyBmb3IgdGhlIG5hbWVkIHBlcnNvbi4KZnVuYyBIZWxsbyhuYW1lIHN0cmluZykgKHN0cmluZywgZXJyb3IpIHsKCS8vIElmIG5vIG5hbWUgd2FzIGdpdmVuLCByZXR1cm4gYW4gZXJyb3Igd2l0aCBhIG1lc3NhZ2UuCglpZiBuYW1lID09ICIiIHsKCQlyZXR1cm4gbmFtZSwgZXJyb3JzLk5ldygiZW1wdHkgbmFtZSIpCgl9CgkvLyBDcmVhdGUgYSBtZXNzYWdlIHVzaW5nIGEgcmFuZG9tIGZvcm1hdC4KCW1lc3NhZ2UgOj0gZm10LlNwcmludGYocmFuZG9tRm9ybWF0KCksIG5hbWUpCglyZXR1cm4gbWVzc2FnZSwgbmlsCn0KCi8vIEhlbGxvcyByZXR1cm5zIGEgbWFwIHRoYXQgYXNzb2NpYXRlcyBlYWNoIG9mIHRoZSBuYW1lZCBwZW9wbGUKLy8gd2l0aCBhIGdyZWV0aW5nIG1lc3NhZ2UuCmZ1bmMgSGVsbG9zKG5hbWVzIFtdc3RyaW5nKSAobWFwW3N0cmluZ11zdHJpbmcsIGVycm9yKSB7CgkvLyBBIG1hcCB0byBhc3NvY2lhdGUgbmFtZXMgd2l0aCBtZXNzYWdlcy4KCW1lc3NhZ2VzIDo9IG1ha2UobWFwW3N0cmluZ11zdHJpbmcpCgkvLyBMb29wIHRocm91Z2ggdGhlIHJlY2VpdmVkIHNsaWNlIG9mIG5hbWVzLCBjYWxsaW5nCgkvLyB0aGUgSGVsbG8gZnVuY3Rpb24gdG8gZ2V0IGEgbWVzc2FnZSBmb3IgZWFjaCBuYW1lLgoJZm9yIF8sIG5hbWUgOj0gcmFuZ2UgbmFtZXMgewoJCW1lc3NhZ2UsIGVyciA6PSBIZWxsbyhuYW1lKQoJCWlmIGVyciAhPSBuaWwgewoJCQlyZXR1cm4gbmlsLCBlcnIKCQl9CgkJLy8gSW4gdGhlIG1hcCwgYXNzb2NpYXRlIHRoZSByZXRyaWV2ZWQgbWVzc2FnZSB3aXRoCgkJLy8gdGhlIG5hbWUuCgkJbWVzc2FnZXNbbmFtZV0gPSBtZXNzYWdlCgl9CglyZXR1cm4gbWVzc2FnZXMsIG5pbAp9CgovLyBpbml0IHNldHMgaW5pdGlhbCB2YWx1ZXMgZm9yIHZhcmlhYmxlcyB1c2VkIGluIHRoZSBmdW5jdGlvbi4KZnVuYyBpbml0KCkgewoJLy8gRm9yIHRydWx5IHJhbmRvbSBncmVldGluZ3MsIGltcG9ydCAidGltZSIgYW5kIHJlcGxhY2UgdGhlIGNhbGwKCS8vIHRvIHJhbmQuU2VlZCB3aXRoOgoJLy8KCS8vIHJhbmQuU2VlZCh0aW1lLk5vdygpLlVuaXhOYW5vKCkpCgkvLwoJLy8gQ2FsbGluZyByYW5kLlNlZWQgd2l0aCBhIGNvbnN0YW50IHZhbHVlIG1lYW5zIHRoYXQgd2UgYWx3YXlzCgkvLyBnZW5lcmF0ZSB0aGUgc2FtZSBwc2V1ZG8tcmFuZG9tIHNlcXVlbmNlLgoJcmFuZC5TZWVkKDEpCn0KCi8vIHJhbmRvbUZvcm1hdCByZXR1cm5zIG9uZSBvZiBhIHNldCBvZiBncmVldGluZyBtZXNzYWdlcy4gVGhlIHJldHVybmVkCi8vIG1lc3NhZ2UgaXMgc2VsZWN0ZWQgYXQgcmFuZG9tLgpmdW5jIHJhbmRvbUZvcm1hdCgpIHN0cmluZyB7CgkvLyBBIHNsaWNlIG9mIG1lc3NhZ2UgZm9ybWF0cy4KCWZvcm1hdHMgOj0gW11zdHJpbmd7CgkJIkhpLCAldi4gV2VsY29tZSEiLAoJCSJHcmVhdCB0byBzZWUgeW91LCAldiEiLAoJCSJIYWlsLCAldiEgV2VsbCBtZXQhIiwKCX0KCgkvLyBSZXR1cm4gb25lIG9mIHRoZSBtZXNzYWdlIGZvcm1hdHMgc2VsZWN0ZWQgYXQgcmFuZG9tLgoJcmV0dXJuIGZvcm1hdHNbcmFuZC5JbnRuKGxlbihmb3JtYXRzKSldCn0K" data-upload-term=".term1"><code class="language-go">package greetings

import (
	&#34;errors&#34;
	&#34;fmt&#34;
	&#34;math/rand&#34;
)

// Hello returns a greeting for the named person.
func Hello(name string) (string, error) {
	// If no name was given, return an error with a message.
	if name == &#34;&#34; {
		return name, errors.New(&#34;empty name&#34;)
	}
	// Create a message using a random format.
<b>	message := fmt.Sprintf(randomFormat(), name)</b>
	return message, nil
}

// Hellos returns a map that associates each of the named people
// with a greeting message.
func Hellos(names []string) (map[string]string, error) {
	// A map to associate names with messages.
	messages := make(map[string]string)
	// Loop through the received slice of names, calling
	// the Hello function to get a message for each name.
	for _, name := range names {
		message, err := Hello(name)
		if err != nil {
			return nil, err
		}
		// In the map, associate the retrieved message with
		// the name.
		messages[name] = message
	}
	return messages, nil
}

// init sets initial values for variables used in the function.
func init() {
	// For truly random greetings, import &#34;time&#34; and replace the call
	// to rand.Seed with:
	//
	// rand.Seed(time.Now().UnixNano())
	//
	// Calling rand.Seed with a constant value means that we always
	// generate the same pseudo-random sequence.
	rand.Seed(1)
}

// randomFormat returns one of a set of greeting messages. The returned
// message is selected at random.
func randomFormat() string {
	// A slice of message formats.
	formats := []string{
		&#34;Hi, %v. Welcome!&#34;,
		&#34;Great to see you, %v!&#34;,
		&#34;Hail, %v! Well met!&#34;,
	}

	// Return one of the message formats selected at random.
	return formats[rand.Intn(len(formats))]
}
</code></pre>

And re-run `go test` to verify our change:

```.term1
$ go test
PASS
ok  	{% raw %}{{{.GREETINGS}}}{% endraw %}	0.042s
```
{:data-command-src="Z28gdGVzdAo="}

This section introduced Go's built-in support for unit testing. In the next section, you'll see how to compile and
install your code to run it locally.

### Compile and install the application

In the last section, you'll learn a new `go` command. While the `go run` command is a useful shortcut for compiling and
running a single-file program, it doesn't generate a binary executable you can easily run again. If you want one of
those, a good choice is to run the `go install` command, which compiles your code and installs the resulting binary
executable where you can run it.

Change to the directory that contains the `hello` module:

```.term1
$ cd /home/gopher/hello
```
{:data-command-src="Y2QgL2hvbWUvZ29waGVyL2hlbGxvCg=="}

Discover the Go install path, where the `go` command will install the current package:

```.term1
$ go list -f '{% raw %}{{{% endraw %}.Target{% raw %}}}{% endraw %}'
/home/gopher/go/bin/hello
```
{:data-command-src="Z28gbGlzdCAtZiAne3suVGFyZ2V0fX0nCg=="}

Add the Go install directory to your system's shell path (this is generally a one-off step, you won't need to do this
for other programs). That way, you'll be able to run your program's executable without specifying where the executable
is:

```.term1
$ goinstalldir="$(dirname "$(go list -f '{% raw %}{{{% endraw %}.Target{% raw %}}}{% endraw %}')")"
$ export PATH="$goinstalldir:$PATH"
```
{:data-command-src="Z29pbnN0YWxsZGlyPSIkKGRpcm5hbWUgIiQoZ28gbGlzdCAtZiAne3suVGFyZ2V0fX0nKSIpIgpleHBvcnQgUEFUSD0iJGdvaW5zdGFsbGRpcjokUEFUSCIK"}

Once you've updated the shell path, run the `go install` command to compile and install the package:

```.term1
$ go install
```
{:data-command-src="Z28gaW5zdGFsbAo="}

Run your application by simply typing its name:

```.term1
$ hello
map[Darrin:Hail, Darrin! Well met! Gladys:Hail, Gladys! Well met! Samantha:Hi, Samantha. Welcome!]
```
{:data-command-src="aGVsbG8K"}

That wraps up this Go tutorial!
<script>let pageGuide="2018-10-19-go-fundamentals"; let pageLanguage="en"; let pageScenario="go115";</script>
