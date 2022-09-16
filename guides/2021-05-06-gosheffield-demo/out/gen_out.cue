package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.15:c14f40c289a17ef3817d7f82ea3ea2cfc3297713"
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
Hash: "271f9cdbe52fe75c83acb8deecf95dc51ec068d641335bba20245003681ce10a"
Delims: ["{{{", "}}}"]
