package deps

//go:generate go run cuelang.org/go/cmd/cue cmd vendorgithubschema .
//go:generate ./vendor.sh github.com/play-with-go/preguide github.com/play-with-go/gitea
