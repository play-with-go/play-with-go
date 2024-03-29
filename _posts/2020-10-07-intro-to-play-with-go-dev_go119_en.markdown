---
category: Start here
difficulty: Beginner
excerpt: Learn about how to get the most out of play-with-go.dev guides
guide: 2020-10-07-intro-to-play-with-go-dev
lang: en
layout: post
redirect_from:
- /intro-to-play-with-go-dev_go115_en/
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

For Go-related guides, the remote session runs with a user and working directory as follows:

<pre data-command-src="d2hvYW1pCnB3ZAo="><code class="language-.term1">$ whoami
gopher
$ pwd
/home/gopher
</code></pre>

Throughout each guide (prose) you will see clickable _command_ and _code_ blocks. For example, click on the following
command block:

<pre data-command-src="ZWNobyAnKioqICEhISBDTElDSyBNRSAhISEgKioqJwo="><code class="language-.term1">$ echo &#39;*** !!! CLICK ME !!! ***&#39;
*** !!! CLICK ME !!! ***
</code></pre>

Clicking on command block causes those commands to run in the interactive terminal on the right hand side. Command
blocks are indicated by a `$` sign at the beginning of a line; the output from that command (if there is any) will be on
the lines that follow. Command blocks can contain multiple commands:

<pre data-command-src="bWtkaXIgaGVsbG8KY2QgaGVsbG8K"><code class="language-.term1">$ mkdir hello
$ cd hello
</code></pre>

You can also upload code/content to our interactive session using code blocks. Click on the following code block to
upload contents to `README.md`:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="UkVBRE1FLm1k:VGhpcyBpcyBSRUFETUUubWQuCgpIZWxsbywgZ29waGVyIQo=" data-upload-term=".term1"><code class="language-md">This is README.md.

Hello, gopher!
</code></pre>

If a later code block updates a file, we typically highlight the bits that have changed:

<pre data-upload-path="L2hvbWUvZ29waGVyL2hlbGxv" data-upload-src="UkVBRE1FLm1k:VGhpcyBpcyBSRUFETUUubWQuCgpIZWxsbywgZ29waGVyIQoKV2UgbWFkZSBhIGNoYW5nZSEK" data-upload-term=".term1"><code class="language-md">This is README.md.

Hello, gopher!
<b></b>
<b>We made a change!</b>
</code></pre>

Now that we have uploaded `README.md` we can run another command to show us its contents:

<pre data-command-src="Y2F0IFJFQURNRS5tZAo="><code class="language-.term1">$ cat README.md
This is README.md.

Hello, gopher!

We made a change!

</code></pre>

### Remote source code repositories

Some guides need you to publish code to a remote source code repository. For such guides, a unique user is automatically
created for you in the [`gopher.live`](https://gopher.live) [`gitea`](https://gitea.io) instance. Repostitories are
created beneath that user account. For example, for this guide we have created the unique user `{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}`
and a repository called `hello`.

Let's add the `README.md` file we created earlier to this remote repository.

Initialise a local `git` repository and add the remote:

<pre data-command-src="Z2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlJFUE8xfX19LmdpdAo="><code class="language-.term1">$ git init -q
$ git remote add origin https://&#123;&#123;&#123;.REPO1&#125;&#125;&#125;.git
</code></pre>

Add and commit the `README.md` file we created earlier:

<pre data-command-src="Z2l0IGFkZCBSRUFETUUubWQKZ2l0IGNvbW1pdCAtcSAtbSAnSW5pdGlhbCBjb21taXQnCg=="><code class="language-.term1">$ git add README.md
$ git commit -q -m &#39;Initial commit&#39;
</code></pre>

Push the commit to the remote repository:

<pre data-command-src="Z2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"><code class="language-.term1">$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>

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
<script>let pageGuide="2020-10-07-intro-to-play-with-go-dev"; let pageLanguage="en"; let pageScenario="go119";</script>
