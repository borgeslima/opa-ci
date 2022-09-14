package openapi.police

import future.keywords.if

errors[reason] {
	not input.openapi == "3.0.3"
	reason := "[REF01] - Versão não pode ser superior a 3.0.1! - https://confluence.b.net/REF01"
}

errors[reason] {
	not input.info.title
	reason := "[REF02] - Versão não pode ser superior a 3.0.1! - https://confluence.b.net/REF02"
}

errors[reason] {
	not input.info.description
	reason := "[REF03] - Versão não pode ser superior a 3.0.1! - https://confluence.b.net/REF03!"
}

errors[reason] {
	not input.info.license.name
	reason := "[REF04] - Versão não pode ser superior a 3.0.1! - https://confluence.b.net/REF04!"
}

errors[reason] {
	not input.info.version
	reason := "[REF05] - Versão não pode ser superior a 3.0.1! - https://confluence.b.net/REF05!"
}
