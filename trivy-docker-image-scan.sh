#!/bin/bash

dockerImageName=$(awk 'NR==1 {print $2}' Dockerfile)
echo $dockerImageName

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.18.3 -q image --exit-code 0 --severity HIGH --light openjdk:8-jdk-alpine
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.18.3 -q image --exit-code 1 --severity CRITICAL --light openjdk:8-jdk-alpine

trivy image --format template --template "@contrib/html.tpl" -o report.html openjdk:8-jdk-alpine

# HTML Report
 sudo mkdir -p trivy-report
 sudo mv trivy_report.html trivy-report


    # Trivy scan result processing
    exit_code=$?
    echo "Exit Code : $exit_code"

    # Check scan results
    if [[ "${exit_code}" == 1 ]]; then
        echo "Image scanning failed. Vulnerabilities found"
        exit 1;
    else
        echo "Image scanning passed. No CRITICAL vulnerabilities found"
    fi;
