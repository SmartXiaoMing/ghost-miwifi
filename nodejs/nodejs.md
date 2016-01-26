# 准备源代码
假设基本的[准备工作](/miwifi-zhun-bei-gong-zuo/)在此前已经完成.

    mkdir ~/work/src/node/
    cd ~/work/src/node/

    # 去官网下载源代码(https://nodejs.org/dist/)
    # 我这里下载的0.10.14, 不推荐4.x.x这种版本的源代码, 会有很多坑.
    wget https://nodejs.org/dist/node-v0.10.14.tar.gz -O node.tar.gz
    tar -xf node.tar.gz

    # 进入解压出来的目录
    cd node-v0.10.14/

# 准备配置
在当前目录`node-v0.10.14/`下将下面的代码保存为 `miwifi_configure.sh`

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

# 编译安装

    sh miwifi_configure.sh
    make
    make install

顺利的话, 需要大概5分钟, 查看`/userdisk/data/work/node/`目录结构：

    tree /userdisk/data/work/node/ -L 2
    /userdisk/data/work/node/
    ├── bin
    │   ├── node
    │   └── npm -> ../lib/node_modules/npm/bin/npm-cli.js
    ├── lib
    │   ├── dtrace
    │   └── node_modules
    └── share
        └── man

# 测试运行
将node拷贝到路由器上, 运行一下看看.

    # 因为我并未打包, 拷贝时间较慢, 预计1分钟.
    scp -r /userdisk/data/work/node/ root@192.168.31.1:/userdisk/data/work/
    
    # 登录路由器, 运行.
    ssh root@192.168.31.1
    /userdisk/data/work/node/bin/node -v
    v0.10.14

    # 运行npm试试
    /userdisk/data/work/node/bin/npm -v
    # 结果, 悲剧了
    module.js:340
        throw err;
              ^
    Error: Cannot find module 'npmlog'
        at Function.Module._resolveFilename (module.js:338:15)
        at Function.Module._load (module.js:280:25)
        at Module.require (module.js:364:17)
        at require (module.js:380:17)
        at /userdisk/data/work/node/bin/npm:18:11
        at Object.<anonymous> (/userdisk/data/work/node/bin/npm:86:3)
        at Module._compile (module.js:456:26)
        at Object.Module._extensions..js (module.js:474:10)
        at Module.load (module.js:356:32)
        at Function.Module._load (module.js:312:12)

    # 解决方法, 删除, 重新链接
    rm /userdisk/data/work/node/bin/npm
    ln -s /userdisk/data/work/node/lib/node_modules/npm/bin/npm-cli.js /userdisk/data/work/node/bin/npm

    # 再试
    /userdisk/data/work/node/bin/npm -v
    1.3.5

妥.
