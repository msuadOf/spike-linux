
OPENSBI_DIR := opensbi
OPENSBI_BRANCH := bao/demo
# OPENSBI_PLATFORM := generic#myspike
OPENSBI_PLATFORM := myspike
OPENSBI_IMAGE_DIR = $(OPENSBI_DIR)/build/platform/$(OPENSBI_PLATFORM)/firmware
OPENSBI_IMAGE_BIN = $(OPENSBI_IMAGE_DIR)/fw_payload.bin
OPENSBI_IMAGE_ELF = $(OPENSBI_IMAGE_DIR)/fw_payload.elf

ifeq ($(wildcard opensbi/platform),)
  $(shell git clone --depth=1 --branch $(OPENSBI_BRANCH) git@github.com:ariscv/opensbi.git $(OPENSBI_DIR))
endif

all $(OPENSBI_IMAGE_ELF) $(OPENSBI_IMAGE_BIN):$(LINUX_IMAGE_ELF) $(LINUX_IMAGE_BIN)
	$(MAKE) -C $(OPENSBI_DIR) PLATFORM=$(OPENSBI_PLATFORM) CROSS_COMPILE=$(CROSS_COMPILE)\
		FW_PAYLOAD=y \
		FW_FDT_PATH=$(strip $(PWD)/spike.dtb)\
		FW_PAYLOAD_PATH=$(strip $(PWD)/$(LINUX_IMAGE_BIN)) \
		PLATFORM_RISCV_XLEN=32 PLATFORM_RISCV_ABI=ilp32 PLATFORM_RISCV_ISA=rv32ima_zicsr_zifencei_zicntr PLATFORM_RISCV_CODE_MODEL=medany \
		FW_TEXT_START=0x80000000\
		FW_PAYLOAD_FDT_ADDR=0x80100000
	du -h $(OPENSBI_IMAGE_ELF) $(OPENSBI_IMAGE_BIN) $(LINUX_IMAGE_ELF) $(LINUX_IMAGE_BIN)

clean_opensbi:
	-rm -rf $(OPENSBI_DIR)/build