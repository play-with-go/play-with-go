package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go115: {
			Image: "playwithgo/go1.15.2@sha256:4f5346af0d93f50c974d9be2f2f31c55d2f953da9437aac990d30a50e3d591a5"
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
Langs: {
	en: {
		Hash: "31a530c7d987fb4d3a698e2ea63f99a10f4a3d743b16ee3a79c11d12192605c6"
		Steps: {
			cat_readme: {
				Stmts: [{
					TrimmedOutput: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						We made a change!

						"""
					Output: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						We made a change!


						"""
					ExitCode: 0
					CmdStr:   "cat /home/gopher/readme.txt"
					Negated:  false
				}]
				Order:    4
				Terminal: "term1"
				StepType: 1
				Name:     "cat_readme"
			}
			upload_readme_again: {
				Order: 3
				Source: """
					This is /home/gopher/readme.txt.

					Hello, gopher!

					We made a change!

					"""
				Renderer: {
					Pre: """
						This is /home/gopher/readme.txt.

						Hello, gopher!

						"""
					RendererType: 3
				}
				Language: "txt"
				Target:   "/home/gopher/readme.txt"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme_again"
			}
			upload_readme: {
				Order: 2
				Source: """
					This is /home/gopher/readme.txt.

					Hello, gopher!

					"""
				Renderer: {
					RendererType: 1
				}
				Language: "txt"
				Target:   "/home/gopher/readme.txt"
				Terminal: "term1"
				StepType: 2
				Name:     "upload_readme"
			}
			multiple_commands: {
				Stmts: [{
					TrimmedOutput: "gopher"
					Output: """
						gopher

						"""
					ExitCode: 0
					CmdStr:   "whoami"
					Negated:  false
				}, {
					TrimmedOutput: "Hello, gopher!"
					Output: """
						Hello, gopher!

						"""
					ExitCode: 0
					CmdStr:   "echo \"Hello, gopher!\""
					Negated:  false
				}]
				Order:    1
				Terminal: "term1"
				StepType: 1
				Name:     "multiple_commands"
			}
			echo_hello: {
				Stmts: [{
					TrimmedOutput: "Hello, world!"
					Output: """
						Hello, world!

						"""
					ExitCode: 0
					CmdStr:   "echo \"Hello, world!\""
					Negated:  false
				}]
				Order:    0
				Terminal: "term1"
				StepType: 1
				Name:     "echo_hello"
			}
		}
	}
}
Delims: ["{{{", "}}}"]
