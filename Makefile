# ##############################################################################
#
# based on https://github.com/azer/go-makefile-example
#
# ##############################################################################

-include .env

VERSION := $(shell git describe --tags)
BUILD := $(shell git rev-parse --short HEAD)
PROJECTNAME := $(shell basename "$(PWD)")

BASE := $(shell pwd)

# Go related variables.
GOBASE := $(shell pwd)
GOPATH := $(GOBASE)/vendor:$(GOBASE)
GOBIN := $(GOBASE)/bin
GOFILES := $(wildcard *.go)

# Use linker flags to provide version/build settings
LDFLAGS=-ldflags "-X=main.Version=$(VERSION) -X=main.Build=$(BUILD)"

# Redirect error output to a file, so we can show it in development mode.
STDERR := /tmp/.$(PROJECTNAME)-stderr.txt

# PID file will keep the process id of the server
PID := /tmp/.$(PROJECTNAME).pid

# Make is verbose in Linux. Make it silent.
MAKEFLAGS += --silent

## install: Install missing dependencies. Runs `go get` internally. e.g; make install get=github.com/foo/bar
install: go-get

## start: Start in development mode. Auto-starts when code changes.
start:
	#@bash -c "trap 'make stop' EXIT; $(MAKE) clean compile start-server watch run='make clean compile start-server'"
	@echo "--- start"
	@echo "start npm"
	@-( cd frontend && npm run serve ) &
	@echo "start go"
	@-( cd backend &&  reflex -d none -s -R vendor. -r \.go$$ -- go run main.go ) &

## stop: Stop development mode.
stop:
	@echo "stop npm 0"
	@-ps -ef | grep npm | awk '{ print $$2 }' | xargs -I{} kill -9 {}
	@echo "stop npm 1"
	@-ps -ef | grep npm || true
	@echo "stop go"
	@-ps -ef | grep reflex | awk '{ print $$2 }' | xargs -I{} kill -9 {}
	@-ps -ef | grep reflex

start-server: stop-server
	#@echo "  >  $(PROJECTNAME) is available at $(ADDR)"
	#@-$(GOBIN)/$(PROJECTNAME) 2>&1 & echo $$! > $(PID)
	#@cat $(PID) | sed "/^/s/^/  \>  PID: /"

stop-server:
	#@-touch $(PID)
	#@-kill `cat $(PID)` 2> /dev/null || true
	#@-rm $(PID)

## watch: Run given command when code changes. e.g; make watch run="echo 'hey'"
watch:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) yolo -i . -e vendor -e bin -c "$(run)"

restart-server: stop-server start-server

## compile: Compile the binary.
compile:
	@-touch $(STDERR)
	@-rm $(STDERR)
	@-$(MAKE) -s go-compile 2> $(STDERR)
	@cat $(STDERR) | sed -e '1s/.*/\nError:\n/'  | sed 's/make\[.*/ /' | sed "/^/s/^/     /" 1>&2

## exec: Run given command, wrapped with custom GOPATH. e.g; make exec run="go test ./..."
exec:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) $(run)

## clean: Clean build files. Runs `go clean` internally.
clean:
	@echo "--- clean"
	@-rm -rf $(BASE)/backend/static/*
	@-rm backend/vue01
	#@-rm $(GOBIN)/$(PROJECTNAME)
	#@-$(MAKE) go-clean
	@echo "--- clean done"

prod:	clean
	@echo "--- prod"
	cd frontend && npm run build
	cp -r frontend/dist/* backend/static/
	cd backend && go build -o vue01
	@echo "--- prod done"

go-compile: go-get go-build

go-build:
	@echo "  >  Building binary..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go build $(LDFLAGS) -o $(GOBIN)/$(PROJECTNAME) $(GOFILES)

go-generate:
	@echo "  >  Generating dependency files..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go generate $(generate)

go-get:
	@echo "  >  Checking if there is any missing dependencies..."
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go get $(get)

go-install:
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go install $(GOFILES)

go-clean:
	@echo "  >  Cleaning build cache"
	@GOPATH=$(GOPATH) GOBIN=$(GOBIN) go clean

.PHONY: help
all: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'
	@echo