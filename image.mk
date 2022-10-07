ifndef CI_REGISTRY
CI_REGISTRY := ghcr.io
endif
ifeq ($(CI_PROJECT_PATH),)
CI_PROJECT_PATH := build-docker/almalinux
endif

FROM := $(shell grep FROM Dockerfile | cut -d" " -f2)
OWNER := $(shell LC_ALL=c git remote show origin | perl -ne '/\s*fetch url:\s+(.*)/ig and print "$$1\n"' | perl -ne '/github.com.?(\b[^\/]+)/ and print $$1' )
VERSION := $(shell basename $$(pwd))
IMAGE := $(CI_PROJECT_PATH)/$(VERSION)

ifneq ($(CI_REGISTRY),)
IMAGE := $(CI_REGISTRY)/$(OWNER)/$(IMAGE)
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
