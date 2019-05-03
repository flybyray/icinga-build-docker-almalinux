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

IMAGE_EXTRA_TAG := x86_64

all: pull build

pull:
	docker pull "$(IMAGE)" || true
	docker pull "$(FROM)"

build:
	docker build --cache-from "${IMAGE}" --tag "$(IMAGE)" .
ifdef IMAGE_EXTRA_TAG
	docker tag "$(IMAGE)" "$(IMAGE):$(IMAGE_EXTRA_TAG)"
endif

push:
	docker push "$(IMAGE)"
ifdef IMAGE_EXTRA_TAG
	docker push "$(IMAGE):$(IMAGE_EXTRA_TAG)"
endif

clean:
	if (docker inspect --type image "$(IMAGE)" >/dev/null 2>&1); then docker rmi "$(IMAGE)"; fi
