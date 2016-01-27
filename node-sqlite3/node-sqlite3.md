node-sqlite3是node访问sqlite3的接口.

# 准备

需要预先编译好的[sqlite3](/miwifi-bian-yi-sqlite3/).
另外还需要安装python2, 我相信大部分ubuntu都是自带的了.

    # 在开发机上安装node, 较早的node不是nodejs, 而是另一个程序
    # 不过node这个名词近期才真正被nodejs占有
    # 如果不小心装了旧node, 要卸载node, 然后 sudo apt-get install nodejs
    sudo apt-get install node
    # 测试node和npm是否安装成功
    node -v
    v4.2.6
    npm -v
    2.14.12

    # 建立目录
    mkdir ~/work/src/node_sqlite3/
    cd ~/work/src/node_sqlite3/

# 准备配置

将下面配置保存到当前目录`~/work/src/node_sqlite3/`, 命名为`miwifi_configure.sh`

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
注意， `/userdisk/data/work/sqlite3`是已经预先编译好的sqlite3的位置. 另外, 因为已经编译好路由器上的`node-v0.10.14`, 因此上面`--target=0.10.14`.

# 编译安装

    sh miwifi_configure.sh

实际上, npm会下载`node-v0.10.14`源代码, 所以整个过程可能会慢一些, 大概5分钟.
顺利的话, 将在当前目录生成`node_modules`.

    tree -L 3
    .
    ├── miwifi_configure.sh
    └── node_modules
        └── sqlite3
            ├── appveyor.yml
            ├── binding.gyp
            ├── build
            ├── CHANGELOG.md
            ├── CONTRIBUTING.md
            ├── deps
            ├── lib
            ├── LICENSE
            ├── node_modules
            ├── package.json
            ├── README.md
            ├── sqlite3.js
            └── src

    7 directories, 9 files
整个安装过程并不需要自己下载源代码, 这些都是npm帮忙做了.

# 测试

    scp -r node_modules/ root@192.168.31.1:/tmp/ 
    # 登录路由器, 测试一下
    ssh root@192.168.31.1
    /userdisk/data/work/node/bin/node -e 'require("sqlite3")'
    # 什么也没有显示. No news is good news.

# 参考
github源码请访问[node-sqlite3](https://github.com/mapbox/node-sqlite3), 上面详细说明了编译方法.
