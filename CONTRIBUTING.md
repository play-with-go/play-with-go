## Contributing

All contributions to the `play-with-go.dev` project are very welcome and greatly appreciated! You can contribute in many
different ways:

* providing feedback and raising issues via [the issue tracker](https://github.com/play-with-go/play-with-go/issues)
* writing guides
* making changes to the projects that support `play-with-go.dev`

We now present a high level overview of the `play-with-go.dev` setup, and then set out details of the process for
writing/maintaining guides for `play-with-go.dev`.

## Overview

The "output" of a guide is ultimately an HTML page rendered in the browser that interacts with a remote session, but
what goes in to creating a guide?

A guide is composed of three major parts:

* **markdown "prose"** - a markdown file that is the "body" of the guide, the words and explanation that surround the
  steps that the user will follow
* **a [CUE](https://cuelang.org/) "script" package** - a specification of the steps that the user will follow. Steps are
  either sequences of commands, or the creation/updating of files
* **a CUE output package** - part auto-generated (the result of executing the CUE "script" package) and, optionally,
  part specified by the guide author

The markdown "prose" is structured as follows:

* there is one markdown file per language translation (note however that full multi-language support is tracked in
  https://github.com/play-with-go/play-with-go/issues/46)
* the "body" of the guide contains directives that reference steps and definitions in the CUE "script" package via
  `step` and `ref` directives, and definitions in the CUE output package via `outref` directives

The CUE package "script" specifies the following:

* the **steps** of the guide. A step can either be a sequence of commands, or the contents of a file to write to disk in
  a remote session. Steps can be specialised for a language translation, and/or for a specific scenario (see below)
* the **scenarios** under which translations of the guide will be run. Multiple scenarios are useful where you need to
  explain differences between versions of a command. For example you might define the scenarios `go114` and `go115` in
order to explain how a command's output changes between Go 1.14 and Go 1.15. (Note however that full multi-scenario
support is tracked in https://github.com/play-with-go/play-with-go/issues/46)
* the **terminals** required for a guide. Some guides require multiple terminals, the classic example being where you
  have client and server processes: the server runs in one terminal, and the client is used to make calls to the server
from the other. Each step specifies what terminal it relates to (by default, the first terminal is assumed unless
otherwise specified). Each terminal specifies the [Docker](https://www.docker.com/) image to use when running the guide
for a given scenario. A terminal in the browser connects to a remote session, a container that is an instance of that
image.
* the **presteps** required for a guide. Some guides require some additional setup before they are "run" by the reader.
  For example, guides that explain the creating of Go modules require a public remote version control system in order
that those modules can be published. For such guides, the
[`github.com/play-with-go/gitea/cmd/gitea`](https://pkg.go.dev/github.com/play-with-go/gitea/cmd/gitea) prestep creates
a temporary user account and version control system repository. A guide can reference multiple presteps: the result of
each step is a set of environment variables that are then made available in each remote session
* **definitions**. Often when writing guides, you need to refer to parts of the "script" from the prose so the two don't
  fall out of sync. You can refer to definitions in the CUE "script" package from the script itself, or from the
markdown "prose" using `ref` directives.

The CUE output package specifies the following:

* **definitions**. Much like the CUE "script" package, the author can declare definitions in the output package
  (alongside the auto-generated "half") that reference specific fields in the generated output. You can refer to CUE
output package definitions from the markdown "prose" using `outref` directives. This is useful when you need to
reference specific parts of the output from prose, for example highlighting some specific lines from a previous command
block

The following diagram presents an overview of the steps involved with writing a guide through to a reader "running" that guide:

![Overview of the process behind writing a play-with-go.dev guide](images/overview.png "Overview of the process behind
writing a play-with-go.dev guide")

**Step 0:** the guide author starts the `play-with-go` development environment (see below for prerequisites and steps
involved)

**Step 1:** guide author creates a markdown "prose" and CUE "script" package

**Step 2:** guide author runs the `preguide` tool to validate guide. This ensures that:

* the CUE "script" package is valid (this includes validating the definitions)
* the presteps and steps of the CUE "script" package run and are valid

**Step 3:** `preguide` writes the generated half of CUE output package and then ensures that:

* the CUE output package is valid, i.e. the definitions in the guide author declared half of this package are valid
* directives in the markdown "prose" reference valid steps and definitions in the CUE "script" package, and valid
  definitions in the CUE output package

**Step 4:** `preguide` writes the output markdown guide, along with a human readable log file of the "script" that was
executed (this is nicer to read and compare at code review time)

At this stage, the guide author could return to step 1 and continue iterating. `preguide` gives complete assurance that
the steps declared in the CUE "script" package are valid and run as expected, without the guide author needing to
manually check them in the browser by "clicking through" the guide. However, it's often nice to be able to view a
properly rendered version of the guide in a browser, hence the section of the diagram in a dotted-line box illustrates
the steps involved in doing that

**Step 5:** the `play-with-go` development environment includes a Jekyll server that consumes the generated markdown
guide output from `preguide`, generating static HTML pages

**Step 6:** the guide author opens a page pointing to a webserver running as part of the Jekyll process that serves the
static HTML pages

**Step 7:** JavaScript within the generated guide calls a controller to run the presteps for the guide

**Step 8:** JavaScript within the generated guide calls via the [`play-with-docker`
SDK](https://github.com/play-with-docker/sdk) to initialise the required terminals

## Writing/maintaining guides

The best way to learn how to write a guide for `play-with-go.dev` is to follow a guide that explains the process from
start to finish. That guide can be found here: https://play-with-go.dev/writing-play-with-go-guides.

When you come to write a guide you will need to do so in your local development environment. We now explain the required
setup for local development.

### Prerequisite 1 - GitHub account with `userguides` membership

_This step is only required if you will be writing/updating guides that use the `gitea` prestep_

As explained above, the
[`github.com/play-with-go/gitea/cmd/gitea`](https://pkg.go.dev/github.com/play-with-go/gitea/cmd/gitea) prestep creates
a temporary user account and remote repository for the reader to use as part of a guide. The `gitea` prestep creates a
public GitHub repository in the https://github.com/userguides organisation as part of this setup. Hence to develop any
guides locally you need to have a GitHub account and various permissions.

Please [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=access:%20please%20grant%20me%20access%20to%20develop%20guides)
requesting member accessing to the [`userguides`](https://github.com/userguides) organisation.

Once you have been granted access, [create a new personal access token](https://github.com/settings/tokens/new) with
`public_repo` scope.

Then set the following two environment variables:

* `PLAYWITHGODEV_GITHUB_USER`
* `PLAYWITHGODEV_GITHUB_PAT`

### Prerequisite 2 - `mkcert`-created play-with-go.dev SSL certificate

_This step is only required if you will be writing/updating guides that use the `gitea` prestep_

Another prerequisite for guides that require a remote version control system is creating a certificate authority for the
`play-with-go.dev` domain. Modules that are published as part of `play-with-go.dev` guides are created under the
`play-with-go.dev/userguides/...` module path. Therefore, locally-trusted development certificates for the
`play-with-go.dev` domain are required for local development. We use [`mkcert`](https://github.com/FiloSottile/mkcert)
for this.

First, [install `mkcert`](https://github.com/FiloSottile/mkcert#installation).

Then create a play-with-go.dev SSL certificate:

```
pushd $(mkcert -CAROOT)
mkdir play-with-go.dev
mkcert -cert-file play-with-go.dev/cert.pem -key-file play-with-go.dev/key.pem "*.play-with-go.dev" play-with-go.dev
popd
```

### Start the `play-with-go.dev` environment

Run the environment in one terminal:

```
./_scripts/dc.sh up
```

In another, run a one-off setup process:

```
./_scripts/setup.sh
```

### You're ready to start writing guides!

At this point you're ready to start writing guides. As a reminder, refer back to the guide that explains [how to write
`play-with-go.dev` guides](https://play-with-go.dev/writing-play-with-go-guides) for a step-by-step explanation of the
process and concepts involved.

## I'm stuck/lost/other

Don't worry, it's highly likely that our explanations above are not good enough! Please help us improve our
documentation by [creating an issue](https://github.com/play-with-go/play-with-go/issues/new) that explains where things
got confusing/fuzzy/other.
