---
guide: 2020-09-01-basic-go-modules-example
lang: en
layout: post
tags:
- modules
- tools
- versioning
title: A simple Go modules guide
---

Create a module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDEKY2QgL2hvbWUvZ29waGVyL21vZDEKZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlJFUE8xfX19LmdpdApnbyBtb2QgaW5pdCB7e3suUkVQTzF9fX0K"><code class="language-.term1">$ mkdir /home/gopher/mod1
$ cd /home/gopher/mod1
$ git init -q
$ git remote add origin https://&#123;&#123;&#123;.REPO1&#125;&#125;&#125;.git
$ go mod init &#123;&#123;&#123;.REPO1&#125;&#125;&#125;
go: creating new go.mod: module &#123;&#123;&#123;.REPO1&#125;&#125;&#125;
</code></pre>

Write a readme:

<pre data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="UkVBRE1FLm1k:IyMgYHt7ey5SRVBPMX19fWA=" data-upload-term=".term1"><code class="language-md">## `&#123;&#123;&#123;.REPO1&#125;&#125;&#125;`</code></pre>

Write a readme:

<pre data-upload-path="L2hvbWUvZ29waGVyL21vZDE=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgImZtdCIKCmZ1bmMgbWFpbigpIHsKCWZtdC5QcmludGxuKCJIZWxsbywgd29ybGQhIikKfQo=" data-upload-term=".term1"><code class="language-go">package main

import &#34;fmt&#34;

func main() &#123;
	fmt.Println(&#34;Hello, world!&#34;)
&#125;
</code></pre>

Commit and push:

<pre data-command-src="Z2l0IGFkZCBnby5tb2QgUkVBRE1FLm1kIG1haW4uZ28KZ2l0IGNvbW1pdCAtcSAtbSAiSW5pdGlhbCBjb21taXQiCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluCg=="><code class="language-.term1">$ git add go.mod README.md main.go
$ git commit -q -m &#34;Initial commit&#34;
$ git push -q origin main
remote: . Processing 1 references        
remote: Processed 1 references in total        
</code></pre>

Use the module:

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL21vZDIKY2QgL2hvbWUvZ29waGVyL21vZDIKZ28gbW9kIGluaXQgbW9kLmNvbQpnbyBnZXQge3t7LlJFUE8xfX19CmdvIHJ1biB7e3suUkVQTzF9fX0K"><code class="language-.term1">$ mkdir /home/gopher/mod2
$ cd /home/gopher/mod2
$ go mod init mod.com
go: creating new go.mod: module mod.com
$ go get &#123;&#123;&#123;.REPO1&#125;&#125;&#125;
go: downloading &#123;&#123;&#123;.REPO1&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
go: added &#123;&#123;&#123;.REPO1&#125;&#125;&#125; v0.0.0-20060102150405-abcedf12345
$ go run &#123;&#123;&#123;.REPO1&#125;&#125;&#125;
Hello, world!
</code></pre>

You're done!

<script>let pageGuide="2020-09-01-basic-go-modules-example"; let pageLanguage="en"; let pageScenario="go115";</script>
