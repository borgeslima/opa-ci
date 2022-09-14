#!/bin/bash

chmod 755 ./contract-polices.sh
chmod 755 ./kubernetes-polices.sh

bash ./contract.sh
bash ./kubernetes.sh