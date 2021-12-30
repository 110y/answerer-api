OS   := $(shell uname | awk '{print tolower($$0)}')
ARCH := $(shell case $$(uname -m) in (x86_64) echo amd64 ;; (aarch64) echo arm64 ;; (*) echo $$(uname -m) ;; esac)

DEV_DIR := $(shell pwd)/.dev
BIN_DIR := $(DEV_DIR)/bin

BAZELISK_VERSION := 1.11.0
BAZELISK := $(abspath $(BIN_DIR)/bazelisk)-$(BAZELISK_VERSION)

bazelisk: $(BAZELISK)
$(BAZELISK):
	curl -sSL "https://github.com/bazelbuild/bazelisk/releases/download/v$(BAZELISK_VERSION)/bazelisk-$(OS)-$(ARCH)" -o $(BAZELISK) && chmod +x $(BAZELISK)

.PHONY: pb
pb: $(BAZELISK)
	@$(BAZELISK) build //v1:answerer_go_proto
	@cp -f ./bazel-bin/v1/answerer_go_proto_/github.com/110y/answerer-api/v1/answerer.pb.* ./v1/
