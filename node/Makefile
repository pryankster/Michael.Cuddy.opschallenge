#!/bin/env make
USERNAME=pryankster
VERSION=0.0.0

all:
	@echo "make docker"
	@echo "make docker-release VERSION=1.0.0"
	@echo "make run"

docker:
	docker build -t mfc-test-app .

docker-release:
	docker build -t $(USERNAME)/mfc-test-app:$(VERSION) .

run:
	-docker run -p8080:8080 mfc-test-app

# vim: set noexpandtab:
