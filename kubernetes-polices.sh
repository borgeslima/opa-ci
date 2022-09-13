curl -L -o opa https://openpolicyagent.org/downloads/latest/opa_linux_amd64

chmod 755 ./opa


declare admission_result=`./opa eval --format pretty --fail-defined --input ./kubernetes/deploy.json --data ./kubernetes/admission.rego 'data.kubernetes.admission.errors'`

if [ "$admission_result" != "[]" ]; then
     echo "One or more policies are violated: $admission_result"
     exit 1
fi
