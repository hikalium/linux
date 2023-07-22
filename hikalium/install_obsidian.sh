#!/bin/bash -e
NEW_EFI_IMAGE=build/obsidian/arch/x86/boot/bzImage
ssh obsidian -- echo "obsidian is online"
ssh obsidian -- echo "hello"
ssh obsidian -- ls -lah /boot/efi/boot/bootx64.efi
TS=`date '+%Y%m%d_%H%M%S'`
ssh obsidian -- sudo cp /boot/efi/boot/bootx64.efi /boot/kernel_archives/bootx64.efi_${TS}
ssh obsidian -- ls -lah /boot/efi/boot/bootx64.efi /boot/kernel_archives/bootx64.efi_${TS}
strip -o build/obsidian/vmlinux.stripped build/obsidian/vmlinux
ls -lah build/obsidian/vmlinux.stripped
scp build/obsidian/vmlinux.stripped obsidian:/tmp/bootx64.efi
ssh obsidian -- sudo cp /tmp/bootx64.efi /boot/efi/boot/bootx64.efi
ssh obsidian -- sudo cp /tmp/bootx64.efi /boot/efi/boot/bootx64.efi
ssh obsidian -- ls -lah /boot/efi/boot/bootx64.efi
ssh obsidian -- file /boot/efi/boot/bootx64.efi

# recover:
# sudo cp `ls /boot/kernel_archives/bootx64.efi_* -t | head -n 1` /boot/efi/boot/bootx64.efi
