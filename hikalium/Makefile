PROFILE?=obsidian

BUILD_DIR=$(shell readlink -f ./build/)/${PROFILE}/
CONFIG=$(shell readlink -f ./config_${PROFILE}.txt)
CONTROL_SOCKET=$(shell pwd)/crosvm_ctrl_sock
MOUNT_DIR=$(shell pwd)/mnt/
VMLINUX=$(shell readlink -f ./build/obsidian/vmlinux)
BZIMAGE=$(shell readlink -f ./build/obsidian/arch/x86/boot/bzImage)

.PHONY : kernel
kernel :
	echo ${BUILD_DIR}
	mkdir -p ${BUILD_DIR}
	cp ${CONFIG} ${BUILD_DIR}/.config
	make -C .. O=${BUILD_DIR} olddefconfig
	cp ${BUILD_DIR}/.config ${CONFIG}
	make -C .. O=${BUILD_DIR} -j `nproc`

.PHONY : lium
lium :
	@which lium || { echo "please install lium from https://chromium.googlesource.com/chromiumos/platform/dev-util/+/refs/heads/main/contrib/lium/" ; exit 1 ; }

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

.PHONY : prepare_mnt
prepare_mnt :
	echo ${MOUNT_DIR}
	mkdir -p ${MOUNT_DIR}

.PHONY : crosvm
crosvm :
	@which crosvm || { echo "please install crosvm from https://chromium.googlesource.com/crosvm/crosvm/" ; exit 1; }

.PHONY : run
run : prepare_mnt crosvm
	# https://www.kernel.org/doc/html/v4.14/admin-guide/kernel-parameters.html
	cd ../../crosvm && cargo run -- run \
			--socket $(CONTROL_SOCKET) \
			--shared-dir "$(MOUNT_DIR):mtdfake:type=fs:cache=always" \
			--params "console=ttyS0 rootfstype=virtiofs root=mtdfake init=/shelium.bin" \
			--cpus 4 \
			--mem 4096 \
			$(VMLINUX)

.PHONY : stop
stop : crosvm
	cd ../../crosvm && cargo run -- stop $(CONTROL_SOCKET)

.PHONY : rebase
rebase :
	git pull --rebase upstream master
