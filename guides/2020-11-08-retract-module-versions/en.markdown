---
layout: post
title:  "Retract Module Versions"
excerpt: "Learn how to flag modules that shouldn't be used"
category: What's coming in Go 1.16
difficulty: Intermediate
---

_By [Jay Conrod](https://twitter.com/jayconrod), software engineer on the [Go](https://golang.org/) tools team, and
principal author of module retraction in the `go` command._

_Note: this is a preview of a `cmd/go` feature that is due to land in Go 1.16_

Module authors need a way to indicate that published module versions should not be used. There are a number of reasons
this may be needed:

* A severe security vulnerability has been identified.
* A severe incompatibility or bug was discovered.
* The version was published accidentally or prematurely.

Authors can't simply delete version tags, since they remain available on module proxies. If an author were able to
delete a version from all proxies, it would break downstream users that depend on that version.

Authors also can't change versions after they've published. `go.sum` files and the checksum database verify that published
versions never change.

Instead, authors should be able to _retract_ module versions. A retracted module version is a version with an explicit
declaration from the module author that it should not be used. (The word retract is borrowed from academic literature: a
retracted research paper is still available, but it has problems and should not be the basis of future work).

Retracted versions should remain available in module proxies and origin repositories. Builds that depend on retracted
versions should continue to work. However, users should be notified when they depend on a retracted version (either
directly or indirectly). It should also be difficult to unintentionally upgrade to a retracted version.

This guide walks you through how to use module retractions. In the guide you will create two modules:

* `<!--ref:proverb_mod-->` (part of a module at the same path) that provides various different wise proverbs. You will
  publish a number of versions of this module.
* `<!--ref:gopher-->`, a simple `main` package that uses `<!--ref:proverb_mod-->`. You will not publish this module; it
  will be local-only.

### Prerequisites

You should already have completed:

* The [Go fundamentals Tutorial](/go-fundamentals_go115_en)

This guide is running using:

<!--step: goversion-->

### The `<!--ref:proverb-->` module

Start by initialising your `<!--ref:proverb-->` module:

<!--step: proverb_create-->

Create an initial version with a `Go` function that returns a Go proverb in the file `<!--ref:proverb_go-->`:

<!--step: proverb_go_initial-->

Commit and push this initial version:

<!--step: proverb_initial_commit-->

It's early days for the `<!--ref:proverb-->` module, so you decide to tag it with a `v0` semantic version, indicating it
is not yet stable:

<!--step: proverb_tag_v010-->

With the first version of the `<!--ref:proverb-->` module published, it's time to create a first cut of your
`<!--ref:gopher-->` module.

### The `<!--ref:gopher-->` module

You are not going to publish the `<!--ref:gopher-->` module, so the setup is simpler:

<!--step: gopher_create-->

Notice how you skipped the `git` steps, and also how the module path is simply `<!--ref:gopher_mod-->`. As this module
will be local-only, you can use any path you like.

Create an initial version of the `main` function in `<!--ref:gopher_go-->`:

<!--step: gopher_go_initial-->

In this code you:

* Import the `<!--ref:proverb_mod-->` package. This declares the dependency on this package.
* Use the [`fmt.Println`](https://pkg.go.dev/fmt#Println) to print the proverb returned by `<!--ref:proverb-->.Go()`
  function.

Add a dependency on the `<!--ref:proverb_mod-->` module:

<!--step: gopher_add_dep_proverb_v010-->

Run to make sure everything works:

<!--step: gopher_run_initial-->

Looks great!

### A "better" initial version

After much debate with some friends, you decide that there is a better Go proverb to use in the initial version of your
`<!--ref:proverb-->` module.

Change back to the `<!--ref:proverb-->` module:

<!--step: proverb_cd_concurrency_change-->

Update `<!--ref:proverb_go-->` as follows:

<!--step: proverb_go_concurrency-->

Commit and push this updated version:

<!--step: proverb_concurrency_commit-->

Given there might be further changes to the `<!--ref:proverb-->` module before you mark it as `v1` stable, you decide to
publish `<!--ref:proverb_v020-->` to be on the safe side:

<!--step: proverb_tag_v020-->

With the second version of the `<!--ref:proverb-->` module now published, return to your `<!--ref:gopher-->` module and
try this out:

<!--step: gopher_use_v020-->

Oops! That doesn't look right: the proverb should read _"Concurrency is **not** parallelism."_ Looks like you made a
mistake with the changes in `<!--ref:proverb_v020-->`. You can surely publish a new version of the `<!--ref:proverb-->`
module to correct the mistake, but how can you prevent your users from depending on this broken version?

Module retraction to the rescue.

### Retracting module versions

A module author can retract a version of a module by adding a `retract` directive to the `go.mod` file. The `retract`
directive simply lists retracted versions. The `go` command reads retractions from the highest release version of the
module.

To retract `<!--ref:proverb_v020-->` of the `<!--ref:proverb-->` module, you will therefore publish
`<!--ref:proverb_v030-->`. This new version will also fix the bug you found in `<!--ref: proverb_v020-->`.

Return to the `<!--ref: proverb-->` module:

<!--step: proverb_return_to_retract_v020-->

Rather than making the change to your `go.mod` file by hand, you can instead use
`<!--ref:cmdgo.modedit-->` as follows:

<!--step: proverb_retract_v020-->

Inspect the `go.mod` to see the result:

<!--step: proverb_cat_v020_retract-->

As is best practice, add a comment to the `retract` directive documenting why the retraction was
necessary:

<!--step: proverb_comment_retraction-->

The comment may be shown by tools like `<!--ref:cmdgo.get-->` and `<!--ref:cmdgo.list-->`. It will be shown by
[`gorelease`](https://pkg.go.dev/golang.org/x/exp/cmd/gorelease) and [`pkg.go.dev`](https://pkg.go.dev/) later on, too.

Fix the bug in `<!--ref:proverb_go-->`:

<!--step: proverb_go_fix_concurrency_bug-->

Commit, push and tag `<!--ref:proverb_v030-->`:

<!--step: proverb_tag_v030-->

Return to your `<!--ref:gopher-->` module to use this new version:

<!--step: gopher_use_v030-->

This step also ensures that [proxy.golang.org](https://proxy.golang.org/) is now aware of `<!--ref:proverb_v030-->`.
Manually "pulling" a version of a module into the proxy using `<!--ref:cmdgo.get-->` in this way means you (or indeed
others) do not have to rely or wait on the proxy automatically checking for later versions of a module.

Verify this new version fixes things:

<!--step: gopher_run_v030-->

That's better.

So what exactly has happened to `<!--ref:proverb_v020-->`? Remember, you can't simply delete a version of the
`<!--ref:proverb-->` module, since it remains available on module proxies.  Let's use `<!--ref:cmdgo.list-->` to dig a
bit deeper.

But first you need to wait for the proxy to update its state:

<!--step:gopher_sleep_on_proxy-->

Why? The FAQ on the [proxy website](https://proxy.golang.org/) explains:

> In order to improve the proxy's caching and serving latencies, new versions may not show up right away. If you want new
code to be immediately available in the mirror, then first make sure there is a semantically versioned tag for this
revision in the underlying source repository. Then explicitly request that version via go get module@version. After one
minute for caches to expire, the go command will see that tagged version. If this doesn't work for you, please file an
issue.

List the non-retracted, "usable" versions of the `<!--ref: proverb_mod-->` module known to the proxy:

<!--step: gopher_list_proverb-->

Notice that the newly published `<!--ref:proverb_v030-->` is in this list, but `<!--ref:proverb_v020-->` is not.

List _all_ versions versions (including any that are retracted):

<!--step: gopher_list_proverb_retracted-->

Ah, there is the mischievous `<!--ref:proverb_v020-->`.

So what would happen if you were to rely on the now retracted `<!--ref:proverb_v020-->`?

<!--step: gopher_use_retracted_v020-->

A helpful message is printed, warning that you are now depending on a retracted version. Notice that this error message
includes the text from the comment you added to the `retract` directive.

But does the code run?

<!--step: gopher_run_retracted_v020-->

Interesting: your code continues to "work" as before.

So how do you tell if you are relying on retracted versions of a module? For this, you again turn to
`<!--ref:cmdgo.list-->`:

<!--step: gopher_list_versions-->

Let's follow the advice of the warning message, and return to the latest un-retracted version:

<!--step: gopher_use_latest_unretracted-->

### Another type of proverb

After consulting a wise friend, you decide that your `<!--ref: proverb-->` module needs to be a bit more rounded with
its advice, and that one more change is therefore required before you declare it stable at `v1`. Returning to the
`<!--ref:proverb-->` module:

<!--step: proverb_return_life-->

Update `<!--ref: proverb_go-->` as follows:

<!--step: proverb_go_life_advice-->

Commit and push this updated version:

<!--step: proverb_life_commit-->

To be safe, you decide to publish `<!--ref:proverb_v040-->` before committing to a `v1` stable version:

<!--step: proverb_tag_v100-->

Oh no! You accidentally tagged and pushed `<!--ref: proverb_v100-->` instead of `<!--ref: proverb_v040-->`. Users of
your module might mistakenly think the `<!--ref:proverb-->` API is stable and that there will not therefore be any
breaking changes. But you're not ready to make that sort of commitment!

Let's retract `<!--ref:proverb_v100-->` of the `<!--ref:proverb-->` module, but first publish with the correct version,
`<!--ref:proverb_v040-->`:

<!--step: proverb_tag_v040-->

To retract `<!--ref:proverb_v100-->` you will need to publish `<!--ref:proverb_v101-->`. But that means you will _also_
need to retract version `<!--ref:proverb_v101-->`. You do so using a [closed
range](https://en.wikipedia.org/wiki/Interval_(mathematics)). Make this change by hand by editing the
`<!--ref:proverb-->` `go.mod` file, commenting the `retract` directive as is best practice:

<!--step: proverb_retract_v100-->

Commit, tag, push and publish `<!--ref: proverb_v101-->`:

<!--step: proverb_tag_v101-->

Return to the `<!--ref:gopher-->` module to experiment with the newly retracted versions:

<!--step: gopher_cd_use_v100-->

Ensure proxy.golang.org is aware of the new versions of `<!--ref: proverb-->` you just published. `<!--ref:cmdgo.get-->`
`<!--ref:proverb_v040-->` last to leave that version as the current dependency (you will test it later).

<!--step: gopher_use_v101-->

_Note: you might not see the warning about either `<!--ref: proverb_v100-->` or `<!--ref: proverb_v101-->` being
retracted versions. proxy.golang.org automatically updates periodically; depending on how lucky you are, an automatic
update may have occurred in the time since you published `<!--ref: proverb_v101-->` in which case you will see the
warning message, or it may not._

Now that you have pulled these versions through the proxy, wait for the proxy cache to update:

<!--step:gopher_sleep_on_proxy_again-->

List all versions of the `<!--ref: proverb_mod-->` known to the proxy, including the retracted ones:

<!--step: gopher_list_proverb_v101_retracted-->

List the non-retracted versions of the `<!--ref: proverb_mod-->` known to the proxy:

<!--step: gopher_list_proverb_v101_nonretracted-->

This shows that `<!--ref:proverb_v040-->` is the latest version of the `<!--ref: proverb-->` module, as expected.

Update `<!--ref: gopher_go-->` to use the new proverb:

<!--step: gopher_go_update_life_proverb-->

Finally, run `<!--ref:gopher-->` to verify everything works:

<!--step: gopher_run_life_proverb-->

Note that when you come to publish the "real" `<!--ref: proverb_v100-->` of the `<!--ref:proverb-->` module, it must
be published as `<!--ref:proverb_v102-->` since you cannot change or delete versions (retracted or not).

### Conclusion

That's it! This guide has introduced module retraction, demonstrating how to retract a simple bad version, as well as
retracting an accidental `v1`. For more information on module retraction, see [the modules
reference](https://golang.org/ref/mod).
