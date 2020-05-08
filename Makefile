GOCMD=go
GOBUILD=$(GOCMD) build
GOTEST=$(GOCMD) test
GOCLEAN=$(GOCMD) clean
BIN_NAME=zipdb

LINTCMD=golangci-lint run
LINTOPTS=-E funlen \
	 -E lll \
	 -E nakedret \
	 -E gocritic \
	 -E godot \
	 -E golint \
	 -E stylecheck \
	 -E unconvert \
	 -E unparam
GOLINT=$(LINTCMD) $(LINTOPTS)


all: test build

pr: clean build lint testv
	@$(MAKE) clean

build:
	$(GOBUILD) -o $(BIN_NAME)

buildv:
	$(GOBUILD) -v -o $(BIN_NAME)

test:
	$(GOTEST) ./...

testv:
	$(GOTEST) -v ./...

lint:
	$(GOLINT)

clean:
	$(GOCLEAN)
	rm -f $(BIN_NAME)
