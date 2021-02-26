// Copyright 2020 The play-with-go.dev Authors. All rights reserved.  Use of
// this source code is governed by a BSD-style license that can be found in the
// LICENSE file.

// +build tools

package tools

import (
	_ "cuelang.org/go/cmd/cue"
	_ "github.com/myitcv/docker-compose"
	_ "github.com/play-with-docker/play-with-docker"
	_ "github.com/play-with-docker/play-with-docker/router/l2"
	_ "github.com/play-with-go/gitea/cmd/gitea"
	_ "github.com/play-with-go/preguide/cmd/preguide"
	_ "github.com/cue-sh/unity/cmd/unity"
)
