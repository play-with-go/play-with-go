---
categories: intermediate
guide: 2020-09-01-basic-go-modules-example
lang: en
layout: post
tags:
- modules
- tools
- versioning
terms: 1
title: A simple Go modules guide
toc: true
---

Create a module:

```.term1
$ mkdir /home/gopher/mod1
$ cd /home/gopher/mod1
$ git init
Initialized empty Git repository in /home/gopher/mod1/.git/
$ git remote add origin https://{% raw %}{{{.REPO1}}}{% endraw %}.git
$ go mod init {% raw %}{{{.REPO1}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.REPO1}}}{% endraw %}
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDEKY2QgL2hvbWUvZ29waGVyL21vZDEKZ2l0IGluaXQKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlJFUE8xfX19LmdpdApnbyBtb2QgaW5pdCB7e3suUkVQTzF9fX0K"}

Write a readme:

<pre data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="UkVBRE1FLm1k:IyMgYHt7ey5SRVBPMX19fWA=" data-upload-term=".term1"><code class="language-md">## `{% raw %}{{{.REPO1}}}{% endraw %}`</code></pre>

Write a readme:

<pre data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGxuKCJIZWxsbywgd29ybGQhIikKfQo=" data-upload-term=".term1"><code class="language-go">package main

import "fmt"

func main() {
	fmt.Println("Hello, world!")
}
</code></pre>

Commit and push:

```.term1
$ git add README.md main.go
$ git commit -q -m "Initial commit"
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGFkZCBSRUFETUUubWQgbWFpbi5nbwpnaXQgY29tbWl0IC1xIC1tICJJbml0aWFsIGNvbW1pdCIKZ2l0IHB1c2ggLXEgb3JpZ2luIG1haW4K"}

Use the module:

```.term1
$ mkdir /home/gopher/mod2
$ cd /home/gopher/mod2
$ go mod init mod.com
go: creating new go.mod: module mod.com
$ go get {% raw %}{{{.REPO1}}}{% endraw %}
go: downloading {% raw %}{{{.REPO1}}}{% endraw %} v0.0.0-20060102150405-abcedf12345
go: {% raw %}{{{.REPO1}}}{% endraw %} upgrade => v0.0.0-20060102150405-abcedf12345
$ go run {% raw %}{{{.REPO1}}}{% endraw %}
Hello, world!
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDIKY2QgL2hvbWUvZ29waGVyL21vZDIKZ28gbW9kIGluaXQgbW9kLmNvbQpnbyBnZXQge3t7LlJFUE8xfX19CmdvIHJ1biB7e3suUkVQTzF9fX0K"}

You're done!

<script>let pageGuide="2020-09-01-basic-go-modules-example"; let pageLanguage="en"; let pageScenario="go115";</script>
