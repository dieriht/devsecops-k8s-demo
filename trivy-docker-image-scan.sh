#!/bin/bash

dockerImageName=$(awk 'NR==1 {print $2}' Dockerfile)
echo $dockerImageName

docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.18.3 -q image --exit-code 0 --severity HIGH --light openjdk:8-jdk-alpine
docker run --rm -v $WORKSPACE:/root/.cache/ aquasec/trivy:0.18.3 -q image --exit-code 1 --severity CRITICAL --light openjdk:8-jdk-alpine


   
