---
layout: post
title:  "Shuffling Go tests"
excerpt: "Learn how to shuffle execution order of tests and benchmarks"
category: What's coming in Go 1.17
difficulty: Beginner
---

*By [Paschalis Tsilias](https://twitter.con/tpaschalis_), Go developer*.

*Note: this is a preview of a `go test` feature that is due to land in Go 1.17*


### Intro
Testing is a first-class citizen in the Go ecosystem. This means that the barrier to testing Go projects is lower, and that there is little cognitive overhead to reading and understanding test code in unfamiliar projects. 

But once suites start growing, unwanted dependencies may appear between different test and benchmark functions. In some cases, the suite may be passing, but actually fail if the tests are run in a different order. 

This guide will walk you through creating a new Go package and its test file, which appears to run correctly, but contains a subtle flaw.

You will use the new `-shuffle` flag to uncover this defect, and enforce randomization of test ordering to avoid such issues reappearing in the future. So, let’s get into it!

### The `gopher` package
So let’s build a new package by creating a folder and initializing a Go module.

{{{ step "gopherkv_create" }}}

Our `gopherkv` package will provide the smallest in-memory Key-Value storage, powered by a single `map[string]string`. Every grand project idea has to start somewhere right?

{{{ step "gopherkv_initial" }}}


### Let’s test it!
So let’s create a new `gopher_test.go` file which will test the functionality present in the `gopher` package.

{{{ step "gopherkv_initial_test" }}}

Let's actually run the tests in this file

{{{ step "go_test_initial" }}}

It seems that we not only have a passing test suite, but *also* that we're achieving 100% coverage for our package. 

Sounds like we're off to a pretty good start, right?

### Let’s shuffle things up!
Some of you may be already raising some concerns regarding the tests we wrote. They contain a subtle flaw that may not be immediately apparent. 

Let’s run the test suite again and randomize the execution order by using `go test ./… -shuffle=<seed>`.

{{{ step "go_test_shuffle_100" }}}

We now get a failure, and our 'green' test suite may not be so great after all! 

The way that the tests initialize and use the shared `kv` pacakge-level variable, makes them dependent on each other and a different execution order will result in failures.

We can see, that since the test failed Go reports the seed used for the current run so that such failures can be reproduced anywhere by running `go test ./… -shuffle=N`.

### Along the -count flag 
The `-count` flag is often used with the go test command, either to disable caching or uncover flaky tests. 

Whenever the `-shuffle` and `-count` flags are used together, the execution order will be randomized once at the start, and then re-used for the next runs. This can help to spot rare cases of flaky tests failing for specific test seeds.

### Do I always need to provide a seed value?
One way to strengthen your tests suite is to run them using the `-shuffle=on` flag. Each time, a new seed will be selected based on your system's clock.

### Conclusion
That’s all! This guide has introduced the `-shuffle` flag for the go test command, demonstrated how test reordering can uncover flaws in our test suite, and how we can continously try to detect and prevent such issues in the future. 

As a next step you might like to consider:
* [Developer tools as module dependencies](/tools-as-dependencies_go115_en/)
* [How to use and tweak Staticcheck](/using-staticcheck_go115_en/)
