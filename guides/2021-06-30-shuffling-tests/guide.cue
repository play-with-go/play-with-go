package guide

import (
	"github.com/play-with-go/preguide"
)

Defs: {
	_#commonDefs
	gopherkv:                     "gopherkv"
	gopherkv_dir:                 "/home/gopher/\(gopherkv)"
	gopherkv_go:                  "\(gopherkv).go"
	gopherkv_test_go:             "\(gopherkv)_test.go"
	gopherkv_mod:                 "\(gopherkv)"
}

Scenarios: go117: preguide.#Scenario & {
	Description: "Go 1.17"
}

Terminals: term1: preguide.#Terminal & {
	Description: "The main terminal"
	Scenarios: go117: Image: _#go117LatestImage
}

Steps: gopherkv_create: preguide.#Command & {
	Source: """
		mkdir \(Defs.gopherkv_dir)
		cd \(Defs.gopherkv_dir)
		go mod init \(Defs.gopherkv_mod)
		"""
}


Steps: gopherkv_initial: preguide.#Upload & {
	Target:   "\(Defs.gopherkv_dir)/\(Defs.gopherkv_go)"
	//Renderer: preguide.#RenderDiff
	Source:   #"""
		package \#(Defs.gopherkv)

		type KV struct {
			data map[string]string
		}

		func Create(size uint) *KV {
			return &KV{
				data: make(map[string]string, size),
			}
		}

		func (kv *KV) Get(key string) (string, bool) {
			v, ok := kv.data[key]
			return v, ok
		}

		func (kv *KV) Set(key, value string) {
			kv.data[key] = value
		}

		func (kv *KV) Purge() {
			kv.data = make(map[string]string)
		}
		"""#
}

Steps: gopherkv_initial_test: preguide.#Upload & {
	Target:   "\(Defs.gopherkv_dir)/\(Defs.gopherkv_test_go)"
	//Renderer: preguide.#RenderDiff
	Source:   #"""
		package \#(Defs.gopherkv)

		import "testing"

		var kv *KV

		func TestCreateKV(t *testing.T) {
			kv = Create(512)
			if kv == nil {
				t.Errorf("expected newly created kv store to not be nil")
			}
		}

		func TestSet(t *testing.T) {
			kv.Set("foo", "bar")

			if len(kv.data) != 1 {
				t.Errorf("expected exactly one value to be set")
			}
		}

		func TestGet(t *testing.T) {
			val, exists := kv.Get("foo")
			if val != "bar" || !exists {
				t.Errorf("expected foo:bar pair to have been fetched correctly")
			}
		}

		func TestPurge(t *testing.T) {
			kv.Purge()
			lenNew := len(kv.data)

			if lenNew != 0 {
				t.Errorf("expected a length of 0 after purging")
			}
		}
		"""#
}

Steps: go_test_initial: preguide.#Command & {
	Source: """
		go test -cover ./... 
		"""
}

Steps: go_test_shuffle_100: preguide.#Command & {
	Source: """
		go test -shuffle=5  ./... || true
		"""
}

