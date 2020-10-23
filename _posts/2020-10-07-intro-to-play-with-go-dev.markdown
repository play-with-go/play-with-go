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
$ mkdir hello
$ cd hello
```
{:data-command-src="bWtkaXIgaGVsbG8KY2QgaGVsbG8K"}

You can also upload code/content to our interactive session using code blocks. Click on the following code block to
upload contents to `README.md`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="UkVBRE1FLm1k:VGhpcyBpcyBSRUFETUUubWQuCgpIZWxsbywgZ29waGVyIQo=" data-upload-term=".term1"><code class="language-md">This is README.md.

Hello, gopher!
</code></pre>

If a later code block updates a file, we typically highlight the bits that have changed:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="UkVBRE1FLm1k:VGhpcyBpcyBSRUFETUUubWQuCgpIZWxsbywgZ29waGVyIQoKV2UgbWFkZSBhIGNoYW5nZSEK" data-upload-term=".term1"><code class="language-md">This is README.md.

Hello, gopher!
<b style="color:darkblue"></b>
<b style="color:darkblue">We made a change!</b>
</code></pre>

Now that we have uploaded `README.md` we can run another command to show us its contents:

```.term1
$ cat README.md
This is README.md.

Hello, gopher!

We made a change!

```
{:data-command-src="Y2F0IFJFQURNRS5tZAo="}

### The interactive terminal

As mentioned above, the interactive terminal is connected to a remote virtual session, hosted on [Google
Cloud](https://cloud.google.com/). For Go-related guides, the remote session is running as the `gopher`
user, with a working directory of `/home/gopher`, which is also referred to as the home directory of the
`gopher` user.

### Remote source code repositories

Some guides need you to publish code to a remote source code repository. For such guides, a unique user is automatically
created for you in the [`gopher.live`](https://gopher.live) [`gitea`](https://gitea.io) instance. Repostitories are
created beneath that user account. For example, for this guide we have created the unique user `{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}`
and a repository called `hello`.

Let's add the `README.md` file we created earlier to this remote repository.

Initialise a local `git` repository and add the remote:

```.term1
$ git init -q
$ git remote add origin https://{% raw %}{{{.REPO1}}}{% endraw %}.git
```
{:data-command-src="Z2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlJFUE8xfX19LmdpdAo="}

Add and commit the `README.md` file we created earlier:

```.term1
$ git add -A
$ git commit -am 'Initial commit'
[main (root-commit) abcd123] Initial commit
 1 file changed, 6 insertions(+)
 create mode 100644 README.md
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1hbSAnSW5pdGlhbCBjb21taXQnCg=="}

Push the commit to the remote repository:

```.term1
$ git push origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
To https://gopher.live/{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}/hello.git
 * [new branch]      main -> main
```
{:data-command-src="Z2l0IHB1c2ggb3JpZ2luIG1haW4K"}

It's as easy as that. Authentication is taken care of for you. The user and repository will be destroyed after 3 hours
along with the guide session.


### I'm lost, help!

Don't worry, there are people who can help! Either head over to `#play-with-go` on [Gophers
Slack](https://gophers.slack.com/) ([sign-up](https://invite.slack.golangbridge.org/)) or [raise an
issue](https://github.com/play-with-go/play-with-go/issues/new?title=help:&labels=question) in our GitHub issue tracker.

<script>let pageGuide="2020-10-07-intro-to-play-with-go-dev"; let pageLanguage="en"; let pageScenario="go115";</script>
