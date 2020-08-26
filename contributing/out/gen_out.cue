package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/create-your-first-guide"
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
	tool_versions: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "tool_versions"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "docker version -f {{.Server.Version}}"
			ExitCode: 0
			Output: """
				19.03.13

				"""
			ComparisonOutput: """
				19.03.13

				"""
		}, {
			Negated:  false
			CmdStr:   "docker-compose version"
			ExitCode: 0
			Output: """
				docker-compose version 1.26.2, build eefe0d31
				docker-py version: 4.2.2
				CPython version: 3.7.7
				OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019

				"""
			ComparisonOutput: """
				docker-compose version 1.26.2, build eefe0d31
				docker-py version: 4.2.2
				CPython version: 3.7.7
				OpenSSL version: OpenSSL 1.1.0l  10 Sep 2019

				"""
		}, {
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
	clone_play_with_go: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "clone_play_with_go"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "git clone -q https://github.com/play-with-go/play-with-go"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd play-with-go"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "git checkout simple_guide"
			ExitCode: 0
			Output: """
				Branch 'simple_guide' set up to track remote branch 'simple_guide' from 'origin'.
				Switched to a new branch 'simple_guide'

				"""
			ComparisonOutput: """
				Branch 'simple_guide' set up to track remote branch 'simple_guide' from 'origin'.
				Switched to a new branch 'simple_guide'

				"""
		}]
	}
	create_file: {
		StepType: 2
		Name:     "create_file"
		Order:    2
		Terminal: "term1"
		Language: "txt"
		Renderer: {
			RendererType: 1
		}
		Source: """
			Blah

			"""
		Target: "/home/gopher/play-with-go/blah.txt"
	}
}
Hash: "d5c8d27e5545459eefb2ead4b3312b50e539e224d3f51d3fcd288432746f1da0"
Delims: ["{{{", "}}}"]
