curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64

chmod 755 ./opa

declare result=`./opa eval --format pretty --fail-defined --input ./contract/contract.json --data ./contract/contract.rego 'data.openapi.police.erros'`

if [ "$result" != "[]" ]; then
     echo "One or more policies are violated: $result"
     exit 1
fi
