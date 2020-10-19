---
layout: post
title:  "An introduction to play-with-go.dev guides"
categories: beginner
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

Throughout each guide (prose) you will see clickable _command_ and _code_ blocks. For example, click on the following
command block:

<!--step: echo_hello -->

Clicking on command block causes those commands to run in the interactive terminal on the right hand side. Command
blocks are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be on
the lines that follow. Command blocks can contain multiple commands:

<!--step: multiple_commands -->

You can also upload code/content to our interactive session using code blocks. Click on the following code block to
upload contents to `<!--ref: readmetxt -->`:

<!--step: upload_readme -->

If a later code block updates a file, we typically highlight the bits that have changed:

<!--step: upload_readme_again -->

Now that we have uploaded `<!--ref: readmetxt -->` we can run another command to show us its contents:

<!--step: cat_readme -->

### The interactive terminal

As mentioned above, the interactive terminal is connected to a remote virtual session, hosted on [Google
Cloud](https://cloud.google.com/). For Go-related guides, the remote session starts with the following user and working
directory unless indicated otherwise:

<!--step: whoami-->

`<!--outref: wd-->` is referred to as the home directory of the `<!--outref: user-->` user.

Some guides need you to publish code to a remote source code repository. For such guides, a unique remote repository is
automatically created against the https://gopher.live [`gitea`](https://gitea.io) instance. The URL of the repository will be
made clear in the guide; authentication will be handled automatically.


### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

