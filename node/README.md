# Putatitive Node App

This directory contains a simple Node.JS application, as well as a Dockerfile
and helm chart to build the application.

## Files

* `app.js`
Main application file.  Starts a simple "Hello, World" server on port 8080.
* `Dockerfile`
Build app.js into a docker container
* `Makefile`
Simple makefile to build and release docker image
* `mfc-test-app`  
Simple Helm chart to deploy application on a K8s cluster
* `package.json`   
Node dependencies.
