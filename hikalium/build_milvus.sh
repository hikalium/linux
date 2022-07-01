export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-gnu-
make -C .. O=./hikalium/build/milvus/ defconfig
cp ./config_milvus.txt ./build/milvus/.config
make -j`nproc`
