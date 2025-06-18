CROSS_COMPILE = riscv64-linux-gnu-



include build_linux.mk
include build_opensbi.mk

run:
	$(MAKE) -C spike-runner \
		IMAGE=$(PWD)/$(OPENSBI_IMAGE_BIN)\
		ARGS+="" \
		run

clean:clean_opensbi

.PHONY: all 