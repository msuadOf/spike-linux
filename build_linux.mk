LINUX_DIR := linux-5.15.183
LINUX_IMAGE_ELF = $(LINUX_DIR)/vmlinux
LINUX_IMAGE_BIN = $(LINUX_DIR)/arch/riscv/boot/Image

$(LINUX_IMAGE_ELF) $(LINUX_IMAGE_BIN):
	$(MAKE) -C $(LINUX_DIR) ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- #O=$(PWD)/$(LINUX_DIR)

clean_linux:
	$(MAKE) clean -C $(LINUX_DIR) ARCH=riscv CROSS_COMPILE=riscv64-linux-gnu- #O=$(PWD)/$(LINUX_DIR)

