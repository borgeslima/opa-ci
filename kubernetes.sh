#=====================================================================================================

# Faz download do OPA

#======================================================================================================

curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64

chmod 755 ./opa

#=====================================================================================================

# Faz download da regra que será usada para validação

#======================================================================================================


curl -L -o P001-kubernetes.rego https://raw.githubusercontent.com/borgesarch/opa-ci-polices/master/polices/kubernetes/P001-kubernetes.rego
chmod 755 P001-kubernetes.rego
mv P001-kubernetes.rego ./polices/P001-kubernetes.rego

#=====================================================================================================

# Aplica validação do Open Polyce Agent para Kubernetes

#======================================================================================================

BREAK=$'\n'
message=""

declare result=`./opa eval --format pretty --fail-defined --input ./kubernetes/deploy.json --data ./polices/P001-kubernetes.rego 'data.kubernetes.admission.errors'`


for ROW in $(echo "${result}" | jq -r '.[]'); do
    message+="${BREAK}"
    message+=$"${ROW}"
done

#=====================================================================================================

# Registra no JIRA as ocorrências de erros

#======================================================================================================





if [ "$result" != "[]" ]; then
     echo "One or more policies are violated: $result"

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
             ""\"summary""\": ""\"[OPA] - [TIER-PIX] - Pipeline error""\",
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


     exit 1
fi
