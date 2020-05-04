package out

#GuideOutput: {
	PreStep: {
		Package: string
		Version: string
		BuildID: string
		Args: [...string]
	}
	Image: string
	Langs: #Langs
	Defs: [string]: _
}

#Langs: {
	en: #LangSteps
}

#LangSteps: {
	Hash:  string
	Steps: #Steps
}

#Steps: {
	[string]: #CommandStep | #UploadStep
}

#CommandStep: {
	Name:  string
	Order: int
	Stmts: [...#Stmt]
}

#Stmt: {
	Negated:  bool
	CmdStr:   string
	ExitCode: int
	Output:   string
}

#UploadStep: {
	Name:   string
	Order:  int
	Source: string
	Target: string
}
