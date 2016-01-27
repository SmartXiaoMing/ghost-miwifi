#!/bin/bash
name=`whoami`
export TOOLCHAIN=/home/$name/work/sdk_package/toolchain/
export PATH=$TOOLCHAIN/bin:$PATH
export AR=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-ar
export CC=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-gcc
export CXX=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-g++
export LINK=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-g++
export LD=$TOOLCHAIN/bin/arm-xiaomi-linux-uclibcgnueabi-ld
export LDFLAGS="-L$TOOLCHAIN/arm-xiaomi-linux-uclibcgnueabi/lib"
export CPPFLAGS="-I$TOOLCHAIN/arm-xiaomi-linux-uclibcgnueabi/include -fPIC"
export CXXFLAGS="$CPPFLAGS"
export CFLAGS="$CPPFLAGS"

npm install sqlite3 \
    --build-from-source \
    --sqlite=/userdisk/data/work/sqlite3 \
    --target_arch=arm \
    --target=0.10.14 \
    --verbose
