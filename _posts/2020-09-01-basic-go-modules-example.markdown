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
go: creating new go.mod: module gopher.live/{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}/mod1
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDEKY2QgL2hvbWUvZ29waGVyL21vZDEKZ2l0IGluaXQKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlJFUE8xfX19LmdpdApnbyBtb2QgaW5pdCB7e3suUkVQTzF9fX0K"}

Write a readme:


```markdown
## `{% raw %}{{{.REPO1}}}{% endraw %}`
```
{:data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="UkVBRE1FLm1k:IyMgYHt7ey5SRVBPMX19fWA=" data-upload-term=".term1"}

Write a readme:

```golang
import "fmt"

func main() {
	fmt.Println("Hello, world!")
}
```
{:data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGxuKCJIZWxsbywgd29ybGQhIikKfQo=" data-upload-term=".term1"}

Commit and push:

```.term1
$ git add -A
$ git commit -m "Initial commit"
[main (root-commit) abcd123] Initial commit
 3 files changed, 12 insertions(+)
 create mode 100644 README.md
 create mode 100644 go.mod
 create mode 100644 main.go
$ git push -u origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
To https://gopher.live/{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}/mod1.git
 * [new branch]      main -> main
Branch 'main' set up to track remote branch 'main' from 'origin'.
```
{:data-command-src="Z2l0IGFkZCAtQQpnaXQgY29tbWl0IC1tICJJbml0aWFsIGNvbW1pdCIKZ2l0IHB1c2ggLXUgb3JpZ2luIG1haW4K"}

Use the module:

```.term1
$ mkdir /home/gopher/mod2
$ cd /home/gopher/mod2
$ go mod init mod.com
go: creating new go.mod: module mod.com
$ go get {% raw %}{{{.REPO1}}}{% endraw %}
go: downloading gopher.live/{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}/mod1 v0.0.0-20060102150405-abcde12345
go: gopher.live/{% raw %}{{{.GITEA_USERNAME}}}{% endraw %}/mod1 upgrade => v0.0.0-20060102150405-abcde12345
$ go run {% raw %}{{{.REPO1}}}{% endraw %}
Hello, world!
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDIKY2QgL2hvbWUvZ29waGVyL21vZDIKZ28gbW9kIGluaXQgbW9kLmNvbQpnbyBnZXQge3t7LlJFUE8xfX19CmdvIHJ1biB7e3suUkVQTzF9fX0K"}

You're done!

<script>let pageGuide="2020-09-01-basic-go-modules-example"; let pageLanguage="en"; let pageScenario="go115";</script>
