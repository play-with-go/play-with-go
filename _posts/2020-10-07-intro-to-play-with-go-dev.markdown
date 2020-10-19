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
terminal that is connected to a remote virtual session, hosted on [Google Cloud](https://cloud.google.com/). _Do not
enter any personal credentials/details into the interactive terminal. We make no guarantees on the security of these
remotes sessions._

Throughout each guide (prose) you will see clickable _command_ and _code_ blocks. For example, click on the following
command block:

```.term1
$ echo "Hello, world!"
Hello, world!
```
{:data-command-src="ZWNobyAiSGVsbG8sIHdvcmxkISIK"}

Clicking on command block causes those commands to run in the interactive terminal on the right hand side. Command
blocks are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be on
the lines that follow. Command blocks can contain multiple commands:

```.term1
$ echo "Hello"
Hello
$ echo "Gopher!"
Gopher!
```
{:data-command-src="ZWNobyAiSGVsbG8iCmVjaG8gIkdvcGhlciEiCg=="}

You can also upload code/content to our interactive session using code blocks. Click on the following code block to
upload contents to `/home/gopher/readme.txt`:

<pre data-upload-path="L2hvbWUvZ29waGVy" data-upload-src="cmVhZG1lLnR4dA==:VGhpcyBpcyAvaG9tZS9nb3BoZXIvcmVhZG1lLnR4dC4KCkhlbGxvLCBnb3BoZXIhCg==" data-upload-term=".term1"><code class="language-txt">This is /home/gopher/readme.txt.

Hello, gopher!
</code></pre>

If a later code block updates a file, we typically highlight the bits that have changed:

<pre data-upload-path="L2hvbWUvZ29waGVy" data-upload-src="cmVhZG1lLnR4dA==:VGhpcyBpcyAvaG9tZS9nb3BoZXIvcmVhZG1lLnR4dC4KCkhlbGxvLCBnb3BoZXIhCgpXZSBtYWRlIGEgY2hhbmdlIQo=" data-upload-term=".term1"><code class="language-txt">This is /home/gopher/readme.txt.

Hello, gopher!
<b style="color:darkblue"></b>
<b style="color:darkblue">We made a change!</b>
</code></pre>

Now that we have uploaded `/home/gopher/readme.txt` we can run another command to show us its contents:

```.term1
$ cat /home/gopher/readme.txt
This is /home/gopher/readme.txt.

Hello, gopher!

We made a change!

```
{:data-command-src="Y2F0IC9ob21lL2dvcGhlci9yZWFkbWUudHh0Cg=="}

### The interactive terminal

As mentioned above, the interactive terminal is connected to a remote virtual session, hosted on [Google
Cloud](https://cloud.google.com/). For Go-related guides, the remote session starts with the following user and working
directory unless indicated otherwise:

```.term1
$ whoami
gopher
$ pwd
/home/gopher
```
{:data-command-src="d2hvYW1pCnB3ZAo="}

`/home/gopher
` is referred to as the home directory of the `gopher
` user.

Some guides need you to publish code to a remote source code repository. For such guides, a unique remote repository is
automatically created against the https://gopher.live [`gitea`](https://gitea.io) instance. The URL of the repository
will be made clear in the guide; authentication will be handled automatically. For example, if we are creating a module
called `hello`, the guide will automatically create a module path for us, like `gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}`. The first part
of this module path looks familiar: `gopher.live/hello`. It is followed by a random suffix that makes it unique to you.
The remote version control system URL corresponding to this module path is `https://gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}.git`:

```.term1
$ git ls-remote https://gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}.git
```
{:data-command-src="Z2l0IGxzLXJlbW90ZSBodHRwczovL2dvcGhlci5saXZlL3t7ey5SRVBPMX19fS5naXQK"}


### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

<script>let pageGuide="2020-10-07-intro-to-play-with-go-dev"; let pageLanguage="en"; let pageScenario="go115";</script>
