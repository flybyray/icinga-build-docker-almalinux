all:
	$(MAKE) -C 32
	$(MAKE) -C 33

push:
	$(MAKE) -C 32 push
	$(MAKE) -C 33 push
