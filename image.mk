OS := fedora

IMAGE_PREFIX := ${DOCKER_IMAGE_PREFIX}
ifeq ($(IMAGE_PREFIX),)
IMAGE_PREFIX := icinga/$(OS)/
endif

REGISTRY := ${DOCKER_REGISTRY}
ifneq ($(REGISTRY),)
IMAGE_PREFIX := $(REGISTRY)/$(IMAGE_PREFIX)
endif

FROM := $(shell grep FROM Dockerfile | cut -d" " -f2)
ifeq ($(VERSION),)
VERSION := $(shell basename `pwd`)
endif
IMAGE := $(IMAGE_PREFIX)$(VERSION):$(VARIANT)

all: pull build

pull:
	docker pull "$(IMAGE)" || true
	docker pull "$(FROM)"

build:
	docker build --cache-from "$(IMAGE)" --tag "$(IMAGE)" .

push:
	docker push "$(IMAGE)"

clean:
	if (docker inspect --type image "$(IMAGE)" >/dev/null 2>&1); then docker rmi "$(IMAGE)"; fi
