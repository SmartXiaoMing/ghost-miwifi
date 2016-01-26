#!/bin/bash
name=`whoami`
export TOOLCHAIN=/home/$name/sdk_package/toolchain/
export PATH=$TOOLCHAIN/bin:$PATH
export AR=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-ar
export CC=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-gcc
export CXX=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-g++
export LINK=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-g++

TARGET_DIR=/userdisk/data/work/node/

./configure \
    --prefix=$TARGET_DIR\
    --dest-cpu=arm \
    --dest-os=linux \
    --without-snapshot \
    --with-arm-float-abi=soft
