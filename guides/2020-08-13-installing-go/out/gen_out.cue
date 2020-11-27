package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/installgo1.15.5@sha256:e1feb9c08fc4a728a9eb04651b8c2fd44c79b7f2278de83bb4a7598a57301576"
		}
	}
}]
Scenarios: [{
	Name:        "go115"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	start_dir: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "start_dir"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "pwd"
			ExitCode: 0
			Output: """
				/home/gopher

				"""
			ComparisonOutput: """
				/home/gopher

				"""
		}]
	}
	download_go: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "download_go"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "wget -q https://golang.org/dl/go1.15.5.linux-amd64.tar.gz"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	install_go: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "install_go"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	add_install_to_path: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "add_install_to_path"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "echo export PATH=\"/usr/local/go/bin:$PATH\" >>$HOME/.profile"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	source_profile: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "source_profile"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "source $HOME/.profile"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	go_version: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_version"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.15.5 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.15.5 linux/amd64

				"""
		}]
	}
	go_env: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env"
			ExitCode: 0
			Output: """
				GO111MODULE=""
				GOARCH="amd64"
				GOBIN=""
				GOCACHE="/home/gopher/.cache/go-build"
				GOENV="/home/gopher/.config/go/env"
				GOEXE=""
				GOFLAGS=""
				GOHOSTARCH="amd64"
				GOHOSTOS="linux"
				GOINSECURE=""
				GOMODCACHE="/home/gopher/go/pkg/mod"
				GONOPROXY=""
				GONOSUMDB=""
				GOOS="linux"
				GOPATH="/home/gopher/go"
				GOPRIVATE=""
				GOPROXY="https://proxy.golang.org,direct"
				GOROOT="/usr/local/go"
				GOSUMDB="sum.golang.org"
				GOTMPDIR=""
				GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
				GCCGO="gccgo"
				AR="ar"
				CC="gcc"
				CXX="g++"
				CGO_ENABLED="1"
				GOMOD=""
				CGO_CFLAGS="-g -O2"
				CGO_CPPFLAGS=""
				CGO_CXXFLAGS="-g -O2"
				CGO_FFLAGS="-g -O2"
				CGO_LDFLAGS="-g -O2"
				PKG_CONFIG="pkg-config"
				GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build -gno-record-gcc-switches"

				"""
			ComparisonOutput: """
				GO111MODULE=""
				GOARCH="amd64"
				GOBIN=""
				GOCACHE="/home/gopher/.cache/go-build"
				GOENV="/home/gopher/.config/go/env"
				GOEXE=""
				GOFLAGS=""
				GOHOSTARCH="amd64"
				GOHOSTOS="linux"
				GOINSECURE=""
				GOMODCACHE="/home/gopher/go/pkg/mod"
				GONOPROXY=""
				GONOSUMDB=""
				GOOS="linux"
				GOPATH="/home/gopher/go"
				GOPRIVATE=""
				GOPROXY="https://proxy.golang.org,direct"
				GOROOT="/usr/local/go"
				GOSUMDB="sum.golang.org"
				GOTMPDIR=""
				GOTOOLDIR="/usr/local/go/pkg/tool/linux_amd64"
				GCCGO="gccgo"
				AR="ar"
				CC="gcc"
				CXX="g++"
				CGO_ENABLED="1"
				GOMOD=""
				CGO_CFLAGS="-g -O2"
				CGO_CPPFLAGS=""
				CGO_CXXFLAGS="-g -O2"
				CGO_FFLAGS="-g -O2"
				CGO_LDFLAGS="-g -O2"
				PKG_CONFIG="pkg-config"
				GOGCCFLAGS="-fPIC -m64 -pthread -fno-caret-diagnostics -Qunused-arguments -fmessage-length=0 -fdebug-prefix-map=/tmp/go-build -gno-record-gcc-switches"

				"""
		}]
	}
	go_env_gobin: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_gobin"
		Order:           7
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOBIN"
			ExitCode: 0
			Output: """


				"""
			ComparisonOutput: """


				"""
		}]
	}
	go_env_set_gobin: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_set_gobin"
		Order:           8
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go env -w GOBIN=/path/to/my/gobin"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	go_env_check_gobin: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_check_gobin"
		Order:           9
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOBIN"
			ExitCode: 0
			Output: """
				/path/to/my/gobin

				"""
			ComparisonOutput: """
				/path/to/my/gobin

				"""
		}]
	}
	go_env_env: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_env"
		Order:           10
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOENV"
			ExitCode: 0
			Output: """
				/home/gopher/.config/go/env

				"""
			ComparisonOutput: """
				/home/gopher/.config/go/env

				"""
		}]
	}
	go_env_unset_gobin: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_unset_gobin"
		Order:           11
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go env -w GOBIN="
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	go_env_check_gobin_again: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_env_check_gobin_again"
		Order:           12
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOBIN"
			ExitCode: 0
			Output: """


				"""
			ComparisonOutput: """


				"""
		}]
	}
	go_help_env: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: true
		Name:            "go_help_env"
		Order:           13
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go help env"
			ExitCode: 0
			Output: """
				usage: go env [-json] [-u] [-w] [var ...]

				Env prints Go environment information.

				By default env prints information as a shell script
				(on Windows, a batch file). If one or more variable
				names is given as arguments, env prints the value of
				each named variable on its own line.

				The -json flag prints the environment in JSON format
				instead of as a shell script.

				The -u flag requires one or more arguments and unsets
				the default setting for the named environment variables,
				if one has been set with 'go env -w'.

				The -w flag requires one or more arguments of the
				form NAME=VALUE and changes the default settings
				of the named environment variables to the given values.

				For more about environment variables, see 'go help environment'.

				"""
			ComparisonOutput: """
				usage: go env [-json] [-u] [-w] [var ...]

				Env prints Go environment information.

				By default env prints information as a shell script
				(on Windows, a batch file). If one or more variable
				names is given as arguments, env prints the value of
				each named variable on its own line.

				The -json flag prints the environment in JSON format
				instead of as a shell script.

				The -u flag requires one or more arguments and unsets
				the default setting for the named environment variables,
				if one has been set with 'go env -w'.

				The -w flag requires one or more arguments of the
				form NAME=VALUE and changes the default settings
				of the named environment variables to the given values.

				For more about environment variables, see 'go help environment'.

				"""
		}]
	}
	gobin_not_set: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gobin_not_set"
		Order:           14
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go env GOBIN"
			ExitCode: 0
			Output: """


				"""
			ComparisonOutput: """


				"""
		}]
	}
	add_gobin_bin_to_path: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "add_gobin_bin_to_path"
		Order:           15
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "echo export PATH=\"$(go env GOPATH)/bin:$PATH\" >>$HOME/.profile"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	source_profile_again: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "source_profile_again"
		Order:           16
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "source $HOME/.profile"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	echo_path: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "echo_path"
		Order:           17
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "echo $PATH"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

				"""
			ComparisonOutput: """
				/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

				"""
		}]
	}
}
Hash: "eeb26d6eabd546020b6f237bc95884236eee5d09b2f597415068f409206bdbb9"
Delims: ["{{{", "}}}"]
