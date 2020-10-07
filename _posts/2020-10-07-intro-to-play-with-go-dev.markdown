---
categories: beginner
guide: 2020-10-07-intro-to-play-with-go-dev
lang: en
layout: post
title: An introduction to play-with-go.dev guides
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

```.term1
$ echo "Hello, world!"
Hello, world!
```
{:data-command-src="ZWNobyAiSGVsbG8sIHdvcmxkISIK"}

Clicking on block of commands causes those commands to run in the interactive terminal on the right hand side. Blocks of
commands are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be
on the lines that follow. Command blocks can contain multiple commands:

```.term1
$ whoami
gopher
$ echo "Hello, gopher!"
Hello, gopher!
```
{:data-command-src="d2hvYW1pCmVjaG8gIkhlbGxvLCBnb3BoZXIhIgo="}

We can also upload code/content to our interactive session using code blocks. Try clicking on the following code block
to upload contents to `/home/gopher/readme.txt`:

```txt
This is /home/gopher/readme.txt.

Hello, gopher!
```
{:data-upload-path="L2hvbWUvZ29waGVy" data-upload-src="cmVhZG1lLnR4dA==:VGhpcyBpcyAvaG9tZS9nb3BoZXIvcmVhZG1lLnR4dC4KCkhlbGxvLCBnb3BoZXIh" data-upload-term=".term1"}

Now that we have uploaded `/home/gopher/readme.txt` we can run another command to do something with it:

```.term1
$ cat /home/gopher/readme.txt
This is /home/gopher/readme.txt.

Hello, gopher!
```
{:data-command-src="Y2F0IC9ob21lL2dvcGhlci9yZWFkbWUudHh0Cg=="}

### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

<script>let pageGuide="2020-10-07-intro-to-play-with-go-dev"; let pageLanguage="en"; let pageScenario="go115";</script>
