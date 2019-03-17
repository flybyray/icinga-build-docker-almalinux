all:
	$(MAKE) -C 28
	$(MAKE) -C 29

push:
	$(MAKE) -C 28 push
	$(MAKE) -C 29 push
