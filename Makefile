all:
	$(MAKE) -C 30
	$(MAKE) -C 31
	$(MAKE) -C 32
	$(MAKE) -C 33

push:
	$(MAKE) -C 30 push
	$(MAKE) -C 31 push
	$(MAKE) -C 32 push
	$(MAKE) -C 33 push
