package out

Terminals: [{
	Name:        "term1"
	Description: "The main terminal"
	Scenarios: {
		go117: {
			Image: "tpaschalis-gotip"
		}
	}
}]
Scenarios: [{
	Name:        "go117"
	Description: "Go 1.17"
}]
Networks: ["playwithgo_pwg"]
Env: []
FilenameComment: false
Steps: {
	gopherkv_create: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "gopherkv_create"
		Order:           0
		Terminal:        "term1"
		Stmts: [{
			Negated:          false
			CmdStr:           "mkdir /home/gopher/gopherkv"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:          false
			CmdStr:           "cd /home/gopher/gopherkv"
			ExitCode:         0
			Output:           ""
			ComparisonOutput: ""
		}, {
			Negated:  false
			CmdStr:   "go mod init gopherkv"
			ExitCode: 0
			Output: """
				go: creating new go.mod: module gopherkv

				"""
			ComparisonOutput: """
				go: creating new go.mod: module gopherkv

				"""
		}]
	}
	gopherkv_initial: {
		StepType: 2
		Name:     "gopherkv_initial"
		Order:    1
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package gopherkv

			type KV struct {
			\tdata map[string]string
			}

			func Create(size uint) *KV {
			\treturn &KV{
			\t\tdata: make(map[string]string, size),
			\t}
			}

			func (kv *KV) Get(key string) (string, bool) {
			\tv, ok := kv.data[key]
			\treturn v, ok
			}

			func (kv *KV) Set(key, value string) {
			\tkv.data[key] = value
			}

			func (kv *KV) Purge() {
			\tkv.data = make(map[string]string)
			}
			"""
		Target: "/home/gopher/gopherkv/gopherkv.go"
	}
	gopherkv_initial_test: {
		StepType: 2
		Name:     "gopherkv_initial_test"
		Order:    2
		Terminal: "term1"
		Language: "go"
		Renderer: {
			RendererType: 1
		}
		Source: """
			package gopherkv

			import "testing"

			var kv *KV

			func TestCreateKV(t *testing.T) {
			\tkv = Create(512)
			\tif kv == nil {
			\t\tt.Errorf("expected newly created kv store to not be nil")
			\t}
			}

			func TestSet(t *testing.T) {
			\tkv.Set("foo", "bar")

			\tif len(kv.data) != 1 {
			\t\tt.Errorf("expected exactly one value to be set")
			\t}
			}

			func TestGet(t *testing.T) {
			\tval, exists := kv.Get("foo")
			\tif val != "bar" || !exists {
			\t\tt.Errorf("expected foo:bar pair to have been fetched correctly")
			\t}
			}

			func TestPurge(t *testing.T) {
			\tkv.Purge()
			\tlenNew := len(kv.data)

			\tif lenNew != 0 {
			\t\tt.Errorf("expected a length of 0 after purging")
			\t}
			}
			"""
		Target: "/home/gopher/gopherkv/gopherkv_test.go"
	}
	go_test_initial: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_test_initial"
		Order:           3
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go test -cover ./..."
			ExitCode: 0
			Output: """
				ok  \tgopherkv\t0.002s\tcoverage: 100.0% of statements

				"""
			ComparisonOutput: """
				ok  \tgopherkv\t0.002s\tcoverage: 100.0% of statements

				"""
		}]
	}
	go_test_shuffle_100: {
		StepType:        1
		DoNotTrim:       false
		InformationOnly: false
		Name:            "go_test_shuffle_100"
		Order:           4
		Terminal:        "term1"
		Stmts: [{
			Negated:  false
			CmdStr:   "go test -shuffle=5 ./... || true"
			ExitCode: 0
			Output: """
				-test.shuffle 5
				--- FAIL: TestGet (0.00s)
				    gopherkv_test.go:25: expected foo:bar pair to have been fetched correctly
				FAIL
				FAIL\tgopherkv\t0.002s
				FAIL

				"""
			ComparisonOutput: """
				-test.shuffle 5
				--- FAIL: TestGet (0.00s)
				    gopherkv_test.go:25: expected foo:bar pair to have been fetched correctly
				FAIL
				FAIL\tgopherkv\t0.002s
				FAIL

				"""
		}]
	}
}
Hash: "af76bb04ee3ea515fd442f2778bc531edbdb46550d1e4e353e73f00963055217"
Delims: ["{{{", "}}}"]
