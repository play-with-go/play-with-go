package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16@sha256:3ae1950433998a2be8c8ce3b1cb6479e6541f1e32443447a24085cfe09e2c391"
		}
	}
}]
Scenarios: [{
	Name:        "go116"
	Description: "Go 1.16"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	goversion: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version"
			ExitCode: 0
			Output: """
				go version go1.16 linux/amd64

				"""
			ComparisonOutput: """
				go version go1.16 linux/amd64

				"""
		}]
	}
	go115_mkcert_get: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go115_mkcert_get"
		Order:           1
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go get filippo.io/mkcert@v1.4.2"
			ExitCode: 0
			Output: """
				go: downloading filippo.io/mkcert v1.4.2
				go: downloading golang.org/x/net v0.0.0-20190620200207-3b0461eec859
				go: downloading golang.org/x/tools v0.0.0-20191108193012-7d206e10da11
				go: downloading honnef.co/go/tools v0.0.0-20191107024926-a9480a3ec3bc
				go: downloading howett.net/plist v0.0.0-20181124034731-591f970eefbb
				go: downloading software.sslmate.com/src/go-pkcs12 v0.0.0-20180114231543-2291e8f0f237
				go: downloading golang.org/x/text v0.3.0
				go: downloading github.com/BurntSushi/toml v0.3.1

				"""
			ComparisonOutput: """

				go: downloading filippo.io/mkcert v1.4.2
				go: downloading github.com/BurntSushi/toml v0.3.1
				go: downloading golang.org/x/net v0.0.0-20190620200207-3b0461eec859
				go: downloading golang.org/x/text v0.3.0
				go: downloading golang.org/x/tools v0.0.0-20191108193012-7d206e10da11
				go: downloading honnef.co/go/tools v0.0.0-20191107024926-a9480a3ec3bc
				go: downloading howett.net/plist v0.0.0-20181124034731-591f970eefbb
				go: downloading software.sslmate.com/src/go-pkcs12 v0.0.0-20180114231543-2291e8f0f237
				"""
		}]
	}
	go115_mkcert_modules_get: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go115_mkcert_modules_get"
		Order:           2
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "(cd $(mktemp -d); GO111MODULE=on go get filippo.io/mkcert@v1.4.2)"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	go116_mkcert_install: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go116_mkcert_install"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "go install filippo.io/mkcert@v1.4.2"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}]
	}
	which_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "which_mkcert"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "which mkcert"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert

				"""
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert

				"""
		}]
	}
	run_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "run_mkcert"
		Order:           5
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "mkcert -version"
			ExitCode: 0
			Output: """
				v1.4.2

				"""
			ComparisonOutput: """
				v1.4.2

				"""
		}]
	}
	goversion_mkcert: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "goversion_mkcert"
		Order:           6
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go version -m $(which mkcert)"
			ExitCode: 0
			Output: """
				/home/gopher/go/bin/mkcert: go1.16
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.2\th1:7mWofpFS4gzQS5bhE3KYBwzfceIPy2KJ4tMT31aPNeY=
				\tdep\tgolang.org/x/net\tv0.0.0-20190620200207-3b0461eec859\th1:R/3boaszxrf1GEUWTVDzSKVwLmSJpwZ1yqXm8j0v2QI=
				\tdep\tgolang.org/x/text\tv0.3.0\th1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.0.0-20180114231543-2291e8f0f237\th1:iAEkCBPbRaflBgZ7o9gjVUuWuvWeV4sytFWg9o+Pj2k=

				"""
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert: go1.16
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.2\th1:7mWofpFS4gzQS5bhE3KYBwzfceIPy2KJ4tMT31aPNeY=
				\tdep\tgolang.org/x/net\tv0.0.0-20190620200207-3b0461eec859\th1:R/3boaszxrf1GEUWTVDzSKVwLmSJpwZ1yqXm8j0v2QI=
				\tdep\tgolang.org/x/text\tv0.3.0\th1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.0.0-20180114231543-2291e8f0f237\th1:iAEkCBPbRaflBgZ7o9gjVUuWuvWeV4sytFWg9o+Pj2k=

				"""
		}]
	}
}
Hash: "43b2d82b6689982a300d22dbbb308d1dc8fa2143c31b094dc6ac2a67dc372438"
Delims: ["{{{", "}}}"]
