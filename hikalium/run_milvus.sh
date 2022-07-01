qemu-system-aarch64 \
	-bios ../../u-boot/u-boot.bin \
    -machine virt \
    -cpu cortex-a72 \
    -m 1G \
    -nographic \
    -kernel `readlink -f build/milvus/vmlinux`
    #-initrd `readlink -f ` \
