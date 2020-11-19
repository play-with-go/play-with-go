---
difficulty: Intermediate
excerpt: Options for repository structure with multiple major versions
guide: 2020-11-19-major-version-repository-structure
lang: en
layout: post
title: Repository structure with multiple major versions
---
### Introduction

In this guide you will:

* create a `{% raw %}{{{.BRANCH}}}{% endraw %}` module
* publish `{% raw %}{{{.BRANCH}}}{% endraw %}` `v1.0.0`
* make breaking changes to create `{% raw %}{{{.BRANCH}}}{% endraw %}/v2`, using the major version branch strategy
* publish `{% raw %}{{{.BRANCH}}}{% endraw %}` `v2.0.0`
* create a `{% raw %}{{{.SUBDIR}}}{% endraw %}` module
* publish `{% raw %}{{{.SUBDIR}}}{% endraw %}` `v1.0.0`
* make breaking changes to create `{% raw %}{{{.SUBDIR}}}{% endraw %}/v2`, using the major version subdirectory strategy
* publish `{% raw %}{{{.SUBDIR}}}{% endraw %}` `v2.0.0`
* create a `gopher` module that uses all the aforementioned modules

### Context

```.term1
$ go version
go version go1.15.5 linux/amd64
```
{:data-command-src="Z28gdmVyc2lvbgo="}

### Major branch strategy

```.term1
$ mkdir /home/gopher/branch
$ cd /home/gopher/branch
$ go mod init {% raw %}{{{.BRANCH}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.BRANCH}}}{% endraw %}
$ git init -q
$ git remote add origin https://{% raw %}{{{.BRANCH}}}{% endraw %}.git
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2JyYW5jaApjZCAvaG9tZS9nb3BoZXIvYnJhbmNoCmdvIG1vZCBpbml0IHt7ey5CUkFOQ0h9fX0KZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LkJSQU5DSH19fS5naXQK"}

<pre data-upload-path="L2hvbWUvZ29waGVyL2JyYW5jaA==" data-upload-src="YnJhbmNoLmdv:Ly8gL2hvbWUvZ29waGVyL2JyYW5jaC9icmFuY2guZ28KCnBhY2thZ2UgYnJhbmNoCgpjb25zdCBNZXNzYWdlID0gImJyYW5jaCB2MSIK" data-upload-term=".term1"><code class="language-go">// /home/gopher/branch/branch.go

package branch

const Message = &#34;branch v1&#34;
</code></pre>

```.term1
$ git add branch.go go.mod
$ git commit -q -m 'Initial commit of branch module'
$ git tag v1.0.0
$ git push -q origin main v1.0.0
remote: .. Processing 2 references        
remote: Processed 2 references in total        
```
{:data-command-src="Z2l0IGFkZCBicmFuY2guZ28gZ28ubW9kCmdpdCBjb21taXQgLXEgLW0gJ0luaXRpYWwgY29tbWl0IG9mIGJyYW5jaCBtb2R1bGUnCmdpdCB0YWcgdjEuMC4wCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluIHYxLjAuMAo="}

```.term1
$ git branch main.v1
$ git push -q origin main.v1
remote: 
remote: Create a new pull request for 'main.v1':        
remote:   https://{% raw %}{{{.BRANCH}}}{% endraw %}/compare/main...main.v1        
remote: 
remote: . Processing 1 references        
remote: Processed 1 references in total        
```
{:data-command-src="Z2l0IGJyYW5jaCBtYWluLnYxCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluLnYxCg=="}

<pre data-upload-path="L2hvbWUvZ29waGVyL2JyYW5jaA==" data-upload-src="Z28ubW9k:Ly8gL2hvbWUvZ29waGVyL2JyYW5jaC9nby5tb2QKCm1vZHVsZSB7e3suQlJBTkNIfX19L3YyCgpnbyAxLjE1Cg==" data-upload-term=".term1"><code class="language-mod">// /home/gopher/branch/go.mod

module {% raw %}{{{.BRANCH}}}{% endraw %}/v2

go 1.15
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2JyYW5jaA==" data-upload-src="YnJhbmNoLmdv:Ly8gL2hvbWUvZ29waGVyL2JyYW5jaC9icmFuY2guZ28KCnBhY2thZ2UgYnJhbmNoCgpjb25zdCBNZXNzYWdlID0gImJyYW5jaCB2MiIK" data-upload-term=".term1"><code class="language-go">// /home/gopher/branch/branch.go

package branch

const Message = &#34;branch v2&#34;
</code></pre>

```.term1
$ git add branch.go go.mod
$ git commit -q -m 'v2 commit of branch module'
$ git tag v2.0.0
$ git push -q origin main v2.0.0
remote: .. Processing 2 references        
remote: Processed 2 references in total        
```
{:data-command-src="Z2l0IGFkZCBicmFuY2guZ28gZ28ubW9kCmdpdCBjb21taXQgLXEgLW0gJ3YyIGNvbW1pdCBvZiBicmFuY2ggbW9kdWxlJwpnaXQgdGFnIHYyLjAuMApnaXQgcHVzaCAtcSBvcmlnaW4gbWFpbiB2Mi4wLjAK"}

### Major subdirectory strategy

```.term1
$ mkdir /home/gopher/subdir
$ cd /home/gopher/subdir
$ go mod init {% raw %}{{{.SUBDIR}}}{% endraw %}
go: creating new go.mod: module {% raw %}{{{.SUBDIR}}}{% endraw %}
$ git init -q
$ git remote add origin https://{% raw %}{{{.SUBDIR}}}{% endraw %}.git
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL3N1YmRpcgpjZCAvaG9tZS9nb3BoZXIvc3ViZGlyCmdvIG1vZCBpbml0IHt7ey5TVUJESVJ9fX0KZ2l0IGluaXQgLXEKZ2l0IHJlbW90ZSBhZGQgb3JpZ2luIGh0dHBzOi8ve3t7LlNVQkRJUn19fS5naXQK"}

<pre data-upload-path="L2hvbWUvZ29waGVyL3N1YmRpcg==" data-upload-src="c3ViZGlyLmdv:Ly8gL2hvbWUvZ29waGVyL3N1YmRpci9zdWJkaXIuZ28KCnBhY2thZ2Ugc3ViZGlyCgpjb25zdCBNZXNzYWdlID0gInN1YmRpciB2MSIK" data-upload-term=".term1"><code class="language-go">// /home/gopher/subdir/subdir.go

package subdir

const Message = &#34;subdir v1&#34;
</code></pre>

```.term1
$ git add subdir.go go.mod
$ git commit -q -m 'Initial commit of subdir module'
$ git tag v1.0.0
$ git push -q origin main v1.0.0
remote: .. Processing 2 references        
remote: Processed 2 references in total        
```
{:data-command-src="Z2l0IGFkZCBzdWJkaXIuZ28gZ28ubW9kCmdpdCBjb21taXQgLXEgLW0gJ0luaXRpYWwgY29tbWl0IG9mIHN1YmRpciBtb2R1bGUnCmdpdCB0YWcgdjEuMC4wCmdpdCBwdXNoIC1xIG9yaWdpbiBtYWluIHYxLjAuMAo="}

```.term1
$ mkdir v2
$ cp go.mod subdir.go v2
```
{:data-command-src="bWtkaXIgdjIKY3AgZ28ubW9kIHN1YmRpci5nbyB2Mgo="}

<pre data-upload-path="L2hvbWUvZ29waGVyL3N1YmRpci92Mg==" data-upload-src="Z28ubW9k:Ly8gL2hvbWUvZ29waGVyL3N1YmRpci92Mi9nby5tb2QKCm1vZHVsZSB7e3suU1VCRElSfX19L3YyCgpnbyAxLjE1Cg==" data-upload-term=".term1"><code class="language-mod">// /home/gopher/subdir/v2/go.mod

module {% raw %}{{{.SUBDIR}}}{% endraw %}/v2

go 1.15
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL3N1YmRpci92Mg==" data-upload-src="c3ViZGlyLmdv:Ly8gL2hvbWUvZ29waGVyL3N1YmRpci92Mi9zdWJkaXIuZ28KCnBhY2thZ2Ugc3ViZGlyCgpjb25zdCBNZXNzYWdlID0gInN1YmRpciB2MiIK" data-upload-term=".term1"><code class="language-go">// /home/gopher/subdir/v2/subdir.go

package subdir

const Message = &#34;subdir v2&#34;
</code></pre>

```.term1
$ git add v2
$ git commit -q -m 'v2 commit of subdir module'
$ git tag v2.0.0
$ git push -q origin main v2.0.0
remote: .. Processing 2 references        
remote: Processed 2 references in total        
```
{:data-command-src="Z2l0IGFkZCB2MgpnaXQgY29tbWl0IC1xIC1tICd2MiBjb21taXQgb2Ygc3ViZGlyIG1vZHVsZScKZ2l0IHRhZyB2Mi4wLjAKZ2l0IHB1c2ggLXEgb3JpZ2luIG1haW4gdjIuMC4wCg=="}

### Using `#allthemodules`: the `gopher` module

```.term1
$ mkdir /home/gopher/gopher
$ cd /home/gopher/gopher
$ go mod init gopher
go: creating new go.mod: module gopher
```
{:data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dvcGhlcgpjZCAvaG9tZS9nb3BoZXIvZ29waGVyCmdvIG1vZCBpbml0IGdvcGhlcgo="}

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcg==" data-upload-src="Z29waGVyLmdv:Ly8gL2hvbWUvZ29waGVyL2dvcGhlci9nb3BoZXIuZ28KCnBhY2thZ2UgbWFpbgoKaW1wb3J0ICgKCSJmbXQiCgoJYnJhbmNoICJ7e3suQlJBTkNIfX19IgoJYnJhbmNoX3YyICJ7e3suQlJBTkNIfX19L3YyIgoJc3ViZGlyICJ7e3suU1VCRElSfX19IgoJc3ViZGlyX3YyICJ7e3suU1VCRElSfX19L3YyIgopCgpmdW5jIG1haW4oKSB7CglmbXQuUHJpbnRmKCJicmFuY2guTWVzc2FnZTogJXZcbiIsIGJyYW5jaC5NZXNzYWdlKQoJZm10LlByaW50ZigiYnJhbmNoL3YyLk1lc3NhZ2U6ICV2XG4iLCBicmFuY2hfdjIuTWVzc2FnZSkKCWZtdC5QcmludGYoInN1YmRpci5NZXNzYWdlOiAldlxuIiwgc3ViZGlyLk1lc3NhZ2UpCglmbXQuUHJpbnRmKCJzdWJkaXIvdjIuTWVzc2FnZTogJXZcbiIsIHN1YmRpcl92Mi5NZXNzYWdlKQp9Cg==" data-upload-term=".term1"><code class="language-go">// /home/gopher/gopher/gopher.go

package main

import (
	&#34;fmt&#34;

	branch &#34;{% raw %}{{{.BRANCH}}}{% endraw %}&#34;
	branch_v2 &#34;{% raw %}{{{.BRANCH}}}{% endraw %}/v2&#34;
	subdir &#34;{% raw %}{{{.SUBDIR}}}{% endraw %}&#34;
	subdir_v2 &#34;{% raw %}{{{.SUBDIR}}}{% endraw %}/v2&#34;
)

func main() {
	fmt.Printf(&#34;branch.Message: %v\n&#34;, branch.Message)
	fmt.Printf(&#34;branch/v2.Message: %v\n&#34;, branch_v2.Message)
	fmt.Printf(&#34;subdir.Message: %v\n&#34;, subdir.Message)
	fmt.Printf(&#34;subdir/v2.Message: %v\n&#34;, subdir_v2.Message)
}
</code></pre>

```.term1
$ go get {% raw %}{{{.BRANCH}}}{% endraw %}@v1.0.0
go: downloading {% raw %}{{{.BRANCH}}}{% endraw %} v1.0.0
$ go get {% raw %}{{{.BRANCH}}}{% endraw %}/v2@v2.0.0
go: downloading {% raw %}{{{.BRANCH}}}{% endraw %}/v2 v2.0.0
$ go get {% raw %}{{{.SUBDIR}}}{% endraw %}@v1.0.0
go: downloading {% raw %}{{{.SUBDIR}}}{% endraw %} v1.0.0
$ go get {% raw %}{{{.SUBDIR}}}{% endraw %}/v2@v2.0.0
go: downloading {% raw %}{{{.SUBDIR}}}{% endraw %}/v2 v2.0.0
```
{:data-command-src="Z28gZ2V0IHt7ey5CUkFOQ0h9fX1AdjEuMC4wCmdvIGdldCB7e3suQlJBTkNIfX19L3YyQHYyLjAuMApnbyBnZXQge3t7LlNVQkRJUn19fUB2MS4wLjAKZ28gZ2V0IHt7ey5TVUJESVJ9fX0vdjJAdjIuMC4wCg=="}

```.term1
$ go run .
branch.Message: branch v1
branch/v2.Message: branch v2
subdir.Message: subdir v1
subdir/v2.Message: subdir v2
```
{:data-command-src="Z28gcnVuIC4K"}
<script>let pageGuide="2020-11-19-major-version-repository-structure"; let pageLanguage="en"; let pageScenario="go115";</script>
