
initramfs.cpio.gz:initramfs
	sudo chown -R root initramfs/
	sudo chgrp -R root initramfs/ 
	(cd initramfs && find . | cpio -o --format=newc | gzip > ../initramfs.cpio.gz)

initramfs rootfs:
	sudo rm initramfs -rf
	mkdir -p initramfs
	#$(MAKE) -C busybox/ CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv  CONFIG_PREFIX=../initramfs menuconfig 
	cp busybox_config busybox/.config
	#$(MAKE) -C busybox/ CROSS_COMPILE=riscv64-linux-gnu- ARCH=riscv  CONFIG_PREFIX=../initramfs install
	$(MAKE) -C busybox/ CROSS_COMPILE=/opt/riscv/rv32ima-ilp32-gnu-linux/bin/riscv32-unknown-linux-gnu- ARCH=riscv  CONFIG_PREFIX=../initramfs install
	sudo sh -c 'echo "#! /bin/sh" > ./initramfs/init'
	sudo sh -c 'echo "exec /bin/sh" >> ./initramfs/init'
	sudo sh -c 'chmod +x ./initramfs/init'

clean_busybox:
	sudo rm -rf initramfs*
