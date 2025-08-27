CROSS_COMPILE = riscv64-linux-gnu-



include build_linux.mk
include build_opensbi.mk
include build_busybox.mk
boot_image:=$(abspath ./$(OPENSBI_IMAGE_BIN))
NEMUFLAGS += -b #batch mode
run:
	$(MAKE) -C spike-runner \
		IMAGE=$(boot_image)\
		ARGS+="" \
		run
nemu-run:$(OPENSBI_IMAGE_BIN)
	$(MAKE) -C $(NEMU_HOME) ISA=riscv32 run ARGS="$(NEMUFLAGS)" IMG=$(boot_image)
nemu-menuconfig:
	$(MAKE) -C $(NEMU_HOME) ISA=riscv32 menuconfig ARGS="$(NEMUFLAGS)" IMG=$(boot_image)
clean:clean_opensbi

.PHONY: all 