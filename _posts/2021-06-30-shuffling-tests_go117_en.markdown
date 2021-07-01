---
category: What's coming in Go 1.17
difficulty: Beginner
excerpt: Learn how to shuffle execution order of tests and benchmarks
guide: 2021-06-30-shuffling-tests
lang: en
layout: post
title: Shuffling Go tests
---

*By [Paschalis Tsilias](https://twitter.con/tpaschalis_), Go developer*.

*Note: this is a preview of a `go test` feature that is due to land in Go 1.17*


### Intro
Testing is a first-class citizen in the Go ecosystem. This means that the barrier to testing Go projects is lower, and that there is little cognitive overhead to reading and understanding test code in unfamiliar projects. 

But once suites start growing, unwanted dependencies may appear between different test and benchmark functions. In some cases, the suite may be passing, but actually fail if the tests are run in a different order. 

This guide will walk you through creating a new Go package and its test file, which appears to run correctly, but contains a subtle flaw.

You will use the new `-shuffle` flag to uncover this defect, and enforce randomization of test ordering to avoid such issues reappearing in the future. So, let’s get into it!

### The `gopher` package
So let’s build a new package by creating a folder and initializing a Go module.

<pre data-command-src="bWtkaXIgL2hvbWUvZ29waGVyL2dvcGhlcmt2CmNkIC9ob21lL2dvcGhlci9nb3BoZXJrdgpnbyBtb2QgaW5pdCBnb3BoZXJrdgo="><code class="language-.term1">$ mkdir /home/gopher/gopherkv
$ cd /home/gopher/gopherkv
$ go mod init gopherkv
go: creating new go.mod: module gopherkv
</code></pre>

Our `gopherkv` package will provide the smallest in-memory Key-Value storage, powered by a single `map[string]string`. Every grand project idea has to start somewhere right?

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcmt2" data-upload-src="Z29waGVya3YuZ28=:cGFja2FnZSBnb3BoZXJrdgoKdHlwZSBLViBzdHJ1Y3QgewoJZGF0YSBtYXBbc3RyaW5nXXN0cmluZwp9CgpmdW5jIENyZWF0ZShzaXplIHVpbnQpICpLViB7CglyZXR1cm4gJktWewoJCWRhdGE6IG1ha2UobWFwW3N0cmluZ11zdHJpbmcsIHNpemUpLAoJfQp9CgpmdW5jIChrdiAqS1YpIEdldChrZXkgc3RyaW5nKSAoc3RyaW5nLCBib29sKSB7Cgl2LCBvayA6PSBrdi5kYXRhW2tleV0KCXJldHVybiB2LCBvawp9CgpmdW5jIChrdiAqS1YpIFNldChrZXksIHZhbHVlIHN0cmluZykgewoJa3YuZGF0YVtrZXldID0gdmFsdWUKfQoKZnVuYyAoa3YgKktWKSBQdXJnZSgpIHsKCWt2LmRhdGEgPSBtYWtlKG1hcFtzdHJpbmddc3RyaW5nKQp9" data-upload-term=".term1"><code class="language-go">package gopherkv

type KV struct &#123;
	data map[string]string
&#125;

func Create(size uint) *KV &#123;
	return &amp;KV&#123;
		data: make(map[string]string, size),
	&#125;
&#125;

func (kv *KV) Get(key string) (string, bool) &#123;
	v, ok := kv.data[key]
	return v, ok
&#125;

func (kv *KV) Set(key, value string) &#123;
	kv.data[key] = value
&#125;

func (kv *KV) Purge() &#123;
	kv.data = make(map[string]string)
&#125;</code></pre>


### Let’s test it!
So let’s create a new `gopher_test.go` file which will test the functionality present in the `gopher` package.

<pre data-upload-path="L2hvbWUvZ29waGVyL2dvcGhlcmt2" data-upload-src="Z29waGVya3ZfdGVzdC5nbw==:cGFja2FnZSBnb3BoZXJrdgoKaW1wb3J0ICJ0ZXN0aW5nIgoKdmFyIGt2ICpLVgoKZnVuYyBUZXN0Q3JlYXRlS1YodCAqdGVzdGluZy5UKSB7CglrdiA9IENyZWF0ZSg1MTIpCglpZiBrdiA9PSBuaWwgewoJCXQuRXJyb3JmKCJleHBlY3RlZCBuZXdseSBjcmVhdGVkIGt2IHN0b3JlIHRvIG5vdCBiZSBuaWwiKQoJfQp9CgpmdW5jIFRlc3RTZXQodCAqdGVzdGluZy5UKSB7Cglrdi5TZXQoImZvbyIsICJiYXIiKQoKCWlmIGxlbihrdi5kYXRhKSAhPSAxIHsKCQl0LkVycm9yZigiZXhwZWN0ZWQgZXhhY3RseSBvbmUgdmFsdWUgdG8gYmUgc2V0IikKCX0KfQoKZnVuYyBUZXN0R2V0KHQgKnRlc3RpbmcuVCkgewoJdmFsLCBleGlzdHMgOj0ga3YuR2V0KCJmb28iKQoJaWYgdmFsICE9ICJiYXIiIHx8ICFleGlzdHMgewoJCXQuRXJyb3JmKCJleHBlY3RlZCBmb286YmFyIHBhaXIgdG8gaGF2ZSBiZWVuIGZldGNoZWQgY29ycmVjdGx5IikKCX0KfQoKZnVuYyBUZXN0UHVyZ2UodCAqdGVzdGluZy5UKSB7Cglrdi5QdXJnZSgpCglsZW5OZXcgOj0gbGVuKGt2LmRhdGEpCgoJaWYgbGVuTmV3ICE9IDAgewoJCXQuRXJyb3JmKCJleHBlY3RlZCBhIGxlbmd0aCBvZiAwIGFmdGVyIHB1cmdpbmciKQoJfQp9" data-upload-term=".term1"><code class="language-go">package gopherkv

import &#34;testing&#34;

var kv *KV

func TestCreateKV(t *testing.T) &#123;
	kv = Create(512)
	if kv == nil &#123;
		t.Errorf(&#34;expected newly created kv store to not be nil&#34;)
	&#125;
&#125;

func TestSet(t *testing.T) &#123;
	kv.Set(&#34;foo&#34;, &#34;bar&#34;)

	if len(kv.data) != 1 &#123;
		t.Errorf(&#34;expected exactly one value to be set&#34;)
	&#125;
&#125;

func TestGet(t *testing.T) &#123;
	val, exists := kv.Get(&#34;foo&#34;)
	if val != &#34;bar&#34; || !exists &#123;
		t.Errorf(&#34;expected foo:bar pair to have been fetched correctly&#34;)
	&#125;
&#125;

func TestPurge(t *testing.T) &#123;
	kv.Purge()
	lenNew := len(kv.data)

	if lenNew != 0 &#123;
		t.Errorf(&#34;expected a length of 0 after purging&#34;)
	&#125;
&#125;</code></pre>

Let's actually run the tests in this file

<pre data-command-src="Z28gdGVzdCAtY292ZXIgLi8uLi4K"><code class="language-.term1">$ go test -cover ./...
ok  	gopherkv	0.002s	coverage: 100.0% of statements
</code></pre>

It seems that we not only have a passing test suite, but *also* that we're achieving 100% coverage for our package. 

Sounds like we're off to a pretty good start, right?

### Let’s shuffle things up!
Some of you may be already raising some concerns regarding the tests we wrote. They contain a subtle flaw that may not be immediately apparent. 

Let’s run the test suite again and randomize the execution order by using `go test ./… -shuffle=<seed>`.

<pre data-command-src="Z28gdGVzdCAtc2h1ZmZsZT01IC4vLi4uIHx8IHRydWUK"><code class="language-.term1">$ go test -shuffle=5 ./... || true
-test.shuffle 5
--- FAIL: TestGet (0.00s)
    gopherkv_test.go:25: expected foo:bar pair to have been fetched correctly
FAIL
FAIL	gopherkv	0.002s
FAIL
</code></pre>

We now get a failure, and our 'green' test suite may not be so great after all! 

The way that the tests initialize and use the shared `kv` pacakge-level variable, makes them dependent on each other and a different execution order will result in failures.

We can see, that since the test failed Go reports the seed used for the current run so that such failures can be reproduced anywhere by running `go test ./… -shuffle=N`.

### Along the -count flag 
The `-count` flag is often used with the go test command, either to disable caching or uncover flaky tests. 

Whenever the `-shuffle` and `-count` flags are used together, the execution order will be randomized once at the start, and then re-used for the next runs. This can help to spot rare cases of flaky tests failing for specific test seeds.

### Do I always need to provide a seed value?
One way to strengthen your tests suite is to run them using the `-shuffle=on` flag. Each time, a new seed will be selected based on your system's clock.

### Conclusion
That’s all! This guide has introduced the `-shuffle` flag for the go test command, demonstrated how test reordering can uncover flaws in our test suite, and how we can continously try to detect and prevent such issues in the future. 

As a next step you might like to consider:
* [Developer tools as module dependencies](/tools-as-dependencies_go115_en/)
* [How to use and tweak Staticcheck](/using-staticcheck_go115_en/)
<script>let pageGuide="2021-06-30-shuffling-tests"; let pageLanguage="en"; let pageScenario="go117";</script>
