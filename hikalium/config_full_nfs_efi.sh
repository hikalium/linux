#!/bin/bash -xe

# make the build fast
# c.f. https://grsecurity.net/faster_multicore_linux_kernel_build_testing
../scripts/config --file config_full_nfs_efi.txt --disable CONFIG_X86_DECODER_SELFTEST
../scripts/config --file config_full_nfs_efi.txt --disable CONFIG_MODULE_SIG
../scripts/config --file config_full_nfs_efi.txt --disable CONFIG_DEBUG_INFO

# set CONFIG_*_TEST=n to disable all runtime tests (manually done)
# set CONFIG_*_SELFTEST=n to disable all runtime tests (manually done)
