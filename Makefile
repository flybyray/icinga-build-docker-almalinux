all:
	$(MAKE) -C 26
	$(MAKE) -C 27

push:
	$(MAKE) -C 26 push
	$(MAKE) -C 27 push
