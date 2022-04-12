all:
	$(MAKE) -C 33
	$(MAKE) -C 34
	$(MAKE) -C 35
	$(MAKE) -C 36

push:
	$(MAKE) -C 33 push
	$(MAKE) -C 34 push
	$(MAKE) -C 35 push
	$(MAKE) -C 36 push
