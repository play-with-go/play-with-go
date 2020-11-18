package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/installgo1.15.5@sha256:84d53427b7292d67cbb45fddebe2e5ae310c7d9cc8b8ea67c2738757f9069a15"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.15"
	Name:        "go115"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	echo_path: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

				"""
			Output: """
				/home/gopher/go/bin:/usr/local/go/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games

				"""
			ExitCode: 0
			CmdStr:   "echo $PATH"
			Negated:  false
		}]
		Order:           17
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "echo_path"
	}
	source_profile_again: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "source $HOME/.profile"
			Negated:          false
		}]
		Order:           16
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "source_profile_again"
	}
	add_gobin_bin_to_path: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "echo export PATH=\"$(go env GOPATH)/bin:$PATH\" >>$HOME/.profile"
			Negated:          false
		}]
		Order:           15
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "add_gobin_bin_to_path"
	}
	gobin_not_set: {
		Stmts: [{
			ComparisonOutput: """


				"""
			Output: """


				"""
			ExitCode: 0
			CmdStr:   "go env GOBIN"
			Negated:  false
		}]
		Order:           14
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "gobin_not_set"
	}
	go_env_check_gobin_again: {
		Stmts: [{
			ComparisonOutput: """


				"""
			Output: """


				"""
			ExitCode: 0
			CmdStr:   "go env GOBIN"
			Negated:  false
		}]
		Order:           12
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_check_gobin_again"
	}
	go_env_unset_gobin: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go env -w GOBIN="
			Negated:          false
		}]
		Order:           11
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_unset_gobin"
	}
	go_env_env: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/.config/go/env

				"""
			Output: """
				/home/gopher/.config/go/env

				"""
			ExitCode: 0
			CmdStr:   "go env GOENV"
			Negated:  false
		}]
		Order:           10
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_env"
	}
	go_env_check_gobin: {
		Stmts: [{
			ComparisonOutput: """
				/path/to/my/gobin

				"""
			Output: """
				/path/to/my/gobin

				"""
			ExitCode: 0
			CmdStr:   "go env GOBIN"
			Negated:  false
		}]
		Order:           9
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_check_gobin"
	}
	go_env_set_gobin: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go env -w GOBIN=/path/to/my/gobin"
			Negated:          false
		}]
		Order:           8
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_set_gobin"
	}
	go_env_gobin: {
		Stmts: [{
			ComparisonOutput: """


				"""
			Output: """


				"""
			ExitCode: 0
			CmdStr:   "go env GOBIN"
			Negated:  false
		}]
		Order:           7
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env_gobin"
	}
	go_env: {
		Stmts: [{
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
			ExitCode: 0
			CmdStr:   "go env"
			Negated:  false
		}]
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_env"
	}
	go_version: {
		Stmts: [{
			ComparisonOutput: """
				go version go1.15.5 linux/amd64

				"""
			Output: """
				go version go1.15.5 linux/amd64

				"""
			ExitCode: 0
			CmdStr:   "go version"
			Negated:  false
		}]
		Order:           5
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_version"
	}
	source_profile: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "source $HOME/.profile"
			Negated:          false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "source_profile"
	}
	add_install_to_path: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "echo export PATH=\"/usr/local/go/bin:$PATH\" >>$HOME/.profile"
			Negated:          false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "add_install_to_path"
	}
	install_go: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "sudo tar -C /usr/local -xzf go1.15.5.linux-amd64.tar.gz"
			Negated:          false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "install_go"
	}
	download_go: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "wget -q https://golang.org/dl/go1.15.5.linux-amd64.tar.gz"
			Negated:          false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "download_go"
	}
	start_dir: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher

				"""
			Output: """
				/home/gopher

				"""
			ExitCode: 0
			CmdStr:   "pwd"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "start_dir"
	}
	go_help_env: {
		Stmts: [{
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
			ExitCode: 0
			CmdStr:   "go help env"
			Negated:  false
		}]
		Order:           13
		InformationOnly: true
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go_help_env"
	}
}
Hash: "f5947bae7635de0d75719e9f1f07384b090604180012e652b65c8a24fc6cec93"
Delims: ["{{{", "}}}"]
