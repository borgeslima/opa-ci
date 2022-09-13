

result=`./opa eval --format pretty --fail-defined --input contract.json --data contract.rego 'data.openapi.police.erros'`

if [ "$result" != "[]" ]; then
     echo "One or more policies are violated: $result"
     
fi
