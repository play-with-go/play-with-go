package out

Terminals: [{
	Description: "The main terminal"
	Scenarios: {
		go116: {
			Image: "playwithgo/go1.16-tip@sha256:af9da82837751157485d9c2008b4ad950037502d9d18715cb1e617f4b2d6f169"
		}
	}
	Name: "term1"
}]
Scenarios: [{
	Description: "Go 1.16"
	Name:        "go116"
}]
Networks: ["playwithgo_pwg"]
Env: []
Steps: {
	goversion: {
		Stmts: [{
			ComparisonOutput: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

				"""
			Output: """
				go version devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000 linux/amd64

				"""
			ExitCode: 0
			CmdStr:   "go version"
			Negated:  false
		}]
		Order:           0
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion"
	}
	go115_mkcert_get: {
		Stmts: [{
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
			ExitCode: 0
			CmdStr:   "go get filippo.io/mkcert@v1.4.2"
			Negated:  false
		}]
		Order:           1
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go115_mkcert_get"
	}
	go115_mkcert_modules_get: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "(cd $(mktemp -d); GO111MODULE=on go get filippo.io/mkcert@v1.4.2)"
			Negated:          false
		}]
		Order:           2
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go115_mkcert_modules_get"
	}
	go116_mkcert_install: {
		Stmts: [{
			ComparisonOutput: ""
			Output:           ""
			ExitCode:         0
			CmdStr:           "go install filippo.io/mkcert@v1.4.2"
			Negated:          false
		}]
		Order:           3
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "go116_mkcert_install"
	}
	which_mkcert: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert

				"""
			Output: """
				/home/gopher/go/bin/mkcert

				"""
			ExitCode: 0
			CmdStr:   "which mkcert"
			Negated:  false
		}]
		Order:           4
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "which_mkcert"
	}
	run_mkcert: {
		Stmts: [{
			ComparisonOutput: """
				v1.4.2

				"""
			Output: """
				v1.4.2

				"""
			ExitCode: 0
			CmdStr:   "mkcert -version"
			Negated:  false
		}]
		Order:           5
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "run_mkcert"
	}
	goversion_mkcert: {
		Stmts: [{
			ComparisonOutput: """
				/home/gopher/go/bin/mkcert: devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.2\th1:7mWofpFS4gzQS5bhE3KYBwzfceIPy2KJ4tMT31aPNeY=
				\tdep\tgolang.org/x/net\tv0.0.0-20190620200207-3b0461eec859\th1:R/3boaszxrf1GEUWTVDzSKVwLmSJpwZ1yqXm8j0v2QI=
				\tdep\tgolang.org/x/text\tv0.3.0\th1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.0.0-20180114231543-2291e8f0f237\th1:iAEkCBPbRaflBgZ7o9gjVUuWuvWeV4sytFWg9o+Pj2k=

				"""
			Output: """
				/home/gopher/go/bin/mkcert: devel +7307e86afd Sun Nov 8 12:19:55 2020 +0000
				\tpath\tfilippo.io/mkcert
				\tmod\tfilippo.io/mkcert\tv1.4.2\th1:7mWofpFS4gzQS5bhE3KYBwzfceIPy2KJ4tMT31aPNeY=
				\tdep\tgolang.org/x/net\tv0.0.0-20190620200207-3b0461eec859\th1:R/3boaszxrf1GEUWTVDzSKVwLmSJpwZ1yqXm8j0v2QI=
				\tdep\tgolang.org/x/text\tv0.3.0\th1:g61tztE5qeGQ89tm6NTjjM9VPIm088od1l6aSorWRWg=
				\tdep\tsoftware.sslmate.com/src/go-pkcs12\tv0.0.0-20180114231543-2291e8f0f237\th1:iAEkCBPbRaflBgZ7o9gjVUuWuvWeV4sytFWg9o+Pj2k=

				"""
			ExitCode: 0
			CmdStr:   "go version -m $(which mkcert)"
			Negated:  false
		}]
		Order:           6
		InformationOnly: false
		DoNotTrim:       false
		Terminal:        "term1"
		StepType:        1
		Name:            "goversion_mkcert"
	}
}
Hash: "9ea49ee3b141a06c9945fd37de54c955d45a74b4b078310c12c2cc351d65956a"
Delims: ["{{{", "}}}"]
