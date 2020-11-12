package gitea

import "github.com/play-with-go/preguide"

_#gitea: preguide.#Prestep & {
	Package: "github.com/play-with-go/gitea"
}

#PrestepNewUser: _#gitea & {
	Path: "/newuser"
	Args: #NewUser
}

// Establish the default value for the pattern
#Repo: Pattern: *"*" | string
#Repo: Private: *false | bool
