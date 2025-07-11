
initramfs.cpio.gz:initramfs
	sudo chown -R root initramfs/
	sudo chgrp -R root initramfs/ 
	(cd initramfs && find . | cpio -o --format=newc | gzip > ../initramfs.cpio.gz)

initramfs rootfs:
	mkdir -p initramfs
	#$(MAKE) -C busybox/ CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv  CONFIG_PREFIX=../initramfs menuconfig 
	$(MAKE) -C busybox/ CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv  CONFIG_PREFIX=../initramfs install

