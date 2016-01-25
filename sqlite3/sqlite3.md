# 准备源代码
假设基本的[准备工作](/miwifi-zhun-bei-gong-zuo/)在此前已经完成.

    mkdir ~/work/src/sqlite3/
    cd ~/work/src/sqlite3/

    # 访问[SQLite官网下载地址](https://www.sqlite.org/download.html), 下载源代码
    wget https://www.sqlite.org/2016/sqlite-autoconf-3100200.tar.gz -O sqlite.tar.gz
    tar -xf sqlite.tar.gz

    # 我这里生成了目录:sqlite-autoconf-3100200
    cd sqlite-autoconf-3100200

# 准备配置
将下面的代码保存为 `miwifi_configure.sh`

    #!/bin/bash
    name=`whoami`
    export TOOLCHAIN=/home/$name/sdk_package/toolchain/
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

    ./configure \
        --prefix=/userdisk/data/work/sqlite3 \
        --host=arm

# 编译安装

    sh miwifi_configure.sh
    make
    make install

一切顺利的话, 在`/userdisk/data/work/sqlite3`目录中会生成:

    tree -L 3 /userdisk/data/work/
    /userdisk/data/work/
    └── sqlite3
        ├── bin
        │   └── sqlite3
        ├── include
        │   ├── sqlite3ext.h
        │   └── sqlite3.h
        ├── lib
        │   ├── libsqlite3.a
        │   ├── libsqlite3.la
        │   └── pkgconfig
        └── share
        └── man

# 试运行

    # 要保证路由器上有/userdisk/data/目录, 没有的话, 自己先登录上去建一个.
    scp -r /userdisk/data/work/sqlite3 root@192.168.31.1:/userdisk/data/work/
    ssh root@192.168.31.1
    /userdisk/data/work/sqlite3/bin/sqlite3

结果如下

    root@XiaoQiang:~# /userdisk/data/work/sqlite3/bin/sqlite3 
    SQLite version 3.10.2 2016-01-20 15:27:19
    Enter ".help" for usage hints.
    Connected to a transient in-memory database.
    Use ".open FILENAME" to reopen on a persistent database.
    sqlite>

好的, 完成.
