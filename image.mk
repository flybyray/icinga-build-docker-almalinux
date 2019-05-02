ifndef CI_REGISTRY
CI_REGISTRY := registry.icinga.com
endif
ifeq ($(CI_PROJECT_PATH),)
CI_PROJECT_PATH := build-docker/fedora
endif

FROM := $(shell grep FROM Dockerfile | cut -d" " -f2)
VERSION := $(shell basename $$(pwd))
IMAGE := $(CI_PROJECT_PATH)/$(VERSION)

ifneq ($(CI_REGISTRY),)
IMAGE := $(CI_REGISTRY)/$(IMAGE)
endif

all: pull build

pull:
	docker pull "$(IMAGE)" || true
	docker pull "$(FROM)"

build:
	docker build --cache-from "${IMAGE}" --tag "$(IMAGE)" .

push:
	docker push "$(IMAGE)"

clean:
	if (docker inspect --type image "$(IMAGE)" >/dev/null 2>&1); then docker rmi "$(IMAGE)"; fi
