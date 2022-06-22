TARGETS := $(patsubst %/Dockerfile,%,$(wildcard */Dockerfile))
PUSH_TARGETS := $(patsubst %,%-push,$(TARGETS))

.PHONY: $(TARGETS)

all: $(TARGETS)

$(TARGETS):
	$(MAKE) -C $@

$(PUSH_TARGETS):
	$(MAKE) -C $@ push
