---
layout: post
title:  "Repository structure with multiple major versions"
excerpt: "Options for repository structure with multiple major versions"
difficulty: Intermediate
---
### Introduction

In this guide you will:

* create a `{{{.branch_mod}}}` module
* publish `{{{.branch_mod}}}` `v1.0.0`
* make breaking changes to create `{{{.branch_mod}}}/v2`, using the major version branch strategy
* publish `{{{.branch_mod}}}` `v2.0.0`
* create a `{{{.subdir_mod}}}` module
* publish `{{{.subdir_mod}}}` `v1.0.0`
* make breaking changes to create `{{{.subdir_mod}}}/v2`, using the major version subdirectory strategy
* publish `{{{.subdir_mod}}}` `v2.0.0`
* create a `{{{.gopher}}}` module that uses all the aforementioned modules

### Context

{{{ step "goversion" }}}

### Major branch strategy

{{{ step "branch_init" }}}

{{{ step "branch_go_initial" }}}

{{{ step "branch_initial_commit" }}}

{{{ step "branch_create_v1_branch" }}}

{{{ step "branch_go_mod_v2" }}}

{{{ step "branch_go_v2" }}}

{{{ step "branch_v2_commit" }}}

### Major subdirectory strategy

{{{ step "subdir_init" }}}

{{{ step "subdir_go_initial" }}}

{{{ step "subdir_initial_commit" }}}

{{{ step "subdir_create_v2_subdir" }}}

{{{ step "subdir_go_mod_v2" }}}

{{{ step "subdir_go_v2" }}}

{{{ step "subdir_v2_commit" }}}

### Using `#allthemodules`: the `{{{ .gopher }}}` module

{{{ step "gopher_init" }}}

{{{ step "gopher_go_initial" }}}

{{{ step "gopher_get_deps" }}}

{{{ step "gopher_run" }}}
