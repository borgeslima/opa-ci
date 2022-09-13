package kubernetes.admission

import future.keywords.if

# Valida o uso máximo de cpu que um deployment pode suportar por requisição.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not cpurequest(container)
	reason := "Limite de uso de cpu por request não definido!"
}

# Valida o uso máximo de memória que um deployment pode suportar por requisição.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not memoryrequest(container)
	reason := "Limite de uso de memoria por request não definido!"
}

# Valida o uso máximo de CPU que um deployment pode consumir em runtime.

errors[reason] {
	container := input.spec.template.spec.containers[_]
	not cpulimit(container)
	reason := "Limite de uso de CPU não definido no deployment!"
}

# Valida o uso máximo de memória que um deployment pode consumir em runtime.
errors[reason] {
	container := input.spec.template.spec.containers[_]
	not memorylimit(container)
	reason := "Limite de uso memoria não definido no deployment!"
}


# Valida o máximo de replica que um deployment pode consumir em runtime.

errors[reason] {
	replica := input.spec.replicas
	maxReplica(replica)
	reason := "Limite máximo de replica é 2!"
}

# Valida o máximo de replica que um deployment pode consumir em runtime.

errors[reason] {
	not input.metadata.labels.tier
	reason := "Torre não informado!"
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
