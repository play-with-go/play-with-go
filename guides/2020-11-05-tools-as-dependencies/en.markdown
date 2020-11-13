---
layout: post
title:  "Developer tools as module dependencies"
excerpt: "Ensure all developers use the same version of each developer tool"
difficulty: Intermediate
category: Next steps
---

_By [Jon Calhoun](https://twitter.com/joncalhoun), creator of [Gophercises](https://gophercises.com/) and other Go
courses and learning material._

Go modules support developer tools (commands) as dependencies. For example, your project might require a tool to help
with code generation, or to lint/vet your code for correctness. Adding developer tool dependencies ensures that all
developers use the same version of each tool.

This guide shows you how to manage developer tool dependencies with a Go module, specifically the code generator[
`<!--ref: stringer-->`](https://pkg.go.dev/golang.org/x/tools/cmd/stringer).

You will:

* create a module that contains a `main` package (your "project" for this guide)
* add the `<!--ref: stringer-->` tool as a dependency
* use `<!--ref: stringer-->` via a `go:generate` directive

### Prerequisites

You should already have completed:

* The [Go fundamentals Tutorial](/go-fundamentals_go115_en)

This guide is running using:

<!--step: goversion-->

### Why `<!--ref: stringer-->`?

Let's motivate the use of `<!--ref: stringer-->` by getting started on your project. Your project will be a simple command line
application that gives advice on what painkillers to take for certain ailments. So let's name your module accordingly:

<!--step: painkiller_go_mod_init-->

Start with a basic version of your application. Given that you are writing a command line application, you need to
declare a `main` package; do so in a file named `<!--ref:painkiller_go-->`:

<!--step: basic_app-->

This first version of your app provides some basic advice on what to take for headaches. Using integer types provides a
nice convenient way to define a sequence of constant values. Here you define the type `<!--ref:pilltype-->`.

Run the program to see its output:

<!--step: painkiller_run_basic-->

Hmm, that's not particularly user friendly. The integer value of your constant is meaningless to your user.

You can improve this by making the `<!--ref:pilltype-->` type implement the
[`fmt.Stringer`](https://pkg.go.dev/fmt#Stringer) interface:

<pre><code>type Stringer interface {
	String() string
}
</code></pre>

The `String()` method defines the "native" format for a
value.

Update your example to define a `String()` method on `<!--ref:pilltype-->`:

<!--step: manual_string-->

Run the program to see the new output:

<!--step: painkiller_run_manual_string-->

That's better. But as you can see there is a lot of repetition in your `String()` method. Adding more constants will
mean more manual, robotic effort... not to mention being error prone. Can we do better? Enter `<!--ref: stringer-->`.

`<!--ref: stringer-->` is a tool to automate the creation of methods that satisfy the
[`fmt.Stringer`](https://pkg.go.dev/fmt#Stringer) interface. Given the name of an (signed or unsigned) integer type `T`
that has constants defined, `<!--ref: stringer-->` will create a new self-contained Go source file implementing:

<pre><code>func (t T) String() string
</code></pre>

This sounds much better than maintaining a definition by hand, so let's add `<!--ref: stringer-->` as a dependency.

But before you do, remove the hand-written `String()` method:

<!--step: painkiller_remove_hand_written_string-->

### Adding tool dependencies

Go modules establishes a convention for tool dependencies. You simply import the command as you would any other package,
but do so in a special file that is ignored by any of the `go` build commands. Again, by convention, these imports are
declared in a file called `<!--ref:tools_go-->` at the root of your module:

<!--step: tools_go_initial-->

In this code you:

* Declare a [build constraint](https://pkg.go.dev/go/build#hdr-Build_Constraints) on the first line of
  `<!--ref:tools_go-->`. This tells the `go` command to only consider this file when the `<!--ref:tools_constraint-->`
build tag is provided. By convention, `<!--ref:tools_constraint-->` is used as the constraint name.
* Declare that `<!--ref:tools_go-->` belongs to the `<!--ref:tools_constraint-->` package. Because this file is going to
  be ignored by `go` build commands, it actually doesn't matter what package it belongs to. But again, by convention,
it is generally considered good practice to use `<!--ref:tools_constraint-->` as the package name.
* Import `<!--ref:stringer_pkg-->`, which declares a dependency relation between your `main` package and `<!--ref: stringer-->`.
  But hang on a minute: isn't `<!--ref: stringer-->` a command, and therefore a `main` package itself? How does this work? Again,
because this file is going to be ignore by `go` build commands the fact that you are importing a `main` package doesn't
actually matter. You are only importing `<!--ref: stringer_pkg-->` to declare the dependency on that package. And because
you don't use the imported `<!--ref:stringer_pkg-->` package, the blank identifier `_` is used to signal the import
exists solely for its side effects, in this case the declaration of the dependency.

With the package dependency declared, you can now add a dependency on the module that contains
`<!--ref:stringer_pkg-->`. Use `<!--ref:cmdgo.get-->` to add a dependency:

<!--step: stringer_go_get-->

You can see your new dependency in the project's `go.mod` file:

<!--step: painkiller_cat_go_mod-->

This guide uses a specific version of `<!--ref: stringer-->` so as to remain reproducible. In a real-world project you would almost
certainly omit the version to get the latest version, or explicitly use the special version `@latest`. Alternatively,
you could simply run `<!--ref:cmdgo.modtidy-->` instead of `<!--ref:cmdgo.get-->`:

<!--step: painkiller_go_mod_tidy-->

Run `<!--ref: stringer-->` to see how it should be invoked:

<!--step: stringer_help-->

As you can see, `<!--ref:pilltype-->` must be passed as an argument to the `<!--ref:stringer_type_flag-->` flag:

<!--step: stringer_run_by_hand-->

Listing the directory contents reveals what `<!--ref: stringer-->` has generated for us:

<!--step: stringer_ls_output-->

Examine the contents of the `<!--ref:stringer-->`-generated file:

<!--step: stringer_cat_generated-->

Notice the first line of this generated file is a comment warning you against editing it by hand: this "header" is a
[standard convention](https://golang.org/cmd/go/#hdr-Generate_Go_files_by_processing_source) of generated files.

Run your program to verify it behaves as expected:

<!--step: painkiller_check_stringer-->

Success!

### Using `<!--ref:stringer-->` via a `go:generate` directive

It is not fair or realistic to expect your fellow developers to remember the command for re-running
`<!--ref:stringer-->`. A more scalable approach is to declare a
[`go:generate`](https://golang.org/cmd/go/#hdr-Generate_Go_files_by_processing_source) directive for each code
generation step needed for your project:

<!--step: painkiller_add_gogenerate_directive-->

Now you can re-run all code generation steps (there is currently only one, but still) for current package by running:

<!--step: painkiller_gogenerate-->

Try this out by extending your program to give another piece of advice:

<!--step: painkiller_add_fever_advice-->

Re-run your code generation steps:

<!--step: painkiller_gogenerate_again-->

Finally, check your program's output:

<!--step: painkiller_check_fever_advice-->

### Conclusion

That's it! This guide has shown you how to add tool dependencies to a module, with a focus on the `<!--ref:stringer-->`
code generation tool and its use via `<!--ref: cmdgo.generate-->`.


