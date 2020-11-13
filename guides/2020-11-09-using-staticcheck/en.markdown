---
layout: post
title:  "How to use and tweak Staticcheck"
excerpt: "Using static analysis to automatically find bugs and performance optimizations."
category: Next steps
difficulty: Intermediate
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

This guide gets you up and running with Staticcheck by analysing the `<!--ref: pets_mod-->` module.

### Prerequisites

You should already have completed:

* [Go fundamentals](/go-fundamentals_go115_en)

This guide is running using:

<!--step: goversion-->

### Installing Staticcheck

In this guide you will install Staticcheck to your `PATH`. For details on how to add development tools as a project
module dependency, please see the ["Developer tools as module dependencies" guide](/tools-as-dependencies_go115_en).

Use `<!--ref: cmdgo.get-->` to install Staticcheck:

<!--step: staticcheck_install-->

_Note: so that this guide remains reproducible we have spcified an explicit version, `<!--ref: staticcheck_version-->`.
When running yourself you could use the special version `<!--ref:cmdgo.vlatest-->`._

The rather ugly use of a temporary directory ensures that `<!--ref:cmdgo.get-->` is run outside of a module.  See the
_"Setting up your `PATH`"_ section in [Installing Go](/installing-go_go115_en) to ensure your `PATH` is set correctly.

Check that `staticcheck` is on your `PATH`:

<!--step: staticcheck_check_on_path-->

Run `staticcheck` as a quick check:

<!--step: staticcheck_version-->

You're all set!

### Create the `<!--ref:pets-->` module

Time to create an initial version of the `<!--ref: pets-->` module:

<!--step: pets_init-->

Because you are not going to publish this module (or import the `<!--ref:pets-->` package; it's just a toy
example), you do not need to initialise this directory as a `git` repository and can give the module whatever path you
like. Here, simply `<!--ref: pets-->`.

Create an inital version of the `<!--ref:pets-->` package in `<!--ref:pets_go-->`:

<!--step: pets_go_initial-->

This code looks sensible enough. Build it to confirm there are no compile errors:

<!--step: pets_build_initial-->

All good. Or is it? Let's run Staticcheck to see what it thinks.

Staticcheck can be run on code in several ways, mimicking the way the official Go tools work. At its core, it expects to
be run on well-formed Go packages. So let's run it on the current package, the `<!--ref:pets-->` package:

<!--step: pets_staticcheck_initial-->

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
the checks even have examples. You can also use the `<!--ref:staticcheck_explain_flag-->` flag to get details at the command
line:

<!--step: staticcheck_explain-->

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

Each error message explains the problem, but also indicates how to fix the problem. Let's fix up `<!--ref:pets_go-->`:

<!--step:pets_go_fixed-->

And re-run Staticcheck to confirm:

<!--step:pets_staticcheck_fixed-->

Excellent, much better.

### Configuring Staticcheck

Staticcheck works out of the box with some sensible, battle-tested defaults. However, various aspects of Staticcheck can
be customized with configuration files.

Whilst fixing up the problems Staticcheck reported, you notice that the `<!--ref:pets-->` package is missing a package
comment. You also happened to notice on the Staticcheck website that check
[`<!--ref:staticcheck_st1000-->`](https://staticcheck.io/docs/checks#<!--ref:staticcheck_st1000-->) covers exactly this
case, but that it is not enabled by default.

Staticcheck configuration files are named `<!--ref:staticcheck_conf-->` and contain
[TOML](https://github.com/toml-lang/toml).

Let's create a Staticcheck configuration file to enable check `<!--ref:staticcheck_st1000-->`, inheriting from the
Staticcheck defaults:

<!--step: staticcheck_config_initial-->

Re-run Staticcheck to verify `<!--ref:staticcheck_st1000-->` is reported:

<!--step: pets_staticcheck_st1000_enabled-->

Excellent. Add a package comment to `<!--ref:pets_go-->` to fix the problem:


<!--step: pets_go_with_package_comment-->

Re-run Staticcheck to confirm there are no further problems:

<!--step: pets_staticcheck_st1000_fixed-->


### Ignoring problems

Before going much further, you decide it's probably a good idea to be able to feed a pet, and so make the following
change to `<!--ref:pets_go-->`:

<!--step: pets_go_feed-->

Re-run Staticcheck to verify all is still fine:

<!--step: pets_staticcheck_check_feed-->

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
ignore `<!--ref:staticcheck_sa4018-->` using a line directive, updating `<!--ref:pets_go-->`:

<!--step: pets_go_ignore_sa4018-->

Verify that Staticcheck no longer complains:

<!--step: pets_staticcheck_check_sa4018_ignored-->

In some cases, however, you may want to disable checks for an entire file. For example, code generation may leave behind
a lot of unused code, as it simplifies the generation process. Instead of manually annotating every instance of unused
code, the code generator can inject a single, file-wide ignore directive to ignore the problem.

Let's change the line-based linter directive to a file-based one in `<!--ref:pets_go-->`:

<!--step: pets_go_file_ignore_sa4018-->

Verify that Staticcheck continues to ignore this check:

<!--step: pets_staticcheck_check_sa4018_still_ignored-->

Great. That's both line and file-based linter directives covered, demonstrating how to ignore certain problems.

Finally, let's remove the linter directive, and fix up your code:

<!--step: pets_go_final-->

And check that Staticcheck is happy one last time:

<!--step: pets_staticcheck_final-->

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






