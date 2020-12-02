all:
	$(MAKE) -C 30
	$(MAKE) -C 31

push:
	$(MAKE) -C 30 push
	$(MAKE) -C 31 push
