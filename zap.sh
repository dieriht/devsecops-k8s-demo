#!/bin/bash


PORT=$(kubectl get services devsecops-svc -o json | jq .spec.ports[].nodePort)

# first run this
chmod 777 $(pwd)
echo $(id -u):$(id -g)

#sudo docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT -f openapi -r zap_report.html
sudo docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t https://apimngr-genesis-cert.azure-api.net/user-rol/usersandroles/v1/role/B2C_VISOR_ADMINISTRADOR -f openapi -r zap_report.html
# HTML Report
 sudo mkdir -p owasp-zap-report
 sudo mv zap_report.html owasp-zap-report

echo "Exit Code : $exit_code"

 if [[ ${exit_code} -ne 0 ]];  then
    echo "OWASP ZAP Report has either Low/Medium/High Risk. Please check the HTML Report"
    #exit 1;
   else
    echo "OWASP ZAP did not report any Risk"
 fi;