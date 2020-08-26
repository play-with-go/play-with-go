### Writing your first `play-with-go.dev` guide!

This guide explains how to create your first `play-with-go.dev` guide using the `play-with-go` development environment.
Guides are first developed locally, then pushed as pull requests to the
[`play-with-go`](https://github.com/play-with-go/play-with-go) project.

_This_ guide the entire local development process.  Creating a pull request and the review workflow is discussed
elsewhere (TODO: create a wiki/document).

### Prerequisites

This guide uses the following commands:

<pre><code>$ docker version -f &#123;&#123;.Server.Version&#125;&#125;
19.03.13
$ docker-compose version
docker-compose version 1.26.2, build eefe0d31
docker-py version: 4.2.2
CPython version: 3.7.7
OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019
$ go version
go version go1.15.5 linux/amd64
</code></pre>

### Getting started `play-with-go`

Start by cloning the `play-with-go` project:

<pre><code>$ git clone -q https://github.com/play-with-go/play-with-go
$ cd play-with-go
$ git checkout simple_guide
Branch &#39;simple_guide&#39; set up to track remote branch &#39;simple_guide&#39; from &#39;origin&#39;.
Switched to a new branch &#39;simple_guide&#39;
</code></pre>

<pre><code>Blah
</code></pre>

Create a branch for our changes:

As you can see, we are using commit [`<!--def: playWithGoCommit -->`](https://github.com/play-with-go/play-with-go/tree/simple_guide)
as a known starting point; you can omit this commit if you like which default to using `origin/main`

TODO: make this a guide that demonstrates how to create a guide.

## Terminology and Overall structure

Explain:

* how guides are the result of combinding the markdown prose with a CUE specification of the "steps" in that guide, i.e.
  the commands the user will run
* the directory structure currently used by play-with-go, and how this feeds into the Jekyll frontend
* the concept of the input guide CUE package and the generated output (that can be augmented with guide author
  declarations)
* ...

We use the following terminology:

* the user - the end user who is reading and following the guide in a browser, executing the various steps via the PWD
  console
* guide author - the person who created the guide
* `preguide` - is the authoring tool used by the guide author when writing a guide. `preguide` ensures that the steps in
  a guide can be run and are reproducible
* remote session - is used to refer to the container that is driving the container that is visualised via the frontend
  terminal
* define the terms input and output. Possibly distinguish between the markdown and script input, and markdown and
  command result output. A diagram?

## Presteps

Presteps are declared by a guide author to run as each guide instance is launched. For example, for this guide we have a
prestep that creates a unique user account and repository in the source control system that supports the
`play-with-go.dev/userguides/...` modules. This therefore allows us to create a local `git` repository that uses the
that remote repository:

<!-- step: create_local_repo -->

Let's add a readme file to explain what this repository is all about:

<!-- step: add_readme -->

Create our initial commit and push to the remote repository:

<!-- step: create_initial_commit -->


TODO:

* make this a Go module for a library
* then create a local Go module that uses the new library and pulls that through the proxy
* explain that a guide can run multiple presteps, or none

## Different types of step

`preguide` defines two basic steps that a user can perform:

* run a sequence of commands
* uploading a file

`preguide` exposes these to the guide author as four step types (the reference to the CUE package
`github.com/play-with-go/preguide` is shortened to simply `preguide`):

* `preguide.#Command` - run a sequence of commands, providing those steps inline with the step declaration
* `preguide.#CommandFile` - run a sequence of commands, with the steps being sourced from a file
* `preguide.#Upload` - upload a file to the remote session, providing the files contents inline with the step declaration
* `preguide.#UploadFile` - upload a file to the remote session, with the file contents being sourced from a file

Within a the markdown prose

## Translations and scenarios

TODO:

Explain that:

* a guide can vary by langauge (i.e. translated into a different language, potentially with different steps specific to
  that language), and/or
* a giude can vary by scenario. e.g. a guide is predominantly writtern for Go 1.15, but alternative language (and steps)
  are provided for Go 1.14 where there are differences


## Multiple remote sessions

TODO:

Explain that:

* guides can be written to leverage multiple terminals, i.e. remote sessions. Particularly useful for client-server
  interaction examples

## Reference directives

Consider the following commands:

<!-- step: random_commands -->

Notice how the step is declared in terms of a `Defs`-declared message. We can reference that message in the prose of a
guide using a `ref` directive: `<!-- ref: random_message -->`.

Similarly, we can use `outref` directives to refer to the result of executing the guide script. For example, here we
reference the output from the `<!-- ref: go_env_gopath -->` command directly in our prose: `<!-- outref: go_env_gopath
-->`.

TODO:

Explain that, as the guide author, you can include `ref` and `outref` directives to reference specific aspects of a
guide.

`ref` directives refer to `Defs` fields that are defined as part of the _input_ guide CUE package. They can be
arbitrary string values. Those `Defs` fields are then typically used within step declarations for that guide. Using
`ref` directives in this way ensures that parts of the guide prose and script stay consistent.

`outref` directives refer to `Defs` fields that are defined as part of the _output_ guide CUE package. This allows
the guide author to reference specific parts of the output
