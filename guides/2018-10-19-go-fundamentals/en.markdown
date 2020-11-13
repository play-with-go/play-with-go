---
layout: post
title:  "Tutorial: Go fundamentals"
excerpt: "Primer on creating and using go modules"
difficulty: Beginner
category: Start here
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

This guide requires you to push code to remote source code repositories. A unique user, `{{{.GITEA_USERNAME}}}`, has
been automatically created for you, as have the repositories [`<!--ref:greetings_mod-->`](<!--ref: greetings_vcs-->) and
[`<!--ref:hello_mod-->`](<!--ref: hello_vcs-->). For more details on how `play-with-go.dev` guides work, please see the
[_Introduction to `play-with-go.dev` guides_](ntro-to-play-with-go-dev/) guide.

### Prerequisites

You should already have completed:

* [The Go Tour](https://tour.golang.org/)
* [An introduction to play-with-go.dev guides](/intro-to-play-with-go-dev/)
* [Tutorial: Get started with Go](/get-started-with-go/)

This guide is running using:

<!--step: goversion-->

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

<!--step: pwd_home-->

Create a `<!--ref:greetings-->` directory for your Go module source code. This is where you'll write your module code:

<!--step: mkdir_greetings-->

Start your module using the [`<!--ref: cmdgo.modinit-->`
command](https://golang.org/cmd/go/#hdr-Initialize_new_module_in_current_directory) to create a `go.mod` file.  In this
guide you will publish your <!--ref:greetings--> module to `<!--ref: greetings_mod-->`:

<!--step: gomodinit_greetings-->

The `<!--ref:cmdgo.modinit-->` command creates a `go.mod` file that identifies your code as a module that might be used from
other code.  The file you just created includes only the name of your module and the Go version your code supports:

<!--step: cat_gomodgreetings-->

As you add dependencies -- meaning packages from other modules -- the `go.mod` file will list the specific module
versions to use.  This keeps builds reproducible and gives you direct control over which module versions to use.

Now let's create <!--ref:greetings_go-->:

<!--step: create_greetingsgo-->

This is the first code for your module. It returns a greeting to any caller that asks for one. You'll write code that
calls this function in the next step.

In this code, you:

* Declare a `<!--ref:greetings-->` package to collect related functions.
* Implement a Hello function to return the greeting. This function takes a name parameter whose type is `string`, and
  returns a `string`. In Go, a function whose name starts with a capital letter can be called by a function not in the
  same package. This is known in Go as an [exported name](https://tour.golang.org/basics/3).
* Declare a `message` variable to hold your greeting. In Go, the `:=` operator is a shortcut for declaring and
  initializing a variable in one line (Go uses the value on the right to determine the variable's type). Let's rewrite
  this the long way:

<!--step: create_greetingsgo_long-->

* Use the `fmt` package's [`Sprintf`](https://pkg.go.dev/fmt#Sprintf) function to create a greeting message. The first
  argument is a format string, and `Sprintf` substitutes the name parameter's value for the `%v` format verb. Inserting
  the value of the name parameter completes the greeting text.
* Return the formatted greeting text to the caller.

For people to be able to use your module you need to publish it. You publish a module by pushing a commit to a version
control system like [GitHub](https://github.com/). You will publish your module to [`<!--ref:greetings_mod-->`](<!--ref:
greetings_vcs-->).

Initialise a local  `git` repository for your `<!--ref: greetings-->` module:

<!--step: greetings_gitinit-->

Add and commit the `<!--ref: greetings_go-->` file you created earlier:

<!--step: greetings_gitadd-->

Publish this commit by pushing it to the remote repository:

<!--step: greetings_gitpush-->



### Call your code from another module

You'll now write code that you can execute as an application, which makes calls to the `Hello` function in the `<!--ref:
greetings-->` module you published to `<!--ref:greetings_mod-->`.

Create the directory `<!--ref:hello_dir-->` for your Go module source code. This is where you'll write your caller.

<!--step: mkdir_hello-->

Create a new module for this `<!--ref:hello-->` package using the `<!--ref: cmdgo.modinit-->` command to create a `go.mod`
file as you did before, but this time using the unique path for the `<!--ref:hello-->` module:

<!--step: gomodinit_hello-->

Declare a dependency on `<!--ref:greetings_mod-->` using [`go get`](https://golang.org/ref/mod#go-get):

<!--step: goget_greetings-->

Without any version specified, `go get` will retrieve the latest version of the `<!--ref:greetings-->` module. And
because you didn't publish a specific version, `go get` resolves a [pseudo
version](https://golang.org/ref/mod#pseudo-versions) from the commit you pushed, specifically:

<!--step:golist_greetings-->

Create `<!--ref:hello_go-->` as follows:

<!--step: create_hellogo-->

In this code, you:

* Declare a `main` package. In Go, code executed as an application must go in a `main` package.
* Import two packages: `<!--ref:greetings_mod-->` and `fmt`. This gives your code access to functions in those packages.
  Importing `<!--ref:greetings_mod-->` (the package contained in the module you created earlier) gives you access to the
`Hello` function. You also import `fmt`, with functions for handling input and output text (such as printing text to the
console).
* Get a greeting by calling the `<!--ref:greetings-->` package’s `Hello` function.

Build and run your program:

<!--step: buildrun_hello-->

Congrats! You've written two functioning modules. Next you'll add some error handling.

### Return and handle an error

Handling errors is an essential feature of solid code. In this section, you'll add a bit of code to return an error from
the `<!--ref:greetings-->` module, then handle it in the caller.

Return to the `<!--ref:greetings-->` module directory:

<!--step:cd_greetings-->

There's no sense sending a greeting back if you don't know who to greet. Return an error to the caller if the name is
empty. Update `<!--ref:greetings_go-->` as follows:

<!--step:update_greetings_go-->

In this code, you:

* Change the function so that it returns two values: a `string` and an `error`. Your caller will check the second value to
  see if an error occurred. (Any Go function can return multiple values.)
* Import the Go standard library `errors` package so you can use its `errors.New` function.
* Add an `if` statement to check for an invalid request (an empty string where the name should be) and return an error
  if the request is invalid. The `errors.New` function returns an error with your message inside.
* Add `nil` (meaning no error) as a second value in the successful return. That way, the caller can see that the
  function succeeded.

At this point your `<!--ref:hello-->` module is referring to a pseudo version that represents the previous commit you
pushed. Therefore, you need to publish a new version of the `<!--ref:greetings-->` module.

Add and commit the changes we made to `<!--ref:greetings_go-->`:

<!--step:commit_greetings_error_handling-->

Note the id of the commit we just created:

<!--step: greetings_error_commit-->

Republish the `<!--ref:greetings-->` module:

<!--step:republish_greetings-->

Return to the `<!--ref:hello-->` module directory to now use this new version:

<!--step: cd_hello-->

By default, `go get` uses [`proxy.golang.org`](https://proxy.golang.org/) to resolve and download modules. In order to
improve the proxy's caching and serving latencies, new versions may not show up right away. Therefore, to be sure you do
not resolve a stale latest version, use the latest commit of the `<!--ref:greetings-->` module as an explicit version:

<!--step: get_latest_greetings-->

In your <!--ref:hello_go-->, handle the error now returned by the `Hello` function, along with the non-error value:

<!--step:update_hello_go_error-->

In this code, you:

* Configure the [`log` package](https://golang.org/pkg/log/) to print the command name (`"<!--ref:
  greeting_log_prefix-->"`) at the start of its log messages, without a time stamp or source file information.
* Assign both of the `Hello` return values, including the error, to variables.
* Change the `Hello` argument from Gladys’s name to an empty string, so you can try out your error-handling code.
* Look for a non-nil error value. There's no sense continuing in this case.
* Use the functions in the standard library's `log` package to output error information. If you get an error, you use
  the log package's `Fatal` function to print the error and stop the program.

Run hello.go to confirm that the code works; now that you're passing in an empty name, you'll get an error:

<!--step: run_hello_error-->

That's essentially how error handling in Go works: Return an error as a value so the caller can check for it. It's
pretty simple.

### Return a random greeting

Now you'll change your code so that instead of returning the same greeting every time, it returns one of several
predefined greeting messages.

To do this, you'll use a Go slice. A [slice](https://blog.golang.org/slices-intro) is like an array, except that it's
dynamically sized as you add and remove items. It's one of the most useful types in Go. You'll add a small slice to
contain three greeting messages, then have your code return one of the messages randomly.

Return to the `<!--ref:greetings-->` module:

<!--step: cd_greetings_random-->

Update `<!--ref:greetings_go-->` as follows:

<!--step: update_greetings_go_random-->

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

You now need to re-publish the updated `<!--ref:greetings-->` module so that we can use it in our `<!--ref: hello-->`
module.

Add and commit the changes you just made:

<!--step: greeings_commit_random-->

Note the id of the commit we just created:

<!--step: greetings_random_commit-->

Republish the `<!--ref:greetings-->` module:

<!--step: greetings_publish_random-->

Return to the `<!--ref:hello-->` module directory and use this new version:

<!--step: hello_use_random-->

Re-add Gladys's name as an argument to the `Hello` function call in `<!--ref:hello_go-->`:

<!--step: hello_go_readd_gladys-->

Run `<!--ref:hello_go-->` to confirm the code works. Notice that because of the constant seed, running the program
always gives the same greeting format. We will come back to that shortly:

<!--step: hello_run_random-->

That's an introduction to a Go slice. To get even more use out of this type, you'll use a slice to greet multiple
people, where we will start to see some "real" pseudo-random greetings!

### Return greetings for multiple people

In the last changes you'll make to the `<!--ref:greetings-->` module code, you'll add support for getting greetings for
multiple people in one request. In other words, you'll handle a multiple-value input and pair values with a
multiple-value output.

Change back to the `<!--ref:greetings-->` module:

<!--step: greetings_start_multiple-->

To do this, you'll need to pass a set of names to a function that can return a greeting for each of them. Changing the
`Hello` function's parameter from a single name to a set of names would change the function signature. Given that you
have already published the greetings module, other users might already have written code calling `Hello`, that change
would break their programs.  In this situation, a better choice is to give new functionality a new name.

Add a new function `Hellos` that takes a set of names. For the sake of simplicity, have the new function call the
existing one. Keeping both functions in the package leaves the original for existing callers (or future callers who only
need one greeting) and adds a new one for callers that want the expanded functionality:

<!--step:greetings_go_multiple_people-->

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

Instead of republishing the `<!--ref: greetings-->` module, let's add a [`replace`
directive](https://golang.org/ref/mod#go-mod-file-replace) in our `<!--ref:hello-->` module that tells the `go` command
to use a local directory instead of a published module.

First return to the `<!--ref: hello-->` module:

<!--step: hello_use_multiple-->

Now add a `replace` directive using `<!--ref: cmdgo.modedit-->`:

<!--step: hello_replace_greetings-->

We can see the result in the `<!--ref:hello-->` module `go.mod` file:

<!--step: hello_cat_go_mod_replace-->

In your `<!--ref:hello_go-->` calling code, pass a slice of names, then print the contents of the names/messages map you
get back:

<!--step: hello_go_call_multiple-->

With these changes, you:

* Create a `names` variable as a slice type holding three names.
* Pass the `names` variable as the argument to the `Hellos` function.

Run `<!--ref:hello_go-->` to confirm that the code works, the output should be a string representation of the map
associating names with messages:

<!--step: hello_run_multiple-->

This section introduced maps for representing name/value pairs. It also introduced the idea of preserving backward
compatibility by implementing a new function for new or changed functionality in a module. In the next section, you'll
use built-in features to create a unit test for your code.

### Add a test

Now that you've gotten your code to a stable place (nicely done, by the way), add a test. Testing your code during
development can expose bugs that find their way in as you make changes. In this topic, you add a test for the `Hello`
function.

Go's built-in support for unit testing makes it easier to test as you go. Specifically, using naming conventions, Go's
`testing` package, and the `go test` command, you can quickly write and execute tests. You will create this test in the
`<!--ref:greetings-->` module.

Return to the `<!--ref:greetings-->` module:

<!--step:greetings_return_to_write_test-->

Create a file called `<!--ref:greetings_test_go-->`:

<!--step: greetings_create_greetings_test_go-->

If this code, you:

* Implement test functions in the same package as the code you're testing.
* Create two test functions to test the `<!--ref:greetings-->.Hello` function. Test function names have the form
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

At the command line in the greetings directory, run the `<!--ref:cmdgo.test-->` command to execute the test. The
`<!--ref:cmdgo.test-->` command executes test functions (whose names begin with `Test`) in test files (whose names end with
`_test.go`). You can add the `-v` flag to get verbose output that lists all of the tests and their results.

The tests should pass:

<!--step: greetings_run_tests-->

You will now break the `<!--ref:greetings-->.Hello` function to view a failing test. The `TestHelloName` test function
checks the return value for the name you specified as a `Hello` function parameter. To view a failing test result, change
the `<!--ref:greetings-->.Hello` function so that it no longer includes the name:

<!--step: greetings_go_break-->

Note that the highlighted lines change the value that the function returns, as if the `name` argument had been
accidentally removed.

At the command line in the greetings directory, run `<!--ref:cmdgo.test-->` to execute the test. This time, run go test
without the `-v` flag. The output will include results for only the tests that failed, which can be useful when you have
a lot of tests. The `TestHelloName` test should fail -- `TestHelloEmpty` still passes:

<!--step: greetings_run_tests_fail-->

Let's restore `<!--ref: greetings-->.Hello` to a working state

<!--step: greetings_go_restore-->

And re-run `<!--ref:cmdgo.test-->` to verify our change:

<!--step: greetings_check_tests_pass-->

This section introduced Go's built-in support for unit testing. In the next section, you'll see how to compile and
install your code to run it locally.

### Compile and install the application

In the last section, you'll learn a new `go` command. While the `<!--ref:cmdgo.run-->` command is a useful shortcut for compiling and
running a single-file program, it doesn't generate a binary executable you can easily run again. If you want one of
those, a good choice is to run the `<!--ref:cmdgo.install-->` command, which compiles your code and installs the resulting binary
executable where you can run it.

Change to the directory that contains the `<!--ref:hello-->` module:

<!--step: hello_cd_for_install-->

Discover the Go install path, where the `go` command will install the current package:

<!--step: hello_go_list_target-->

Add the Go install directory to your system's shell path (this is generally a one-off step, you won't need to do this
for other programs). That way, you'll be able to run your program's executable without specifying where the executable
is:

<!--step: hello_add_gopath_bin_path-->

Once you've updated the shell path, run the `<!--ref: cmdgo.install-->` command to compile and install the package:

<!--step: hello_go_install-->

Run your application by simply typing its name:

<!--step: hello_run_by_name-->

That wraps up this Go tutorial!
