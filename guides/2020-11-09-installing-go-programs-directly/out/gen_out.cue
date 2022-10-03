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
	Description: "Go 1.16"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	goversion: {
		StepType: 1
		Name:     "goversion"
		Order:    0
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version"
			ExitCode: 0
			Output:   "go version go1.19.1 linux/amd64"
		}]
	}
	go119_mkcert_install: {
		StepType: 1
		Name:     "go119_mkcert_install"
		Order:    1
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go install filippo.io/mkcert@v1.4.4"
			ExitCode: 0
			Output: """
				go: downloading filippo.io/mkcert v1.4.4
				go: downloading golang.org/x/net v0.0.0-20220421235706-1d1ef9303861
				go: downloading software.sslmate.com/src/go-pkcs12 v0.2.0
				go: downloading golang.org/x/text v0.3.7
				go: downloading golang.org/x/crypto v0.0.0-20220331220935-ae2d96664a29

				"""
		}]
	}
	which_mkcert: {
		StepType: 1
		Name:     "which_mkcert"
		Order:    2
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "which mkcert"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert

				"""
		}]
	}
	run_mkcert: {
		StepType: 1
		Name:     "run_mkcert"
		Order:    3
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "mkcert -version"
			ExitCode: 0
			Output: """
				v1.4.4

				"""
		}]
	}
	goversion_mkcert: {
		StepType: 1
		Name:     "goversion_mkcert"
		Order:    4
		Terminal: "term1"
		Stmts: [{
			CmdStr:   "go version -m $(which mkcert)"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert: go1.19.1
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.4\th1:8eVbbwfVlaqUM7OwuftKc2nuYOoTDQWqsoXmzoXZdbc=
				\tdep\tgolang.org/x/crypto\tv0.0.0-20220331220935-ae2d96664a29\th1:tkVvjkPTB7pnW3jnid7kNyAMPVWllTNOf/qKDze4p9o=
				\tdep\tgolang.org/x/net\tv0.0.0-20220421235706-1d1ef9303861\th1:yssD99+7tqHWO5Gwh81phT+67hg+KttniBr6UnEXOY8=
				\tdep\tgolang.org/x/text\tv0.3.7\th1:olpwvP2KacW1ZWvsR7uQhoyTYvKAupfQrRGBFM352Gk=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.2.0\th1:nlFkj7bTysH6VkC4fGphtjXRbezREPgrHuJG20hBGPE=

				"""
		}]
	}
}
Hash: "e02e44a4f6bb7d7b6fde80ddd0078920a147a3f750d737746f64df50cb0d2e5f"
Delims: ["{{{", "}}}"]
