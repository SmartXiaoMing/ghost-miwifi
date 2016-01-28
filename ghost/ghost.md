`ghost`是一个开源的blog, 可以使用[官方](https://ghost.org/)的服务, 也可以安装到自己的主机上.

# 准备
`ghost`是一个`nodejs`项目, 需要开发机上安装`node`, `npm`.

另外, 我们还需要已经编译好的适用于小米路由器的`nodejs`, `node-sqlite3`. 请先参考其他文档完成这些依赖的安装.

    # 创建工作目录
    mkdir ~/work/src/ghost/
    cd ~/work/src/ghost/

    # 下载ghost源代码, 我这里得到的版本是0.7.5
    # 经过几次3xx跳转, 最终会是https://en.ghost.org/archives/ghost-0.7.5.zip
    wget https://ghost.org/zip/ghost-latest.zip
    unzip -d ghost-latest ghost-latest.zip 
    cd ghost-latest
 
# 安装   
这里我要解释一下. 我要在开发机上安装好`ghost`, 然后复制到路由器上. 安装过程中`npm`会自动解决所有相关依赖, 但是对于`node-sqlite3`却略显繁琐. 我这里手动解决`node-sqlite3`依赖, 省去很多麻烦.

    # 将已安装好的node-sqlite3复制过来. 注意, 是适用于路由器上运行的版本.
    cp -r ~/work/src/node_sqlite3/node_modules/ ./
    # 安装ghost, npm会自动干不少事情, 大概2~5分钟.
    npm install --production

# 部署

安装完之后, 我这里竟然生成了168MB的内容.

    # 复制到路由器上很慢, 大概3~5分钟. 当然, 压缩打包上传起来会快一些. 
    scp -r ../ghost-latest root@192.168.31.1:/userdisk/data/work/

    # 登录到路由器, 切换目录
    ssh root@192.168.31.1
    cd /userdisk/data/work/ghost-latest/

这里要修改一下`config.example.js`文件, 将里面的`host: '127.0.0.1'`改成`host: '192.168.31.1'`, 因为我们要从开发机访问路由器的blog, 而不是访问开发机自己.

    # 文件的最后几行中的IP从'127.0.0.1'改成'192.168.31.1'
    vi config.example.js

    # 目前, 在路由器的`/userdisk/data/work/`目录中有:
    root@XiaoQiang:/userdisk/data/work/ghost-latest# ls /userdisk/data/work/
    ghost-latest  node

    # 试运行
    /userdisk/data/work/node/bin/npm start --production

    # 第一次运行初始化一些东西, 因此感觉非常慢
    # 如果顺利的话, 会打印出下面的log
    > ghost@0.7.5 start /userdisk/data/work/ghost-latest
    > node index

    Migrations: Database initialisation required for version 004
    Migrations: Creating tables...
    Migrations: Creating table: posts
    Migrations: Creating table: users
    Migrations: Creating table: roles
    Migrations: Creating table: roles_users
    Migrations: Creating table: permissions
    Migrations: Creating table: permissions_users
    Migrations: Creating table: permissions_roles
    Migrations: Creating table: permissions_apps
    Migrations: Creating table: settings
    Migrations: Creating table: tags
    Migrations: Creating table: posts_tags
    Migrations: Creating table: apps
    Migrations: Creating table: app_settings
    Migrations: Creating table: app_fields
    Migrations: Creating table: clients
    Migrations: Creating table: client_trusted_domains
    Migrations: Creating table: accesstokens
    Migrations: Creating table: refreshtokens
    Migrations: Populating fixtures
    Migrations: Populating permissions
    Migrations: Creating owner
    Migrations: Populating default settings
    Migrations: Complete
    Ghost is running in production... 
    Your blog is now available on http://my-ghost-blog.com 
    Ctrl+C to shut down

打开浏览器, 访问`http://192.168.31.1:2368/`, 快去创建自己的账户吧.

# 结束

以上就是搭建`ghost`的全过程. 接下来, 保持`ghost`一直活跃在后台, 配置域名, 外网访问等问题, 这里就不赘述了.

我在自己的路由器上也搭建了`ghost`,
    
    http://smartxiaoming.eicp.net:2368/

如有问题需要讨论或者感觉棒棒的, 可以联系我,

    95813422(AT)qq.com

