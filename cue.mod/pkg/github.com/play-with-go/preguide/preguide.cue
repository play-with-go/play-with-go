package preguide

import (
	"list"
	"path"
	"regexp"
)

// TODO: keep this in sync with the Go definitions
#StepType: int

#StepTypeCommand:     #StepType & 1
#StepTypeCommandFile: #StepType & 2
#StepTypeUpload:      #StepType & 3
#StepTypeUploadFile:  #StepType & 4

#Guide: {

	#Step: (#Command | #CommandFile | #Upload | #UploadFile ) & _#stepCommon

	_#stepCommon: {
		Name:     string
		StepType: #StepType
		Terminal: string
		...
	}

	_#uploadCommon: {
		// The language of the content being uploaded, e.g. go
		// This gets used on the markdown code block, hence the
		// values supported here are a function of the markdown
		// parse on the other end.
		Target:   string
		Language: *regexp.FindSubmatch("^.(.*)", path.Ext(Target))[1] | string
		...
	}

	#Command: {
		_#stepCommon
		StepType: #StepTypeCommand
		Source:   string
	}

	#CommandFile: {
		_#stepCommon
		StepType: #StepTypeCommandFile
		Path:     string
	}

	#Upload: {
		_#stepCommon
		_#uploadCommon
		StepType: #StepTypeUpload
		Source:   string
	}

	#UploadFile: {
		_#stepCommon
		_#uploadCommon
		StepType: #StepTypeUploadFile
		Path:     string
	}

	#Terminal: {
		Name:        string
		Description: string
		Scenarios: [string]: #TerminalScenario
	}

	#TerminalScenario: {
		Image: string
	}

	// Networks is the list of docker networks to connect to when running
	// this guide.
	Networks: [...string]

	// Env is the environment to pass to docker containers when running
	// this guide.
	Env: [...string]

	Presteps: [...#Prestep]

	// Delims are the delimiters used in the guide prose and steps
	// for environment variable substitution. A template substitution
	// of the environment variable ABC therefore looks like "{{ .ABC }}"
	Delims: *["{{", "}}"] | [string, string]

	Steps: [string]: [#Language]: #Step

	Steps: [name=string]: [#Language]: {
		// TODO: remove post upgrade to latest CUE? Because at that point
		// the defaulting in #TerminalName will work
		Terminal: *#TerminalNames[0] | string

		Name: name
	}

	// Scenarios define the various images under which this guide will be
	// run
	Scenarios: [string]: #Scenario
	Scenarios: [name=string]: {
		Name: name
	}

	_#ScenarioName: or([ for name, _ in Scenarios {name}])

	for scenario, _ in Scenarios for terminal, _ in Terminals {
		Terminals: "\(terminal)": Scenarios: "\(scenario)": #TerminalScenario
	}

	// TODO: remove post upgrade to latest CUE? Because at that point
	// the use of or() will work, which will give a better error message
	#TerminalNames: [ for k, _ in Terminals {k}]
	#ok: true & and([ for s in Steps for l in s {list.Contains(#TerminalNames, l.Terminal)}])

	// Terminals defines the required remote VMs for a given guide
	Terminals: [string]: #Terminal

	Terminals: [name=string]: {
		Name: name
	}

	Defs: [string]: _
}

#Scenario: {
	Name:        string
	Description: string
}

#Prestep: {
	Package: string
	Path:    *"/" | string
	Args:    *null | _
}

// TODO: keep in sync with Go code
#Language: "ab" | "aa" | "af" | "ak" | "sq" | "am" | "ar" | "an" | "hy" | "as" | "av" | "ae" | "ay" | "az" | "bm" | "ba" | "eu" | "be" | "bn" |
	"bh" | "bi" | "bs" | "br" | "bg" | "my" | "ca" | "ch" | "ce" | "ny" | "zy" | "cv" | "kw" | "co" | "cr" | "hr" | "cs" | "da" | "dv" |
	"nl" | "dz" | "en" | "eo" | "et" | "ee" | "fo" | "fj" | "fi" | "fr" | "ff" | "gl" | "ka" | "de" | "el" | "gn" | "gu" | "ht" | "ha" |
	"he" | "hz" | "hi" | "ho" | "hu" | "ia" | "id" | "ie" | "ga" | "ig" | "ik" | "io" | "is" | "it" | "iu" | "ja" | "jv" | "kl" | "kn" |
	"kr" | "ks" | "kk" | "km" | "ki" | "rw" | "ky" | "kv" | "kg" | "ko" | "ku" | "kj" | "la" | "lb" | "lg" | "li" | "ln" | "lo" | "lt" |
	"lu" | "lv" | "gv" | "mk" | "mg" | "ms" | "ml" | "mt" | "mi" | "mr" | "mh" | "mn" | "na" | "nv" | "nd" | "ne" | "ng" | "nb" | "nn" |
	"no" | "ii" | "nr" | "oc" | "oj" | "cu" | "om" | "or" | "os" | "pa" | "pi" | "fa" | "pl" | "ps" | "pt" | "qu" | "rm" | "rn" | "ro" |
	"ru" | "sa" | "sc" | "sd" | "se" | "sm" | "sg" | "sr" | "gd" | "sn" | "si" | "sk" | "sl" | "so" | "st" | "es" | "su" | "sw" | "ss" |
	"sv" | "ta" | "te" | "tg" | "th" | "ti" | "bo" | "tk" | "tl" | "tn" | "to" | "tr" | "ts" | "tt" | "tw" | "ty" | "ug" | "uk" | "ur" |
	"uz" | "ve" | "vi" | "vo" | "wa" | "cy" | "wo" | "fy" | "xh" | "yi" | "yo" | "za" | "zu"

// The following definitions necessarily reference the nested definitions
// in #Guide, because those definitions rely on references to Terminals
// which only makes sense in the context of a #Guide instance

#Step:        #Guide.#Step
#Command:     #Guide.#Command
#CommandFile: #Guide.#CommandFile
#Upload:      #Guide.#Upload
#UploadFile:  #Guide.#UploadFile

// #PrestepServiceConfig is a mapping from prestep package path to endpoint
// configuration.
#PrestepServiceConfig: [string]: #PrestepConfig

// #PrestepConfig is the endpoint configuration for a prestep
#PrestepConfig: {
	Endpoint: string

	// Networks defines the list of docker networks to connect to when
	// running this prestep.
	Networks: [...string]

	// Env is the environment to pass to docker containers when running
	// this prestep.
	Env: [...string]
}

// Post upgrade to latest CUE we have a number of things to change/test, with /
// reference to https://gist.github.com/myitcv/399ed50f792b49ae7224ee5cb3e504fa#file-304b02e-cue
//
// 1. Move to the use of #TerminalName (probably hidden) as a type for a terminal's
// name in _#stepCommon
// 2. Try and move to the advanced definition of Steps: [string]: [lang] to be the
// disjunction of #Step or [scenario]: #Step
// 3. Ensure that a step's name can be defaulted for this advanced definition (i.e.
// that if a step is specified at the language level its name defaults, but also
// if it is specified at the scenario level)
