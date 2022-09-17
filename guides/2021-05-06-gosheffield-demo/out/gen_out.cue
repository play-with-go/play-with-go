package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.19.1:5966cd5f1b8ef645576f95bcb19fff827d6ca560"
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
	create_script: {
		StepType: 2
		Name:     "create_script"
		Order:    0
		Terminal: "term1"
		Language: "sh"
		Renderer: {
			RendererType: 1
		}
		Source: """
			echo "Hello, world!"

			"""
		Target: "/home/gopher/script.sh"
	}
	run_script: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "run_script"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "bash /home/gopher/script.sh"
			ExitCode: 0
			Output: """
				Hello, world!

				"""
			ComparisonOutput: """
				Hello, world!

				"""
		}]
	}
}
Hash: "09e26e2e121925fb298139537bf27cbb561802c097fd17a2c0d1be60fe318ffe"
Delims: ["{{{", "}}}"]
