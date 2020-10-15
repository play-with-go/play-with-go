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
terminal that is connected to a remote virtual session, hosted on [Google Cloud](https://cloud.google.com/).

Throughout each guide (prose) you will see clickable blocks of command and code. For example, try clicking on the
following command block:

<!--step: echo_hello -->

Clicking on block of commands causes those commands to run in the interactive terminal on the right hand side. Blocks of
commands are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be
on the lines that follow. Command blocks can contain multiple commands:

<!--step: multiple_commands -->

We can also upload code/content to our interactive session using code blocks. Try clicking on the following code block
to upload contents to `<!--ref: readmetxt -->`:

<!--step: upload_readme -->

When we update a file, we highlight the bits that have changed:

<!--step: upload_readme_again -->

Now that we have uploaded `<!--ref: readmetxt -->` we can run another command to do something with it:

<!--step: cat_readme -->

### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

