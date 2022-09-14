#=====================================================================================================

# Faz download do OPA

#======================================================================================================

curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64

chmod 755 ./opa

#=====================================================================================================

# Aplica validação do Open Polyce Agent para Kubernetes

#======================================================================================================


declare result=`./opa eval --format pretty --fail-defined --input ./contract/contract.json --data ./contract/contract.rego 'data.openapi.police.errors'`

BREAK=$'\n'
message=""

for ROW in $(echo "${result}" | jq -r '.[]'); do
    message+="${BREAK}"
    message+=$"${ROW}"
done

#=====================================================================================================

# Registra no JIRA as ocorrências de erros

#======================================================================================================

curl --location --request POST 'https://sensedia.atlassian.net/rest/api/3/issue?updateHistory=true&applyDefaultValues=false' \
--header 'Authorization: Basic Z2FicmllbC5ib3JnZXNAc2Vuc2VkaWEuY29tOmxGQ05BZFJLWmpIczRlVENyQ0U0NzlDRA==' \
--header 'Content-Type: application/json' \
--data-raw "{
    ""\"fields""\": {
        ""\"project""\": {
            ""\"id""\": ""\"13983""\"
        },
        ""\"issuetype""\": {
            ""\"id""\": ""\"11395""\"
        },
        ""\"summary""\": ""\"[OPA]- Pipeline error""\",
        ""\"description""\": {
            ""\"version""\": 1,
            ""\"type""\": ""\"doc""\",
            ""\"content""\": [
                {
                    ""\"type""\": ""\"paragraph""\",
                    ""\"content""\": [
                        {
                            ""\"type""\": ""\"text""\",
                            ""\"text""\": ""\"'$(echo $message)'""\"
                        }
                    ]
                }
            ]
        },
        ""\"labels""\": [],
        ""\"reporter""\": {
            ""\"id""\": ""\"62b08740dcafd965c5dceb10""\"
        }
    },
    ""\"update""\": {}}"


if [ "$result" != "[]" ]; then
     echo "One or more policies are violated: $result"
     exit 1
fi

