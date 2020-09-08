// Copyright 2020 The play-with-go.dev Authors. All rights reserved.  Use of
// this source code is governed by a BSD-style license that can be found in the
// LICENSE file.

package deps

//go:generate go run cuelang.org/go/cmd/cue cmd vendorgithubschema .
//go:generate ./vendor.sh github.com/play-with-go/preguide github.com/play-with-go/gitea
