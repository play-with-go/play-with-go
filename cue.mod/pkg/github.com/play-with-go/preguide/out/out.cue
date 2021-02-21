package out

import "github.com/play-with-go/preguide"

#GuideOutput: {
	Delims: [string, string]
	FilenameComment: bool
	Presteps: [...#Prestep]
	Terminals: [...preguide.#Terminal]
	Scenarios: [...preguide.#Scenario]
	Hash: string
	Steps: [string]: #Step
	Networks: [...string]
	Env: [...string]
}

_stepCommon: {
	StepType: #StepType
	Name:     string
	Order:    int
	Terminal: string
}

// TODO: keep this in sync with the Go definitions
#StepType: int

#StepTypeCommand: #StepType & 1
#StepTypeUpload:  #StepType & 2

#Prestep: {
	Package: string
	Path:    string
	Args:    _
	Version: string

	// Variables is the set of environment variables that resulted
	// from the execution of the prestep
	Variables: [...string]
}

#Step: (#CommandStep | #UploadStep) & _stepCommon

#CommandStep: {
	_stepCommon
	DoNotTrim:       bool
	RandomReplace:   string
	InformationOnly: bool
	Stmts: [...#Stmt]
}

#Stmt: {
	Negated:          bool
	CmdStr:           string
	ExitCode:         int
	Output:           string
	ComparisonOutput: string
}

#UploadStep: {
	_stepCommon
	Renderer: preguide.#Renderer
	Language: string
	Source:   string
	Target:   string
}

// GuideStructures maps a guide name to its #GuideStructure
#GuideStructures: [string]: #GuideStructure

// A #GuideStructure defines the prestep and terminal
// structure of a guide. Note there is some overlap here
// with the #GuideOutput type above... perhaps we can
// conslidate at some point. The main difference is that
// GuideStructure is a function of the input types.
#GuideStructure: {
	Delims: [string, string]
	Presteps: [...preguide.#Prestep]
	Terminals: [...preguide.#Terminal]
	Scenarios: [...preguide.#Scenario]
	Networks: [...string]
	Env: [...string]
}
