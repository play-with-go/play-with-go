---
layout: post
title:  "An introduction to play-with-go.dev guides"
excerpt: "Learn about how to get the most out of play-with-go.dev guides"
difficulty: Beginner
category: Start here
redirect_from:
  - /intro-to-play-with-go-dev_go115_en/
---

[`play-with-go.dev`](https://play-with-go.dev/) is a series of interactive browser-based guides that lead you on a tour
of the [Go command](https://golang.org/cmd/go/) and [Go modules](https://golang.org/ref/mod).

If you have not done so already, head over and complete [the Go Tour](https://tour.golang.org); it presents an excellent
interactive introduction to Go the programming language.

`play-with-go.dev` helps you take the next steps to practically getting things done with Go, covering various topics
from writing tests, understanding Go modules, static analysis, code generation and much more.

### Structure of `play-with-go.dev` guides

`play-with-go.dev` guides are best viewed on a laptop or desktop device with a good sized screen. The left hand side
(the bit you are reading now) is the guide itself, otherwise known as the prose. The right hand size is an interactive
terminal that is connected to a remote virtual session, hosted on [Google Cloud](https://cloud.google.com/). _Do not
enter any personal credentials/details into the interactive terminal. We make no guarantees on the security of these
remotes sessions._

For Go-related guides, the remote session runs with a user and working directory as follows:

{{{ step "whoami" }}}

Throughout each guide (prose) you will see clickable _command_ and _code_ blocks. For example, click on the following
command block:

{{{ step "echo_hello" }}}

Clicking on command block causes those commands to run in the interactive terminal on the right hand side. Command
blocks are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be on
the lines that follow. Command blocks can contain multiple commands:

{{{ step "multiple_commands" }}}

You can also upload code/content to our interactive session using code blocks. Click on the following code block to
upload contents to `{{{ .readme }}}`:

{{{ step "upload_readme" }}}

If a later code block updates a file, we typically highlight the bits that have changed:

{{{ step "upload_readme_again" }}}

Now that we have uploaded `{{{ .readme }}}` we can run another command to show us its contents:

{{{ step "cat_readme" }}}

### Remote source code repositories

Some guides need you to publish code to a remote source code repository. For such guides, a unique user is automatically
created for you in the [`gopher.live`](https://gopher.live) [`gitea`](https://gitea.io) instance. Repositories are
created beneath that user account. For example, for this guide we have created the unique user `{{{.username}}}`
and a repository called `{{{ .modname }}}`.

Let's add the `{{{ .readme }}}` file we created earlier to this remote repository.

Initialise a local `git` repository and add the remote:

{{{ step "gitinit" }}}

Add and commit the `{{{ .readme }}}` file we created earlier:

{{{ step "gitadd" }}}

Push the commit to the remote repository:

{{{ step "gitpush" }}}

It's as easy as that. Authentication is taken care of for you. The user and repository will be destroyed after 3 hours
along with the guide session.


### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

### Next steps

As a next step you might like to consider:

* [Get started with Go](/get-started-with-go_go119_en/)
* [Go Fundamentals](/go-fundamentals_go119_en)
