OS := fedora

IMAGE_PREFIX := ${DOCKER_IMAGE_PREFIX}
ifeq ($(IMAGE_PREFIX),)
IMAGE_PREFIX := icinga/
endif

REGISTRY := ${DOCKER_REGISTRY}
ifneq ($(REGISTRY),)
IMAGE_PREFIX := $(REGISTRY)/$(IMAGE_PREFIX)
endif

FROM := $(shell grep FROM Dockerfile | cut -d" " -f2)
VERSION := $(shell basename `pwd`)
IMAGE := $(IMAGE_PREFIX)$(OS)-$(VERSION)$(IMAGE_SUFFIX)

all: pull build

pull:
	docker pull "$(FROM)"

build:
	docker build -t "$(IMAGE)" .

push:
	docker push "$(IMAGE)"

clean:
	if (docker inspect --type image "$(IMAGE)" >/dev/null 2>&1); then docker rmi "$(IMAGE)"; fi
