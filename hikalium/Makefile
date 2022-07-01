PROFILE?=efiusb

BUILD_DIR=$(shell readlink -f ./build/)/${PROFILE}/
CONFIG=$(shell readlink -f ./config_${PROFILE}.txt)
CONTROL_SOCKET=$(shell pwd)/crosvm_ctrl_sock
MOUNT_DIR=$(shell pwd)/mnt/
VMLINUX=$(shell readlink -f ./build/$(PROFILE)/vmlinux)
BZIMAGE=$(shell readlink -f ./build/$(PROFILE)/arch/x86/boot/bzImage)
OVMF=$(shell readlink -f ./third_party/RELEASEX64_OVMF.fd)
PORT_MONITOR?=2345
PORT_OFFSET_VNC?=5

QEMU_ARGS=\
		-bios ${OVMF} \
		-drive format=raw,file=fat:rw:mnt \
		-chardev stdio,id=char_com1,mux=on,logfile=com1.log \
		-serial chardev:char_com1 \
		--enable-kvm \
		-m 2g \
		-machine q35 \
		-cpu host \
		-device virtio-rng-pci \
		-monitor telnet:0.0.0.0:2222,server,nowait \
		${MORE_QEMU_FLAGS}

ifndef DISPLAY
QEMU_ARGS+=-vnc 0.0.0.0:$(PORT_OFFSET_VNC),password=on
endif

default:
	make kernel

file:
	file ${BUILD_DIR}/arch/x86/boot/bzImage

.PHONY : kernel
kernel :
	echo ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}
	cp ${CONFIG} ${BUILD_DIR}/.config
	make -C .. O=${BUILD_DIR} olddefconfig
	cp ${BUILD_DIR}/.config ${CONFIG}
	make -C .. O=${BUILD_DIR} -j `nproc`

.PHONY : mrproper
mrproper :
	make -C .. mrproper

.PHONY : clean
clean :
	make -C .. O=${BUILD_DIR} clean

.PHONY : menuconfig
menuconfig :
	echo ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}
	cp ${CONFIG} ${BUILD_DIR}/.config
	make -C .. O=${BUILD_DIR} menuconfig
	cp ${BUILD_DIR}/.config ${CONFIG}

.PHONY : allyesconfig
allyesconfig :
	echo ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}
	cp ${CONFIG} ${BUILD_DIR}/.config
	make -C .. O=${BUILD_DIR} allyesconfig
	cp ${BUILD_DIR}/.config ${CONFIG}

.PHONY : prepare_mnt
prepare_mnt :
	echo ${MOUNT_DIR}
	mkdir -p ${MOUNT_DIR}

.PHONY : run
run :
	mkdir -p mnt/EFI/BOOT
	cp build/${PROFILE}/arch/x86/boot/bzImage mnt/EFI/BOOT/BOOTX64.EFI
	qemu-system-x86_64 ${QEMU_ARGS}

.PHONY : rebase
rebase :
	git pull --rebase upstream master
