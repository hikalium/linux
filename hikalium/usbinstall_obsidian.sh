#!/bin/bash -e
NEW_EFI_IMAGE=build/obsidian/arch/x86/boot/bzImage
MOUNTPOINT=/mnt/usb
DST_DIR=${MOUNTPOINT}/EFI/BOOT
df -h ${MOUNTPOINT}
sudo mkdir -p ${DST_DIR}
sudo cp ${NEW_EFI_IMAGE} ${DST_DIR}/BOOTX64.EFI
ls -lah ${DST_DIR}
sudo umount ${MOUNTPOINT}
