all:
	$(MAKE) -C 27
	$(MAKE) -C 28
	$(MAKE) -C 29

push:
	$(MAKE) -C 27 push
	$(MAKE) -C 28 push
	$(MAKE) -C 29 push
