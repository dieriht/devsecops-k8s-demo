#!/bin/bash

applicationURL=$(http://devsecops-demo.eastus.cloudapp.azure.com)
PORT=$(kubectl get services devsecops-svc -o json | jq .spec.ports[].nodePort)

# first run this
chmod 777 $(pwd)
echo $(id -u):$(id -g)
#docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $IP:$PORT -f openapi -r zap_report.html
sudo docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT -f openapi -r zap_report.html

exit_code=$?

# comment above cmd and uncomment below lines to run with CUSTOM RULES
# docker run -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-weekly zap-api-scan.py -t $applicationURL:$PORT/v3/api-docs -f openapi -c zap-rules -w report.md -J json_report.json -r zap_report.html

# HTML Report
 sudo mkdir -p owasp-zap-report
 sudo mv zap_report.html owasp-zap-report


echo "Exit Code : $exit_code"

 if [[ ${exit_code} -ne 0 ]];  then
    echo "OWASP ZAP Report has either Low/Medium/High Risk. Please check the HTML Report"
    exit 1;
   else
    echo "OWASP ZAP did not report any Risk"
 fi;