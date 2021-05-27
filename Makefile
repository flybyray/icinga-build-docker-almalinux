all:
	$(MAKE) -C 33
	$(MAKE) -C 34

push:
	$(MAKE) -C 33 push
	$(MAKE) -C 34 push
