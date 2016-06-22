SOURCEDIR=$(shell pwd)
SOURCES := $(shell find $(SOURCEDIR) -name '*.go')

BINARY=elvisp

VERSION=2.0.0-alpha
BUILD_TIME=`date +%FT%T%z`


LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.BuildTime=${BUILD_TIME}"

.PHONY: install deploy clean build init test

all: init build test
build: $(SOURCES)
	go build ${LDFLAGS} -o ${BINARY}

init:
	glide install

install:
	go install ${LDFLAGS} ./...

deploy:
	go build ${LDFLAGS} -tags deploy -o ${BINARY}

clean:
	if [ -f ${BINARY} ] ; then rm ${BINARY} ; fi

test:
	go test ./ ./lease
