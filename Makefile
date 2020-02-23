# -------------
# VARIABLES
# -------------
# Git variables

GIT_REPOSITORY_NAME := $(shell basename `git rev-parse --show-toplevel`)
GIT_VERSION := $(shell git describe --always --tags --long --dirty | sed -e 's/\-0//' -e 's/\-g.......//')

# -------------
# FUNCTIONS
# -------------


# -------------
# TASKS
# -------------
.PHONY: fmt
fmt:
	@gofmt -w -s -d configuration
	@gofmt -w -s -d main.go

.PHONY: build
build: fmt
	@go mod download && \
     go get ./... && \
     go install ./...

# -----------------------------------------------------------------------------
# The first "make" target runs as default.
# -----------------------------------------------------------------------------

.PHONY: default
default: help

# -----------------------------------------------------------------------------
# Copy files to docker build folder
# -----------------------------------------------------------------------------
.PHONY: copy-docker-files
copy-docker-files:
	@mkdir -p build/docker/$(GIT_REPOSITORY_NAME)
	@cp Makefile LICENSE README.md main.go go.mod go.sum build/docker/$(GIT_REPOSITORY_NAME)
	@cp -r configuration build/docker/$(GIT_REPOSITORY_NAME)

.PHONY: delete-docker-files
delete-docker-files:
	@rm -rf build/docker/$(GIT_REPOSITORY_NAME)

# -----------------------------------------------------------------------------
# Docker-based build
# -----------------------------------------------------------------------------

.PHONY: docker
docker: docker-rmi-for-build
	docker build \
	    --tag $(GIT_REPOSITORY_NAME) \
		--tag $(GIT_REPOSITORY_NAME):$(GIT_VERSION) \
		build/docker

.PHONY: docker-build
docker-build: copy-docker-files delete-docker-files

# -----------------------------------------------------------------------------
# Clean up targets
# -----------------------------------------------------------------------------

.PHONY: docker-rmi-for-build
docker-rmi-for-build:
	-docker rmi --force \
		$(GIT_REPOSITORY_NAME):$(GIT_VERSION) \
		$(GIT_REPOSITORY_NAME)

.PHONY: clean
clean: docker-rmi-for-build

# -----------------------------------------------------------------------------
# Help
# -----------------------------------------------------------------------------

.PHONY: help
help:
	@echo "List of make targets:"
	@$(MAKE) -pRrq -f $(lastword $(MAKEFILE_LIST)) : 2>/dev/null | awk -v RS= -F: '/^# File/,/^# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$' | xargs
