package openapi.police

import future.keywords.if

errors[reason] {
	not input.openapi == "3.0.3"
	reason := "Versão não pode ser superior a 3.0.1!"
}

errors[reason] {
	not input.info.title
	reason := "Informação de tilulo não informado!"
}

errors[reason] {
	not input.info.description
	reason := "Informação de descrição não informado!"
}

errors[reason] {
	not input.info.license.name
	reason := "Informação de licença não informado!"
}

errors[reason] {
	not input.info.version
	reason := "Informação de versão não informado!"
}
