CROSS_COMPILE = riscv64-linux-gnu-



include build_linux.mk
include build_opensbi.mk
include build_busybox.mk

run:
	$(MAKE) -C spike-runner \
		IMAGE=$(PWD)/$(OPENSBI_IMAGE_BIN)\
		ARGS+="" \
		run
nemu-run:
	$(MAKE) -C $(NEMU_HOME) \
		IMAGE=$(PWD)/$(OPENSBI_IMAGE_BIN)\
		ARGS+="" \
		run
clean:clean_opensbi

.PHONY: all 