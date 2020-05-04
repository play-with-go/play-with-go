package preguide

#Guide: {
	PreStep?: {
		Package: string
		Args: [...string]
	}
	// We can't make this conditional on len(Steps) because
	// of cuelang.org/issue/279. Hence we validate in code
	Image?: string
	Steps: [string]: en: #Command | #CommandFile | #Upload | #UploadFile
	Defs: [string]: _
}

#Command: {
	#IsCommand: true
	Source:     string
}

#CommandFile: {
	#IsCommandFile: true
	Path:           string
}

#Upload: {
	#IsUpload: true
	Target:    string
	Source:    string
}

#UploadFile: {
	#IsUpload: true
	Target:    string
	Path:      string
}
