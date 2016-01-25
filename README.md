# 概述

这些准备工作对于后来的我写的每个软件的编译都是通用的。因此，配置如果跟这里的一样，就会省去很多麻烦。

## 准备
* 一台小米路由器（硬盘版）[此页购买](http://www.mi.com/miwifi/)
* 使用[app](http://www1.miwifi.com/miwifi_download.html)，并绑定小米帐号
* 刷开发版. [rom地址](http://www1.miwifi.com/miwifi_download.html)
* [开通ssh](https://d.miwifi.com/rom/ssh)

## 建立工作环境
要准备一个交叉编译环境，就是要在普通pc开发机上，编译出路由器上可以运行的程序。

我的开发机系统环境是linux ubuntu 14.04, x86_64。

    mkdir -p ~/work/src/
    
    #下载硬盘版路由器toolchain(官网http://www1.miwifi.com/miwifi_open.html)
    cd ~/work/
    wget http://bigota.miwifi.com/xiaoqiang/sdk/tools/package/sdk_package.zip
    zip sdk_package.zip

除了toolchain和源码，我们还要编译出各种二进制文件， 这里为了与路由器上的目录统一， 我在开发机上也建立相同的目录结构。

    sudo mkdir -p /userdisk/data/work/
    # 增加其他用户读写权限
    chmod o+wrx /userdisk/data/work/

## 编写第一个程序

    mkdir ~/work/src/hello/ 
    cd ~/work/src/hello/    

将下面代码保存为hello.cpp
    
    #include<stdio.h>
    int main() {
      printf("Hello MiWiFi!\n");
      return 0;
    }

编译代码

    ~/work/sdk_package/toolchain/bin/arm-xiaomi-linux-uclibcgnueabi-g++ hello.cpp -o hello
    
生成了hello二进制程序，在开发机上是运行不了的，必须拷贝到路由器上。

    scp hello root@192.168.31.1:/tmp/
    # 此处需要输入你的密码（参见上文开通ssh环节）
    # 登录到路由器上
    ssh root@192.168.31.1
    /tmp/hello
    # 运行结果如下
    BusyBox v1.19.4 (2016-01-22 05:03:52 CST) built-in shell (ash)
    Enter 'help' for a list of built-in commands.

    -----------------------------------------------------
    	Welcome to XiaoQiang!
    -----------------------------------------------------
    root@XiaoQiang:~# /tmp/hello 
    Hello MiWiFi!
    root@XiaoQiang:~#

现在，`~/work/`的目录结构是：

    tree -L 2
    .
    ├── sdk_package
    │   ├── dev_guide_1.0.0.pdf
    │   ├── include
    │   ├── lib
    │   ├── plugin.md
    │   ├── plugin_packager_x64
    │   ├── plugin_packager_x86
    │   ├── toolchain
    │   └── user_sample
    └── src
        └── hello

## 结束
做了以上准备， 我在其他文档中就可以写具体的软件编译了。 有的软件编译很简单， 稍微修改编译器环境变量就可以； 有的需要折腾几个小时才能搞定。即便付出了很多劳动， 我仍不能保证软件的可用性，稳定性，安全性。 因此， 这里我有必要公布一个免责声明：
> * 本人写的miwifi系列文档以及编译出来的软件， 可以用来指导如何编译出小米路由器可用的软件， 但不能保证安全性，稳定性，甚至可用性。
> * 如果你担心路由器的稳定性，数据丢失，甚至损坏等问题， 请立即停止阅读和使用， 并忘掉所有相关信息。
> * 如果你使用了这些文档或者软件， 造成的路由器不稳定， 数据丢失， 甚至损坏等问题， 本人概不负责， 当然小米路由器官方也不负责。

我会把这些文档同步到github上一份， 请访问： 

    https://github.com/SmartXiaoMing/miwifi

如有问题需要讨论或者想贡献经验， 可以联系我：
    
    95813422（AT）qq.com
