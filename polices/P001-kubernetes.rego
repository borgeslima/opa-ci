package kubernetes.admission

import future.keywords.if

# Valida o uso máximo de cpu que um deployment pode suportar por requisição.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not cpurequest(container)
	reason := "[REF01] - Limite de uso de cpu por request não definido! https://confluence.b.com.br/REF-01"
}

# Valida o uso máximo de memória que um deployment pode suportar por requisição.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not memoryrequest(container)
	reason := "[REF02] - Limite de uso de memoria por request não definido! https://confluence.b.com.br/REF-01"
}

# Valida o uso máximo de CPU que um deployment pode consumir em runtime.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not cpulimit(container)
	reason := "[REF03] - Limite de uso de CPU não definido no deployment! https://confluence.b.com.br/REF-01"
}

# Valida o uso máximo de memória que um deployment pode consumir em runtime.
errors[reason] {
	container := input.spec.template.spec.containers[_]
	not memorylimit(container)
	reason := "[REF04] - Limite de uso memoria não definido no deployment! https://confluence.b.com.br/REF-01"
}


# Valida o máximo de replica que um deployment pode consumir em runtime.

errors[reason] {
	replica := input.spec.replicas
	maxReplica(replica)
	reason := "[REF05] - Limite máximo de replica é 2! https://confluence.b.com.br/REF-01"
}

# Valida o máximo de replica que um deployment pode consumir em runtime.

errors[reason] {
	not input.metadata.labels.tier
	reason := "[REF06] - Torre não informado! https://confluence.b.com.br/REF-01"
}


maxReplica(replica) if {
	replica > 2
}


memorylimit(container) if {
	container.resources.limits.memory
}

cpulimit(container) if {
	container.resources.limits.cpu
}

memoryrequest(container) if {
	container.resources.requests.memory
}

cpurequest(container) if {
	container.resources.requests.cpu
}
