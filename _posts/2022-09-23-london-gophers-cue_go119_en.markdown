---
guide: 2022-09-23-london-gophers-cue
lang: en
layout: post
title: Creating a shell script
---

<pre data-command-src="Z28gdmVyc2lvbgpjdWUgdmVyc2lvbgo="><code class="language-.term1">$ go version
go version go1.19.1 linux/amd64
$ cue version
cue version v0.4.4-0.20220923112746-fe50dff0dce8

       -compiler gc
     CGO_ENABLED 1
          GOARCH amd64
            GOOS linux
</code></pre>

<pre data-command-src="bWtkaXIgZGVtbwpjZCBkZW1vCmdvIG1vZCBpbml0IGV4YW1wbGUuY29tL2RlbW8K"><code class="language-.term1">$ mkdir demo
$ cd demo
$ go mod init example.com/demo
go: creating new go.mod: module example.com/demo
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImVuY29kaW5nL2pzb24iCgkiZm10IgoJImxvZyIKCSJvcyIKCSJwYXRoL2ZpbGVwYXRoIgopCgp0eXBlIENvbmZpZyBzdHJ1Y3QgewoJUHJvZ3JhbXMgbWFwW3N0cmluZ11Qcm9ncmFtIGBqc29uOiJwcm9ncmFtcyJgCn0KCnR5cGUgUHJvZ3JhbSBzdHJ1Y3QgewoJUGF0aCAgICAgICAgIHN0cmluZyAgIGBqc29uOiJwYXRoImAKCUFyZ3MgICAgICAgICBbXXN0cmluZyBganNvbjoiYXJncyJgCglEZXNjcmlwdGlvbiAgc3RyaW5nICAgYGpzb246ImRlc2NyaXB0aW9uImAKCVJldHJpZXMgICAgICBpbnQgICAgICBganNvbjoicmV0cmllcyJgCglJZ25vcmVFcnJvcnMgYm9vbCAgICAgYGpzb246Imlnbm9yZUVycm9ycyJgCglEaXJlY3RvcnkgICAgc3RyaW5nICAgYGpzb246ImRpcmVjdG9yeSJgCn0KCmZ1bmMgbWFpbigpIHsKCS8vIFVzZSBhIGZha2UgIiRIT01FIiBmb3IgdGhlIHB1cnBvc2VzIG9mIHRoaXMgZGVtbwoJY2ZwYXRoIDo9IGZpbGVwYXRoLkpvaW4oImhvbWUiLCAiLmNvbmZpZyIsICJkZW1vIiwgImNvbmZpZy5qc29uIikKCgljZiwgZXJyIDo9IG9zLlJlYWRGaWxlKGNmcGF0aCkKCWlmIGVyciAhPSBuaWwgewoJCWxvZy5GYXRhbChlcnIpCgl9CgoJdmFyIGNvbmYgQ29uZmlnCglpZiBlcnIgOj0ganNvbi5Vbm1hcnNoYWwoY2YsICZjb25mKTsgZXJyICE9IG5pbCB7CgkJbG9nLkZhdGFsKGVycikKCX0KCglvdXQsIGVyciA6PSBqc29uLk1hcnNoYWxJbmRlbnQoY29uZiwgIiIsICIgICIpCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoJZm10LlByaW50ZigiJXNcbiIsIG91dCkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;encoding/json&#34;
	&#34;fmt&#34;
	&#34;log&#34;
	&#34;os&#34;
	&#34;path/filepath&#34;
)

type Config struct &#123;
	Programs map[string]Program `json:&#34;programs&#34;`
&#125;

type Program struct &#123;
	Path         string   `json:&#34;path&#34;`
	Args         []string `json:&#34;args&#34;`
	Description  string   `json:&#34;description&#34;`
	Retries      int      `json:&#34;retries&#34;`
	IgnoreErrors bool     `json:&#34;ignoreErrors&#34;`
	Directory    string   `json:&#34;directory&#34;`
&#125;

func main() &#123;
	// Use a fake &#34;$HOME&#34; for the purposes of this demo
	cfpath := filepath.Join(&#34;home&#34;, &#34;.config&#34;, &#34;demo&#34;, &#34;config.json&#34;)

	cf, err := os.ReadFile(cfpath)
	if err != nil &#123;
		log.Fatal(err)
	&#125;

	var conf Config
	if err := json.Unmarshal(cf, &amp;conf); err != nil &#123;
		log.Fatal(err)
	&#125;

	out, err := json.MarshalIndent(conf, &#34;&#34;, &#34;  &#34;)
	if err != nil &#123;
		log.Fatal(err)
	&#125;
	fmt.Printf(&#34;%s\n&#34;, out)
&#125;
</code></pre>

<pre data-command-src="bWtkaXIgLXAgL2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8K"><code class="language-.term1">$ mkdir -p /home/gopher/demo/home/.config/demo
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8=" data-upload-src="Y29uZmlnLmpzb24=:ewoJICJwcm9ncmFtcyI6IHsKCQkgICJzZXJ2aWNlMSI6IHsKCQkJCSJwYXRoIjogIi9wYXRoL3RvL3NlcnZpY2UxIiwKCQkJCSJkZXNjcmlwdGlvbiI6ICJzZXJ2aWNlMSBpcyBhIHNwZWNpYWwgc2VydmljZVxuZm9yIHNwZWNpYWwgdGhpbmdzIiwKCQkJCSJhcmdzIjogWwoJCQkJCSAiaGVsbG8iLAoJCQkJCSAid29ybGQiCgkJCQldLAoJCQkJImRpcmVjdG9yeSI6ICIvdG1wIiwKCQkJCSJpZ25vcmVFcnJvcnMiOiB0cnVlCgkJICB9LAoJCSAgInNlcnZpY2UyIjogewoJCQkJInBhdGgiOiAiL3BhdGgvdG8vc2VydmljZTIiLAoJCQkJImRlc2NyaXB0aW9uIjogInNlcnZpY2UyIGlzIGEgc3BlY2lhbCBzZXJ2aWNlXG5mb3Igc3BlY2lhbCB0aGluZ3MiLAoJCQkJImFyZ3MiOiBbCgkJCQkJICJoZWxsbyIsCgkJCQkJICJ3b3JsZCIKCQkJCV0sCgkJCQkiZGlyZWN0b3J5IjogIi9ob21lL2N1ZWNrb28iCgkJICB9LAoJCSAgInNlcnZpY2UzIjogewoJCQkJInBhdGgiOiAiL3BhdGgvdG8vc2VydmljZTMiLAoJCQkJImRlc2NyaXB0aW9uIjogInNlcnZpY2UzIGlzIGEgc3BlY2lhbCBzZXJ2aWNlXG5mb3Igc3BlY2lhbCB0aGluZ3MiLAoJCQkJImRpcmVjdG9yeSI6ICIvaG9tZS9jdWVja29vIgoJCSAgfQoJIH0KfQ==" data-upload-term=".term1"><code class="language-json">&#123;
	 &#34;programs&#34;: &#123;
		  &#34;service1&#34;: &#123;
				&#34;path&#34;: &#34;/path/to/service1&#34;,
				&#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
				&#34;args&#34;: [
					 &#34;hello&#34;,
					 &#34;world&#34;
				],
				&#34;directory&#34;: &#34;/tmp&#34;,
				&#34;ignoreErrors&#34;: true
		  &#125;,
		  &#34;service2&#34;: &#123;
				&#34;path&#34;: &#34;/path/to/service2&#34;,
				&#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
				&#34;args&#34;: [
					 &#34;hello&#34;,
					 &#34;world&#34;
				],
				&#34;directory&#34;: &#34;/home/cueckoo&#34;
		  &#125;,
		  &#34;service3&#34;: &#123;
				&#34;path&#34;: &#34;/path/to/service3&#34;,
				&#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
				&#34;directory&#34;: &#34;/home/cueckoo&#34;
		  &#125;
	 &#125;
&#125;</code></pre>

<pre data-command-src="Y2F0IGdvLm1vZApnbyBydW4gLgo="><code class="language-.term1">$ cat go.mod
module example.com/demo

go 1.19
$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-command-src="Y3VlIGltcG9ydCAuL2hvbWUvLmNvbmZpZy9kZW1vL2NvbmZpZy5qc29uCg=="><code class="language-.term1">$ cue import ./home/.config/demo/config.json
</code></pre>

<pre data-command-src="Y2F0IC4vaG9tZS8uY29uZmlnL2RlbW8vY29uZmlnLmN1ZQo="><code class="language-.term1">$ cat ./home/.config/demo/config.cue
programs: &#123;
	service1: &#123;
		path: &#34;/path/to/service1&#34;
		description: &#34;&#34;&#34;
			service1 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory:    &#34;/tmp&#34;
		ignoreErrors: true
	&#125;
	service2: &#123;
		path: &#34;/path/to/service2&#34;
		description: &#34;&#34;&#34;
			service2 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory: &#34;/home/cueckoo&#34;
	&#125;
	service3: &#123;
		path: &#34;/path/to/service3&#34;
		description: &#34;&#34;&#34;
			service3 is a special service
			for special things
			&#34;&#34;&#34;
		directory: &#34;/home/cueckoo&#34;
	&#125;
&#125;
</code></pre>

<pre data-command-src="Y3VlIGV4cG9ydCAuL2hvbWUvLmNvbmZpZy9kZW1vL2NvbmZpZy5jdWUK"><code class="language-.term1">$ cue export ./home/.config/demo/config.cue
&#123;
    &#34;programs&#34;: &#123;
        &#34;service1&#34;: &#123;
            &#34;path&#34;: &#34;/path/to/service1&#34;,
            &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
            &#34;args&#34;: [
                &#34;hello&#34;,
                &#34;world&#34;
            ],
            &#34;directory&#34;: &#34;/tmp&#34;,
            &#34;ignoreErrors&#34;: true
        &#125;,
        &#34;service2&#34;: &#123;
            &#34;path&#34;: &#34;/path/to/service2&#34;,
            &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
            &#34;args&#34;: [
                &#34;hello&#34;,
                &#34;world&#34;
            ],
            &#34;directory&#34;: &#34;/home/cueckoo&#34;
        &#125;,
        &#34;service3&#34;: &#123;
            &#34;path&#34;: &#34;/path/to/service3&#34;,
            &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
            &#34;directory&#34;: &#34;/home/cueckoo&#34;
        &#125;
    &#125;
&#125;
</code></pre>

<pre data-command-src="bXYgLi9ob21lLy5jb25maWcvZGVtby9jb25maWcuanNvbiAuL2hvbWUvLmNvbmZpZy9kZW1vL2NvbmZpZy5qc29uLmNvcHkKY3VlIGV4cG9ydCAtbyAuL2hvbWUvLmNvbmZpZy9kZW1vL2NvbmZpZy5qc29uIC4vaG9tZS8uY29uZmlnL2RlbW8vY29uZmlnLmN1ZQpkaWZmIC13dSAuL2hvbWUvLmNvbmZpZy9kZW1vL2NvbmZpZy5qc29uIC4vaG9tZS8uY29uZmlnL2RlbW8vY29uZmlnLmpzb24uY29weQo="><code class="language-.term1">$ mv ./home/.config/demo/config.json ./home/.config/demo/config.json.copy
$ cue export -o ./home/.config/demo/config.json ./home/.config/demo/config.cue
$ diff -wu ./home/.config/demo/config.json ./home/.config/demo/config.json.copy
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImVuY29kaW5nL2pzb24iCgkiZm10IgoJImxvZyIKCSJwYXRoL2ZpbGVwYXRoIgoKCSJnaXRodWIuY29tL2N1ZS1leHAvY3VlY29uZmlnIgopCgp0eXBlIENvbmZpZyBzdHJ1Y3QgewoJUHJvZ3JhbXMgbWFwW3N0cmluZ11Qcm9ncmFtIGBqc29uOiJwcm9ncmFtcyJgCn0KCnR5cGUgUHJvZ3JhbSBzdHJ1Y3QgewoJUGF0aCAgICAgICAgIHN0cmluZyAgIGBqc29uOiJwYXRoImAKCUFyZ3MgICAgICAgICBbXXN0cmluZyBganNvbjoiYXJncyJgCglEZXNjcmlwdGlvbiAgc3RyaW5nICAgYGpzb246ImRlc2NyaXB0aW9uImAKCVJldHJpZXMgICAgICBpbnQgICAgICBganNvbjoicmV0cmllcyJgCglJZ25vcmVFcnJvcnMgYm9vbCAgICAgYGpzb246Imlnbm9yZUVycm9ycyJgCglEaXJlY3RvcnkgICAgc3RyaW5nICAgYGpzb246ImRpcmVjdG9yeSJgCn0KCmZ1bmMgbWFpbigpIHsKCS8vIFVzZSBhIGZha2UgIiRIT01FIiBmb3IgdGhlIHB1cnBvc2VzIG9mIHRoaXMgZGVtbwoJY2ZwYXRoIDo9IGZpbGVwYXRoLkpvaW4oImhvbWUiLCAiLmNvbmZpZyIsICJkZW1vIiwgImNvbmZpZy5jdWUiKQoKCXZhciBjb25mIENvbmZpZwoJaWYgZXJyIDo9IGN1ZWNvbmZpZy5Mb2FkKGNmcGF0aCwgbmlsLCBuaWwsIG5pbCwgJmNvbmYpOyBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoKCW91dCwgZXJyIDo9IGpzb24uTWFyc2hhbEluZGVudChjb25mLCAiIiwgIiAgIikKCWlmIGVyciAhPSBuaWwgewoJCWxvZy5GYXRhbChlcnIpCgl9CglmbXQuUHJpbnRmKCIlc1xuIiwgb3V0KQp9Cg==" data-upload-term=".term1"><code class="language-go">package main

import (
	&#34;encoding/json&#34;
	&#34;fmt&#34;
	&#34;log&#34;
	&#34;path/filepath&#34;

	&#34;github.com/cue-exp/cueconfig&#34;
)

type Config struct &#123;
	Programs map[string]Program `json:&#34;programs&#34;`
&#125;

type Program struct &#123;
	Path         string   `json:&#34;path&#34;`
	Args         []string `json:&#34;args&#34;`
	Description  string   `json:&#34;description&#34;`
	Retries      int      `json:&#34;retries&#34;`
	IgnoreErrors bool     `json:&#34;ignoreErrors&#34;`
	Directory    string   `json:&#34;directory&#34;`
&#125;

func main() &#123;
	// Use a fake &#34;$HOME&#34; for the purposes of this demo
	cfpath := filepath.Join(&#34;home&#34;, &#34;.config&#34;, &#34;demo&#34;, &#34;config.cue&#34;)

	var conf Config
	if err := cueconfig.Load(cfpath, nil, nil, nil, &amp;conf); err != nil &#123;
		log.Fatal(err)
	&#125;

	out, err := json.MarshalIndent(conf, &#34;&#34;, &#34;  &#34;)
	if err != nil &#123;
		log.Fatal(err)
	&#125;
	fmt.Printf(&#34;%s\n&#34;, out)
&#125;
</code></pre>

<pre data-command-src="Z28gZ2V0IGdpdGh1Yi5jb20vY3VlLWV4cC9jdWVjb25maWdAdjAuMC4xCmdvIG1vZCB0aWR5Cg=="><code class="language-.term1">$ go get github.com/cue-exp/cueconfig@v0.0.1
go: downloading github.com/cue-exp/cueconfig v0.0.1
go: downloading cuelang.org/go v0.4.3
go: downloading github.com/cockroachdb/apd/v2 v2.0.1
go: downloading golang.org/x/net v0.0.0-20200226121028-0de0cce0169b
go: downloading github.com/emicklei/proto v1.6.15
go: downloading github.com/protocolbuffers/txtpbfmt v0.0.0-20201118171849-f6a6b3f636fc
go: downloading gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b
go: added cuelang.org/go v0.4.3
go: added github.com/cockroachdb/apd/v2 v2.0.1
go: added github.com/cue-exp/cueconfig v0.0.1
go: added github.com/emicklei/proto v1.6.15
go: added github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b
go: added github.com/google/uuid v1.2.0
go: added github.com/mpvl/unique v0.0.0-20150818121801-cbe035fff7de
go: added github.com/pkg/errors v0.8.1
go: added github.com/protocolbuffers/txtpbfmt v0.0.0-20201118171849-f6a6b3f636fc
go: added golang.org/x/net v0.0.0-20200226121028-0de0cce0169b
go: added golang.org/x/text v0.3.7
go: added gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b
$ go mod tidy
go: downloading github.com/rogpeppe/go-internal v1.9.0
go: downloading github.com/google/go-cmp v0.4.0
go: downloading github.com/stretchr/testify v1.2.2
go: downloading github.com/kylelemons/godebug v1.1.0
go: downloading github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e
go: downloading github.com/cockroachdb/apd v1.1.0
go: downloading github.com/lib/pq v1.0.0
go: downloading github.com/davecgh/go-spew v1.1.1
go: downloading github.com/pmezard/go-difflib v1.0.0
go: downloading golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543
go: downloading github.com/kr/pretty v0.1.0
go: downloading golang.org/x/tools v0.0.0-20200612220849-54c614fe050c
go: downloading github.com/kr/text v0.1.0
go: downloading gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="c2NoZW1hLmN1ZQ==:cGFja2FnZSBtYWluCgpwcm9ncmFtczogW3N0cmluZ106ICNQcm9ncmFtCgojUHJvZ3JhbTogewoJcGF0aDogc3RyaW5nCglhcmdzPzogWy4uLnN0cmluZ10KCWRlc2NyaXB0aW9uOiAgIHN0cmluZwoJcmV0cmllcz86ICAgICAgaW50CglpZ25vcmVFcnJvcnM/OiBib29sCglkaXJlY3Rvcnk/OiAgICBzdHJpbmcKfQo=" data-upload-term=".term1"><code class="language-cue">package main

programs: [string]: #Program

#Program: &#123;
	path: string
	args?: [...string]
	description:   string
	retries?:      int
	ignoreErrors?: bool
	directory?:    string
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJXyAiZW1iZWQiCgkiZW5jb2RpbmcvanNvbiIKCSJmbXQiCgkibG9nIgoJInBhdGgvZmlsZXBhdGgiCgoJImdpdGh1Yi5jb20vY3VlLWV4cC9jdWVjb25maWciCikKCnR5cGUgQ29uZmlnIHN0cnVjdCB7CglQcm9ncmFtcyBtYXBbc3RyaW5nXVByb2dyYW0gYGpzb246InByb2dyYW1zImAKfQoKdHlwZSBQcm9ncmFtIHN0cnVjdCB7CglQYXRoICAgICAgICAgc3RyaW5nICAgYGpzb246InBhdGgiYAoJQXJncyAgICAgICAgIFtdc3RyaW5nIGBqc29uOiJhcmdzImAKCURlc2NyaXB0aW9uICBzdHJpbmcgICBganNvbjoiZGVzY3JpcHRpb24iYAoJUmV0cmllcyAgICAgIGludCAgICAgIGBqc29uOiJyZXRyaWVzImAKCUlnbm9yZUVycm9ycyBib29sICAgICBganNvbjoiaWdub3JlRXJyb3JzImAKCURpcmVjdG9yeSAgICBzdHJpbmcgICBganNvbjoiZGlyZWN0b3J5ImAKfQoKdmFyICgKCS8vZ286ZW1iZWQgc2NoZW1hLmN1ZQoJc2NoZW1hIFtdYnl0ZQopCgpmdW5jIG1haW4oKSB7CgkvLyBVc2UgYSBmYWtlICIkSE9NRSIgZm9yIHRoZSBwdXJwb3NlcyBvZiB0aGlzIGRlbW8KCWNmcGF0aCA6PSBmaWxlcGF0aC5Kb2luKCJob21lIiwgIi5jb25maWciLCAiZGVtbyIsICJjb25maWcuY3VlIikKCgl2YXIgY29uZiBDb25maWcKCWlmIGVyciA6PSBjdWVjb25maWcuTG9hZChjZnBhdGgsIHNjaGVtYSwgbmlsLCBuaWwsICZjb25mKTsgZXJyICE9IG5pbCB7CgkJbG9nLkZhdGFsKGVycikKCX0KCglvdXQsIGVyciA6PSBqc29uLk1hcnNoYWxJbmRlbnQoY29uZiwgIiIsICIgICIpCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoJZm10LlByaW50ZigiJXNcbiIsIG91dCkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	_ &#34;embed&#34;
	&#34;encoding/json&#34;
	&#34;fmt&#34;
	&#34;log&#34;
	&#34;path/filepath&#34;

	&#34;github.com/cue-exp/cueconfig&#34;
)

type Config struct &#123;
	Programs map[string]Program `json:&#34;programs&#34;`
&#125;

type Program struct &#123;
	Path         string   `json:&#34;path&#34;`
	Args         []string `json:&#34;args&#34;`
	Description  string   `json:&#34;description&#34;`
	Retries      int      `json:&#34;retries&#34;`
	IgnoreErrors bool     `json:&#34;ignoreErrors&#34;`
	Directory    string   `json:&#34;directory&#34;`
&#125;

var (
	//go:embed schema.cue
	schema []byte
)

func main() &#123;
	// Use a fake &#34;$HOME&#34; for the purposes of this demo
	cfpath := filepath.Join(&#34;home&#34;, &#34;.config&#34;, &#34;demo&#34;, &#34;config.cue&#34;)

	var conf Config
	if err := cueconfig.Load(cfpath, schema, nil, nil, &amp;conf); err != nil &#123;
		log.Fatal(err)
	&#125;

	out, err := json.MarshalIndent(conf, &#34;&#34;, &#34;  &#34;)
	if err != nil &#123;
		log.Fatal(err)
	&#125;
	fmt.Printf(&#34;%s\n&#34;, out)
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8=" data-upload-src="Y29uZmlnLmN1ZQ==:cHJvZ3JhbXM6IHsKCXNlcnZpY2UxOiB7CgkJcGF0aDogIi9wYXRoL3RvL3NlcnZpY2UxIgoJCWRlc2NyaXB0aW9uOiAiIiIKCQkJc2VydmljZTEgaXMgYSBzcGVjaWFsIHNlcnZpY2UKCQkJZm9yIHNwZWNpYWwgdGhpbmdzCgkJCSIiIgoJCWFyZ3M6IFsKCQkJImhlbGxvIiwKCQkJIndvcmxkIiwKCQldCgkJZGlyZWN0b3J5OiAgICAiL3RtcCIKCQlpZ25vcmVFcnJvcnM6IHRydWUKCQlibGFoOiAgICAgICAgICJzb21ldGhpbmciCgl9CglzZXJ2aWNlMjogewoJCXBhdGg6ICIvcGF0aC90by9zZXJ2aWNlMiIKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UyIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCQlhcmdzOiBbCgkJCSJoZWxsbyIsCgkJCSJ3b3JsZCIsCgkJXQoJCWRpcmVjdG9yeTogIi9ob21lL2N1ZWNrb28iCgl9CglzZXJ2aWNlMzogewoJCXBhdGg6ICIvcGF0aC90by9zZXJ2aWNlMyIKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UzIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCQlkaXJlY3Rvcnk6ICIvaG9tZS9jdWVja29vIgoJfQp9Cg==" data-upload-term=".term1"><code class="language-cue">programs: &#123;
	service1: &#123;
		path: &#34;/path/to/service1&#34;
		description: &#34;&#34;&#34;
			service1 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory:    &#34;/tmp&#34;
		ignoreErrors: true
		blah:         &#34;something&#34;
	&#125;
	service2: &#123;
		path: &#34;/path/to/service2&#34;
		description: &#34;&#34;&#34;
			service2 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory: &#34;/home/cueckoo&#34;
	&#125;
	service3: &#123;
		path: &#34;/path/to/service3&#34;
		description: &#34;&#34;&#34;
			service3 is a special service
			for special things
			&#34;&#34;&#34;
		directory: &#34;/home/cueckoo&#34;
	&#125;
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
main.go:37: error in configuration: programs.service1: field not allowed: blah:
    $schema.cue:3:21
    $schema.cue:5:11
    /home/gopher/demo/home/.config/demo/config.cue:14:3
exit status 1
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8=" data-upload-src="Y29uZmlnLmN1ZQ==:cHJvZ3JhbXM6IHsKCXNlcnZpY2UxOiB7CgkJcGF0aDogIi9wYXRoL3RvL3NlcnZpY2UxIgoJCWRlc2NyaXB0aW9uOiAiIiIKCQkJc2VydmljZTEgaXMgYSBzcGVjaWFsIHNlcnZpY2UKCQkJZm9yIHNwZWNpYWwgdGhpbmdzCgkJCSIiIgoJCWFyZ3M6IFsKCQkJImhlbGxvIiwKCQkJIndvcmxkIiwKCQldCgkJZGlyZWN0b3J5OiAgICAiL3RtcCIKCQlpZ25vcmVFcnJvcnM6IHRydWUKCX0KCXNlcnZpY2UyOiB7CgkJcGF0aDogIi9wYXRoL3RvL3NlcnZpY2UyIgoJCWRlc2NyaXB0aW9uOiAiIiIKCQkJc2VydmljZTIgaXMgYSBzcGVjaWFsIHNlcnZpY2UKCQkJZm9yIHNwZWNpYWwgdGhpbmdzCgkJCSIiIgoJCWFyZ3M6IFsKCQkJImhlbGxvIiwKCQkJIndvcmxkIiwKCQldCgkJZGlyZWN0b3J5OiAiL2hvbWUvY3VlY2tvbyIKCX0KCXNlcnZpY2UzOiB7CgkJcGF0aDogIi9wYXRoL3RvL3NlcnZpY2UzIgoJCWRlc2NyaXB0aW9uOiAiIiIKCQkJc2VydmljZTMgaXMgYSBzcGVjaWFsIHNlcnZpY2UKCQkJZm9yIHNwZWNpYWwgdGhpbmdzCgkJCSIiIgoJCWRpcmVjdG9yeTogIi9ob21lL2N1ZWNrb28iCgl9Cn0K" data-upload-term=".term1"><code class="language-cue">programs: &#123;
	service1: &#123;
		path: &#34;/path/to/service1&#34;
		description: &#34;&#34;&#34;
			service1 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory:    &#34;/tmp&#34;
		ignoreErrors: true
	&#125;
	service2: &#123;
		path: &#34;/path/to/service2&#34;
		description: &#34;&#34;&#34;
			service2 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory: &#34;/home/cueckoo&#34;
	&#125;
	service3: &#123;
		path: &#34;/path/to/service3&#34;
		description: &#34;&#34;&#34;
			service3 is a special service
			for special things
			&#34;&#34;&#34;
		directory: &#34;/home/cueckoo&#34;
	&#125;
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8=" data-upload-src="Y29uZmlnLmN1ZQ==:aW1wb3J0ICJzdHJpbmdzIgoKcHJvZ3JhbXM6IFtfbmFtZT1zdHJpbmddOiB7CglkaXJlY3Rvcnk6ICAgKiIvaG9tZS9jdWVja29vIiB8IF8KCXBhdGg6ICAgICAgICAqIi9wYXRoL3RvL1woX25hbWUpIiB8IF8KCWRlc2NyaXB0aW9uOiBzdHJpbmdzLkhhc1ByZWZpeChfbmFtZSkKfQoKcHJvZ3JhbXM6IHsKCXNlcnZpY2UxOiB7CgkJZGVzY3JpcHRpb246ICIiIgoJCQlzZXJ2aWNlMSBpcyBhIHNwZWNpYWwgc2VydmljZQoJCQlmb3Igc3BlY2lhbCB0aGluZ3MKCQkJIiIiCgkJYXJnczogWwoJCQkiaGVsbG8iLAoJCQkid29ybGQiLAoJCV0KCQlkaXJlY3Rvcnk6ICAgICIvdG1wIgoJCWlnbm9yZUVycm9yczogdHJ1ZQoJfQoJc2VydmljZTI6IHsKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UyIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCQlhcmdzOiBzZXJ2aWNlMS5hcmdzLAoJfQoJc2VydmljZTM6IHsKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UzIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCX0KfQo=" data-upload-term=".term1"><code class="language-cue">import &#34;strings&#34;

programs: [_name=string]: &#123;
	directory:   *&#34;/home/cueckoo&#34; | _
	path:        *&#34;/path/to/\(_name)&#34; | _
	description: strings.HasPrefix(_name)
&#125;

programs: &#123;
	service1: &#123;
		description: &#34;&#34;&#34;
			service1 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory:    &#34;/tmp&#34;
		ignoreErrors: true
	&#125;
	service2: &#123;
		description: &#34;&#34;&#34;
			service2 is a special service
			for special things
			&#34;&#34;&#34;
		args: service1.args,
	&#125;
	service3: &#123;
		description: &#34;&#34;&#34;
			service3 is a special service
			for special things
			&#34;&#34;&#34;
	&#125;
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 0,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="ZGVmYXVsdHMuY3Vl:cGFja2FnZSBtYWluCgpwcm9ncmFtczogW3N0cmluZ106IHJldHJpZXM6ICozIHwgXwo=" data-upload-term=".term1"><code class="language-cue">package main

programs: [string]: retries: *3 | _
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJXyAiZW1iZWQiCgkiZW5jb2RpbmcvanNvbiIKCSJmbXQiCgkibG9nIgoJInBhdGgvZmlsZXBhdGgiCgoJImdpdGh1Yi5jb20vY3VlLWV4cC9jdWVjb25maWciCikKCnR5cGUgQ29uZmlnIHN0cnVjdCB7CglQcm9ncmFtcyBtYXBbc3RyaW5nXVByb2dyYW0gYGpzb246InByb2dyYW1zImAKfQoKdHlwZSBQcm9ncmFtIHN0cnVjdCB7CglQYXRoICAgICAgICAgc3RyaW5nICAgYGpzb246InBhdGgiYAoJQXJncyAgICAgICAgIFtdc3RyaW5nIGBqc29uOiJhcmdzImAKCURlc2NyaXB0aW9uICBzdHJpbmcgICBganNvbjoiZGVzY3JpcHRpb24iYAoJUmV0cmllcyAgICAgIGludCAgICAgIGBqc29uOiJyZXRyaWVzImAKCUlnbm9yZUVycm9ycyBib29sICAgICBganNvbjoiaWdub3JlRXJyb3JzImAKCURpcmVjdG9yeSAgICBzdHJpbmcgICBganNvbjoiZGlyZWN0b3J5ImAKfQoKdmFyICgKCS8vZ286ZW1iZWQgc2NoZW1hLmN1ZQoJc2NoZW1hIFtdYnl0ZQoKCS8vZ286ZW1iZWQgZGVmYXVsdHMuY3VlCglkZWZhdWx0cyBbXWJ5dGUKKQoKZnVuYyBtYWluKCkgewoJLy8gVXNlIGEgZmFrZSAiJEhPTUUiIGZvciB0aGUgcHVycG9zZXMgb2YgdGhpcyBkZW1vCgljZnBhdGggOj0gZmlsZXBhdGguSm9pbigiaG9tZSIsICIuY29uZmlnIiwgImRlbW8iLCAiY29uZmlnLmN1ZSIpCgoJdmFyIGNvbmYgQ29uZmlnCglpZiBlcnIgOj0gY3VlY29uZmlnLkxvYWQoY2ZwYXRoLCBzY2hlbWEsIGRlZmF1bHRzLCBuaWwsICZjb25mKTsgZXJyICE9IG5pbCB7CgkJbG9nLkZhdGFsKGVycikKCX0KCglvdXQsIGVyciA6PSBqc29uLk1hcnNoYWxJbmRlbnQoY29uZiwgIiIsICIgICIpCglpZiBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoJZm10LlByaW50ZigiJXNcbiIsIG91dCkKfQo=" data-upload-term=".term1"><code class="language-go">package main

import (
	_ &#34;embed&#34;
	&#34;encoding/json&#34;
	&#34;fmt&#34;
	&#34;log&#34;
	&#34;path/filepath&#34;

	&#34;github.com/cue-exp/cueconfig&#34;
)

type Config struct &#123;
	Programs map[string]Program `json:&#34;programs&#34;`
&#125;

type Program struct &#123;
	Path         string   `json:&#34;path&#34;`
	Args         []string `json:&#34;args&#34;`
	Description  string   `json:&#34;description&#34;`
	Retries      int      `json:&#34;retries&#34;`
	IgnoreErrors bool     `json:&#34;ignoreErrors&#34;`
	Directory    string   `json:&#34;directory&#34;`
&#125;

var (
	//go:embed schema.cue
	schema []byte

	//go:embed defaults.cue
	defaults []byte
)

func main() &#123;
	// Use a fake &#34;$HOME&#34; for the purposes of this demo
	cfpath := filepath.Join(&#34;home&#34;, &#34;.config&#34;, &#34;demo&#34;, &#34;config.cue&#34;)

	var conf Config
	if err := cueconfig.Load(cfpath, schema, defaults, nil, &amp;conf); err != nil &#123;
		log.Fatal(err)
	&#125;

	out, err := json.MarshalIndent(conf, &#34;&#34;, &#34;  &#34;)
	if err != nil &#123;
		log.Fatal(err)
	&#125;
	fmt.Printf(&#34;%s\n&#34;, out)
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/home/cueckoo&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="bWFpbi5nbw==:cGFja2FnZSBtYWluCgppbXBvcnQgKAoJXyAiZW1iZWQiCgkiZW5jb2RpbmcvanNvbiIKCSJmbXQiCgkibG9nIgoJInBhdGgvZmlsZXBhdGgiCgoJImdpdGh1Yi5jb20vY3VlLWV4cC9jdWVjb25maWciCikKCnR5cGUgQ29uZmlnIHN0cnVjdCB7CglQcm9ncmFtcyBtYXBbc3RyaW5nXVByb2dyYW0gYGpzb246InByb2dyYW1zImAKfQoKdHlwZSBQcm9ncmFtIHN0cnVjdCB7CglQYXRoICAgICAgICAgc3RyaW5nICAgYGpzb246InBhdGgiYAoJQXJncyAgICAgICAgIFtdc3RyaW5nIGBqc29uOiJhcmdzImAKCURlc2NyaXB0aW9uICBzdHJpbmcgICBganNvbjoiZGVzY3JpcHRpb24iYAoJUmV0cmllcyAgICAgIGludCAgICAgIGBqc29uOiJyZXRyaWVzImAKCUlnbm9yZUVycm9ycyBib29sICAgICBganNvbjoiaWdub3JlRXJyb3JzImAKCURpcmVjdG9yeSAgICBzdHJpbmcgICBganNvbjoiZGlyZWN0b3J5ImAKfQoKdmFyICgKCS8vZ286ZW1iZWQgc2NoZW1hLmN1ZQoJc2NoZW1hIFtdYnl0ZQoKCS8vZ286ZW1iZWQgZGVmYXVsdHMuY3VlCglkZWZhdWx0cyBbXWJ5dGUKKQoKZnVuYyBtYWluKCkgewoJLy8gVXNlIGEgZmFrZSAiJEhPTUUiIGZvciB0aGUgcHVycG9zZXMgb2YgdGhpcyBkZW1vCgljZnBhdGggOj0gZmlsZXBhdGguSm9pbigiaG9tZSIsICIuY29uZmlnIiwgImRlbW8iLCAiY29uZmlnLmN1ZSIpCgoJciA6PSBtYXBbc3RyaW5nXWFueXsKCQkicnVudGltZSI6IG1hcFtzdHJpbmddYW55ewoJCQkid29ya2luZ0RpcmVjdG9yeSI6ICIvcnVudGltZS9ibGFoIiwKCQl9LAoJfQoKCXZhciBjb25mIENvbmZpZwoJaWYgZXJyIDo9IGN1ZWNvbmZpZy5Mb2FkKGNmcGF0aCwgc2NoZW1hLCBkZWZhdWx0cywgciwgJmNvbmYpOyBlcnIgIT0gbmlsIHsKCQlsb2cuRmF0YWwoZXJyKQoJfQoKCW91dCwgZXJyIDo9IGpzb24uTWFyc2hhbEluZGVudChjb25mLCAiIiwgIiAgIikKCWlmIGVyciAhPSBuaWwgewoJCWxvZy5GYXRhbChlcnIpCgl9CglmbXQuUHJpbnRmKCIlc1xuIiwgb3V0KQp9Cg==" data-upload-term=".term1"><code class="language-go">package main

import (
	_ &#34;embed&#34;
	&#34;encoding/json&#34;
	&#34;fmt&#34;
	&#34;log&#34;
	&#34;path/filepath&#34;

	&#34;github.com/cue-exp/cueconfig&#34;
)

type Config struct &#123;
	Programs map[string]Program `json:&#34;programs&#34;`
&#125;

type Program struct &#123;
	Path         string   `json:&#34;path&#34;`
	Args         []string `json:&#34;args&#34;`
	Description  string   `json:&#34;description&#34;`
	Retries      int      `json:&#34;retries&#34;`
	IgnoreErrors bool     `json:&#34;ignoreErrors&#34;`
	Directory    string   `json:&#34;directory&#34;`
&#125;

var (
	//go:embed schema.cue
	schema []byte

	//go:embed defaults.cue
	defaults []byte
)

func main() &#123;
	// Use a fake &#34;$HOME&#34; for the purposes of this demo
	cfpath := filepath.Join(&#34;home&#34;, &#34;.config&#34;, &#34;demo&#34;, &#34;config.cue&#34;)

	r := map[string]any&#123;
		&#34;runtime&#34;: map[string]any&#123;
			&#34;workingDirectory&#34;: &#34;/runtime/blah&#34;,
		&#125;,
	&#125;

	var conf Config
	if err := cueconfig.Load(cfpath, schema, defaults, r, &amp;conf); err != nil &#123;
		log.Fatal(err)
	&#125;

	out, err := json.MarshalIndent(conf, &#34;&#34;, &#34;  &#34;)
	if err != nil &#123;
		log.Fatal(err)
	&#125;
	fmt.Printf(&#34;%s\n&#34;, out)
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8=" data-upload-src="c2NoZW1hLmN1ZQ==:cGFja2FnZSBtYWluCgpwcm9ncmFtczogW3N0cmluZ106ICNQcm9ncmFtCgojUHJvZ3JhbTogewoJcGF0aDogc3RyaW5nCglhcmdzPzogWy4uLnN0cmluZ10KCWRlc2NyaXB0aW9uOiAgIHN0cmluZwoJcmV0cmllcz86ICAgICAgaW50CglpZ25vcmVFcnJvcnM/OiBib29sCglkaXJlY3Rvcnk/OiAgICBzdHJpbmcKfQoKcnVudGltZTogI1J1bnRpbWUKCiNSdW50aW1lOiB7Cgl3b3JraW5nRGlyZWN0b3J5Pzogc3RyaW5nCn0K" data-upload-term=".term1"><code class="language-cue">package main

programs: [string]: #Program

#Program: &#123;
	path: string
	args?: [...string]
	description:   string
	retries?:      int
	ignoreErrors?: bool
	directory?:    string
&#125;

runtime: #Runtime

#Runtime: &#123;
	workingDirectory?: string
&#125;
</code></pre>

<pre data-upload-path="L2hvbWUvZ29waGVyL2RlbW8vaG9tZS8uY29uZmlnL2RlbW8=" data-upload-src="Y29uZmlnLmN1ZQ==:aW1wb3J0ICJzdHJpbmdzIgoKcnVudGltZTogXwoKcHJvZ3JhbXM6IFtfbmFtZT1zdHJpbmddOiB7CglkaXJlY3Rvcnk6ICAgKnJ1bnRpbWUud29ya2luZ0RpcmVjdG9yeSB8IF8KCXBhdGg6ICAgICAgICAqIi9wYXRoL3RvL1woX25hbWUpIiB8IF8KCWRlc2NyaXB0aW9uOiBzdHJpbmdzLkhhc1ByZWZpeChfbmFtZSkKfQoKcHJvZ3JhbXM6IHsKCXNlcnZpY2UxOiB7CgkJZGVzY3JpcHRpb246ICIiIgoJCQlzZXJ2aWNlMSBpcyBhIHNwZWNpYWwgc2VydmljZQoJCQlmb3Igc3BlY2lhbCB0aGluZ3MKCQkJIiIiCgkJYXJnczogWwoJCQkiaGVsbG8iLAoJCQkid29ybGQiLAoJCV0KCQlkaXJlY3Rvcnk6ICAgICIvdG1wIgoJCWlnbm9yZUVycm9yczogdHJ1ZQoJfQoJc2VydmljZTI6IHsKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UyIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCQlhcmdzOiBzZXJ2aWNlMS5hcmdzLAoJfQoJc2VydmljZTM6IHsKCQlkZXNjcmlwdGlvbjogIiIiCgkJCXNlcnZpY2UzIGlzIGEgc3BlY2lhbCBzZXJ2aWNlCgkJCWZvciBzcGVjaWFsIHRoaW5ncwoJCQkiIiIKCX0KfQo=" data-upload-term=".term1"><code class="language-cue">import &#34;strings&#34;

runtime: _

programs: [_name=string]: &#123;
	directory:   *runtime.workingDirectory | _
	path:        *&#34;/path/to/\(_name)&#34; | _
	description: strings.HasPrefix(_name)
&#125;

programs: &#123;
	service1: &#123;
		description: &#34;&#34;&#34;
			service1 is a special service
			for special things
			&#34;&#34;&#34;
		args: [
			&#34;hello&#34;,
			&#34;world&#34;,
		]
		directory:    &#34;/tmp&#34;
		ignoreErrors: true
	&#125;
	service2: &#123;
		description: &#34;&#34;&#34;
			service2 is a special service
			for special things
			&#34;&#34;&#34;
		args: service1.args,
	&#125;
	service3: &#123;
		description: &#34;&#34;&#34;
			service3 is a special service
			for special things
			&#34;&#34;&#34;
	&#125;
&#125;
</code></pre>

<pre data-command-src="Z28gcnVuIC4K"><code class="language-.term1">$ go run .
&#123;
  &#34;programs&#34;: &#123;
    &#34;service1&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service1&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service1 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: true,
      &#34;directory&#34;: &#34;/tmp&#34;
    &#125;,
    &#34;service2&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service2&#34;,
      &#34;args&#34;: [
        &#34;hello&#34;,
        &#34;world&#34;
      ],
      &#34;description&#34;: &#34;service2 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/runtime/blah&#34;
    &#125;,
    &#34;service3&#34;: &#123;
      &#34;path&#34;: &#34;/path/to/service3&#34;,
      &#34;args&#34;: null,
      &#34;description&#34;: &#34;service3 is a special service\nfor special things&#34;,
      &#34;retries&#34;: 3,
      &#34;ignoreErrors&#34;: false,
      &#34;directory&#34;: &#34;/runtime/blah&#34;
    &#125;
  &#125;
&#125;
</code></pre>

<script>let pageGuide="2022-09-23-london-gophers-cue"; let pageLanguage="en"; let pageScenario="go119";</script>
