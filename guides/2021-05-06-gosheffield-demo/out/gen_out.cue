package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go119: {
			Image: "playwithgo/go1.19.1:6d8215b3a5eda6d3bcf338c58a26194abe18b4cd"
		}
	}
}]
Scenarios: [{
	Name:        "go119"
	Description: "Go 1.15"
}]
Networks: ["playwithgo_pwg"]
Env: []
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
		StepType: 1
		Name:     "run_script"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "bash /home/gopher/script.sh"
			ExitCode: 0
			Output: """
				Hello, world!

				"""
		}]
	}
}
Hash: "608f7aeee182a2f487f8bd308e9f91e4508a7706aaa422413d1cc764c61b79df"
Delims: ["{{{", "}}}"]
