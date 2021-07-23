package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.8@sha256:7640da09d1555c4dddbba7f1b96051af2816e6542005176b749f38865ee0454c"
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
Hash: "24af23fafe43b0df2bd68b991e110ab011c6cd12d51062d13ab12b13628494ce"
Delims: ["{{{", "}}}"]
