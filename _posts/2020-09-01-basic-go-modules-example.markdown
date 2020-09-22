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
$ git remote add origin https://gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}.git
$ go mod init gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}
go: creating new go.mod: module gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDEKY2QgL2hvbWUvZ29waGVyL21vZDEKZ2l0IGluaXQKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8vZ29waGVyLmxpdmUve3t7LlJFUE8xfX19LmdpdApnbyBtb2QgaW5pdCBnb3BoZXIubGl2ZS97e3suUkVQTzF9fX0K"}

Write a readme:

```.term1
cat <<'EOD' > /home/gopher/mod1/README.md
## `gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}`
EOD
```

Write a readme:

```.term1
cat <<'EOD' > /home/gopher/mod1/main.go
package main

import "fmt"

func main() {
        fmt.Println("Hello, world!")
}
EOD
```

Commit and push:

```.term1
$ git add -A
$ git commit -m "Initial commit"
[main (root-commit) abcd123] Initial commit
 3 files changed, 11 insertions(+)
 create mode 100644 README.md
 create mode 100644 go.mod
 create mode 100644 main.go
$ git push -u origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
To https://gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}.git
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
$ go get gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}
go: downloading gopher.live/{% raw %}{{{.REPO1}}}{% endraw %} v0.0.0-20060102150405-abcde12345
go: gopher.live/{% raw %}{{{.REPO1}}}{% endraw %} upgrade => v0.0.0-20060102150405-abcde12345
$ go run gopher.live/{% raw %}{{{.REPO1}}}{% endraw %}
Hello, world!
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDIKY2QgL2hvbWUvZ29waGVyL21vZDIKZ28gbW9kIGluaXQgbW9kLmNvbQpnbyBnZXQgZ29waGVyLmxpdmUve3t7LlJFUE8xfX19CmdvIHJ1biBnb3BoZXIubGl2ZS97e3suUkVQTzF9fX0K"}

<script>let pageGuide="2020-09-01-basic-go-modules-example"; let pageLanguage="en"; let pageScenario="go115";</script>
