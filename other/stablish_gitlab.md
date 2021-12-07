#### gitlab搭建流程

```javascript
# 更新软件包 
yum update -y

# 安装 sshd
yum install -y curl policycoreutils-python openssh-server

# 启用并启动 sshd
systemctl enable sshd
systemctl start sshd

# 配置防火墙
打开 /etc/sysctl.conf 文件，在文件最后添加新的一行并按 Ctrl + S 保存：
net.ipv4.ip_forward = 1

# 启用并启动防火墙
systemctl enable firewalld
systemctl start firewalld

# 放通 HTTP
firewall-cmd --permanent --add-service=http

# 重启防火墙
systemctl reload firewalld

// tips：在实际使用中，可以使用 systemctl status firewalld 命令查看防火墙的状态。

# 安装 postfix
// GitLab 需要使用 postfix 来发送邮件。 
yum install -y postfix

#打开 /etc/postfix/main.cf 文件，在第 119 行附近找到 inet_protocols = all，将 all 改为 ipv4 并按 Ctrl + S 保存：
inet_protocols = ipv4

# 启用并启动 postfix：
systemctl enable postfix 
systemctl start postfix

# 配置 swap 交换分区
由于 GitLab 较为消耗资源，我们需要先创建交换分区，以降低物理内存的压力。
在实际生产环境中，如果服务器配置够高，则不必配置交换分区。
新建 2 GB 大小的交换分区：
dd if=/dev/zero of=/root/swapfile bs=1M count=2048

# 格式化为交换分区文件并启用：
mkswap /root/swapfile
swapon /root/swapfile

# 添加自启用。打开 /etc/fstab 文件，在文件最后添加新的一行并按 Ctrl + S 保存：
/root/swapfile swap swap defaults 0 0

# 安装 GitLab
将软件源修改为国内源
由于网络环境的原因，将 repo 源修改为`https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el$releasever/`

# 在 /etc/yum.repos.d 目录下新建 gitlab-ce.repo 文件并保存。内容如下：
[gitlab-ce]
name=Gitlab CE Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el$releasever/
gpgcheck=0
enabled=1

# 安装 GitLab
刚才修改过了 yum 源，因此先重新生成缓存：（此步骤执行时间较长，一般需要 3~5 分钟左右，请耐心等待）
yum install -y gitlab-ce

# 初始化 GitLab
配置 GitLab 的域名（非必需）
打开 /etc/gitlab/gitlab.rb 文件，在第 13 行附近找到 external_url 'http://gitlab.example.com'，将单引号中的内容改为自己的域名（带上协议头，末尾无斜杠），并按 Ctrl + S 保存。
例如：external_url 'http://work.myteam.com'
记得将域名通过 A 记录解析到 <您的 CVM IP 地址> 哦。

# 使用如下命令初始化 GitLab：
（此步骤执行时间较长，一般需要 5~10 分钟左右，请耐心等待）
sudo gitlab-ctl reconfigure
```





## [Gitlab备份与恢复、迁移与升级](https://www.cnblogs.com/linkenpark/p/8893964.html)

 

## 0.Gitlab安装

1.安装和配置必要的依赖关系 
在CentOS7，下面的命令将在系统防火墙打开HTTP和SSH访问。

 

1. `yum install curl openssh-server postfix`
2. `systemctl enable sshd postfix`
3. `systemctl start sshd postfix`
4. `firewall-cmd --permanent --add-service=http`
5. `systemctl reload firewalld`

<https://mirror.tuna.tsinghua.edu.cn/help/gitlab-ce/>

 

版本：Gitlab Community Edition

 

**注意: gitlab-ce 镜像仅支持 x86-64 架构**

### Debian/Ubuntu 用户

首先信任 GitLab 的 GPG 公钥:

```
curl https://packages.gitlab.com/gpg.key 2> /dev/null | sudo apt-key add - &>/dev/null
```

再选择你的 Debian/Ubuntu 版本，文本框中内容写进 `/etc/apt/sources.list.d/gitlab-ce.list`

你的Debian/Ubuntu版本: 

 

```
deb http://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/debian stretch main
```

安装 gitlab-ce:

```
sudo apt-get update
sudo apt-get install gitlab-ce
```

### RHEL/CentOS 用户

新建 `/etc/yum.repos.d/gitlab-ce.repo`，内容为

```
[gitlab-ce]
name=Gitlab CE Repository
baseurl=https://mirrors.tuna.tsinghua.edu.cn/gitlab-ce/yum/el$releasever/
gpgcheck=0
enabled=1
```

再执行

```
sudo yum makecache
sudo yum install gitlab-ce -y
```

安装后后，修改

/etc/gitlab/gitlab.rb 文件中external_url为你的域名，然后执行配置

gitlab-ctl reconfigure

 

启动脚本

```
cat /etc/systemd/system/gitlab.service
[Unit]``Description=gitlab` `[Service]``Type=oneshot``RemainAfterExit=yes``ExecStart=/bin/gitlab-ctl start``ExecStop=/bin/gitlab-ctl stop` `[Install]``WantedBy=multi-user.target
```

 

cat /usr/lib/systemd/system/gitlab-runsvdir.service

```
`[Unit]``Description=GitLab Runit supervision process``After=basic.target` `[Service]``ExecStart=/opt/gitlab/embedded/bin/runsvdir-start``Restart=always` `[Install]``WantedBy=basic.target`
```

 

3.配置并启动

 

1. `gitlab-ctl reconfigure`
2. `gitlab-ctl status`
3. `gitlab-ctl stop`
4. `gitlab-ctl start`

4.浏览到主机名和登录Browse to the hostname and login

 

1. `Username: root`
2. `Password: 5iveL!fe`

5.更多操作系统的安装方式，点击下方链接即可 
[CentOS6](https://about.gitlab.com/downloads/#centos6) 
[CentOS7](https://about.gitlab.com/downloads/#centos7) 
[Ubuntu14](https://about.gitlab.com/downloads/#ubuntu1404) 
[Ubuntu12](https://about.gitlab.com/downloads/#ubuntu1204)

 

## 1.Gitlab备份

使用Gitlab一键安装包安装Gitlab非常简单, 同样的备份恢复与迁移也非常简单. 使用一条命令即可创建完整的Gitlab备份:

 

1. `gitlab-rake gitlab:backup:create`

使用以上命令会在`/var/opt/gitlab/backups`目录下创建一个名称类似为`1481598919_gitlab_backup.tar`的压缩包, 这个压缩包就是Gitlab整个的完整部分, 其中开头的1481598919是备份创建的日期 
`/etc/gitlab/gitlab.rb` 配置文件须备份 
`/var/opt/gitlab/nginx/conf` nginx配置文件 
`/etc/postfix/main.cfpostfix` 邮件配置备份

 

### 1.1Gitlab备份目录

可以通过`/etc/gitlab/gitlab.rb`配置文件来修改默认存放备份文件的目录

 

1. `gitlab_rails['backup_path'] = "/var/opt/gitlab/backups"`

`/var/opt/gitlab/backups`修改为你想存放备份的目录即可, 修改完成之后使用`gitlab-ctl reconfigure`命令重载配置文件即可.

 

### 1.2Gitlab自动备份

实现每天凌晨2点进行一次自动备份:通过crontab使用备份命令实现

 

1. `0 2 * * * /opt/gitlab/bin/gitlab-rake gitlab:backup:create`

 

## 2.Gitlab恢复

Gitlab的从备份恢复也非常简单:

 

1. `# 停止相关数据连接服务`
2. `gitlab-ctl stop unicorn`
3. `gitlab-ctl stop sidekiq`
4. ``
5. `# 从1481598919编号备份中恢复`
6. `gitlab-rake gitlab:backup:restore BACKUP=1481598919`
7. ``
8. `# 启动Gitlab`
9. `sudo gitlab-ctl start`

 

## 3.gitlab迁移

要求：新服务器的gitlab版本与旧的服务器相同。

迁移如同备份与恢复的步骤一样, 只需要将老服务器`/var/opt/gitlab/backups`目录下的备份文件拷贝到新服务器上的`/var/opt/gitlab/backups`即可(如果你没修改过默认备份目录的话). 
但是需要注意的是新服务器上的Gitlab的版本必须与创建备份时的Gitlab版本号相同. 比如新服务器安装的是最新的7.60版本的Gitlab, 那么迁移之前, 最好将老服务器的Gitlab 升级为7.60在进行备份.

`/etc/gitlab/gitlab.rb` gitlab配置文件须迁移,迁移后需要调整数据存放目录 
`/var/opt/gitlab/nginx/conf` nginx配置文件目录须迁移

/etc/gitlab/gitlab-secrets.json # 复制新服务器相同的目录下

/etc/ssh/*key*  # 复制到新服务器相同目录下，解决ssh key认证不成功问题

1. `[root@linux-node1 ~]# gitlab-ctl stop unicorn`
2. `ok: down: unicorn: 0s, normally up`
3. `[root@linux-node1 ~]# gitlab-ctl stop sidekiq`
4. `ok: down: sidekiq: 0s, normally up`
5. `[root@linux-node1 ~]# chmod 777 /var/opt/gitlab/backups/1481598919_gitlab_backup.tar  # 或 chown git:git /var/opt/gitlab/backups/1481598919_gitlab_backup.tar`
6. `[root@linux-node1 ~]# gitlab-rake gitlab:backup:restore BACKUP=1481598919`

 

## 4.gitlab升级

1.关闭gitlab服务

 

1. `gitlab-ctl stop unicorn`
2. `gitlab-ctl stop sidekiq`
3. `gitlab-ctl stop nginx`

2.备份gitlab

 

1. `gitlab-rake gitlab:backup:create`

3.下载gitlab的RPM包并进行升级

 

1. `curl -s https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash`
2. `yum update gitlab-ce`
3. `或者直接安装高版本`
4. `yum install gitlab-ce-8.12.13-ce.0.el7.x86_64`
5. ``
6. `或者上官网下载最新版本 gitlab对应软件包 [gitlab官网](https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/7/gitlab-ce-8.12.13-ce.0.el7.x86_64.rpm)`
7. `使用 rpm -Uvh gitlab-ce-8.12.13-ce.0.el7.x86_64`
8. ``
9. ``
10. `报错.`
11. `Error executing action `run` on resource 'ruby_block[directory resource: /var/opt/gitlab/git-data/repositories]'`
12. ``
13. `解决方法:`
14. `sudo chmod 2770 /var/opt/gitlab/git-data/repositories`

4.启动并查看gitlab版本信息

 

1. `gitlab-ctl reconfigure`
2. `gitlab-ctl restart`
3. `# head -1 /opt/gitlab/version-manifest.txt`
4. `gitlab-ce 8.7.3`

 

## 5.gitlab更改默认Nginx

更换gitlab自带Nginx，使用自行编译Nginx来管理gitlab服务。

编辑gitlab配置文件禁用自带Nignx服务器

 

1. `vi /etc/gitlab/gitlab.rb`
2. `...`
3. `#设置nginx为false,关闭自带Nginx`
4. `nginx['enable'] = false`
5. `...`

检查默认nginx配置文件，并迁移至新Nginx服务

 

1. `/var/opt/gitlab/nginx/conf/nginx.conf #nginx配置文件,包含gitlab-http.conf文件`
2. `/var/opt/gitlab/nginx/conf/gitlab-http.conf #gitlab核心nginx配置文件`

重启 nginx、gitlab服务

 

1. `$ sudo gitlab-ctl reconfigure`
2. `$ sudo service nginx restart`

访问报502。原因是nginx用户无法访问gitlab用户的socket文件。 重启gitlab需要重新授权

 

1. 1. `chmod -R o+x /var/opt/gitlab/gitlab-rails`



#### 搭建gitlab脚本

```shell
#!/bin/bash
# install git-lab
# v1.0 by hikebao 2019/9/28

# test the network is working
domain=http://mygitlab.com
ping -c1 www.baidu.com &>/dev/null
if [ $? -ne 0 ];then
	echo "connect: unreachable"
	exit
fi

# if exist yum
type -a yum
if [ $? -ne 0 ]
then
	echo "no exist yum"
	exit
fi



yum install -y curl policycoreutils-python openssh-server &&
systemctl enable sshd &&
systemctl start sshd &&
#echo "net.ipv4.ip_forward=1" >> /etc/sysctl.conf &&
systemctl enable firewalld &&
systemctl start firewalld &&
firewall-cmd --permanent --add-service=http &&
systemctl reload firewalld &&
yum install -y postfix &&
sed -ri '/^inet_protocols=/cinet_protocols=ipv4' /etc/postfix/main.cf &&
systemctl enable postfix &&
systemctl start postfix &&
#dd if=/dev/zero of=/root/swapfile bs=1M count=2048 &&
#mkswap /root/swapfile &&
#swapon /root/swapfile &&
#echo "/root/swapfile swap swap defaults 0 0" >> /etc/fstab &&
yum install -y gitlab-ce &&
sed -ri "/external_url=/cexternal_url=$domain" /etc/gitlab/gitlab.rb &&
gitlab-ctl reconfigure

```





#### 搭建项目

```javascript
# 引入axios,在根目录下创建vue.config.js
module.exports={
    devServer: {
        proxy: {
            '/api': {
                target: 'https://baidu.com',
                port: 8080,
                changeOrigin: true,
                pathRewrite: {
                    '^/api': ""
                }
            }
        }
    }
}

// 2019年8月24日使用node搭建的服务器有几个注意事项
 - createServer里面要放一个函数,而且注意顺序，先请求'req'，后返回'res';
 - 设置返回状态码的方法res.writeHead(200, {"Content-Type": "text/html;charset='utf-8'"})
 - 设置响应，跨域使用
   res.setHeader('Access-Control-Allow-Origin', 'http://192.168.43.193:8081');
   res.setHeader('Access-Control-Allow-Credentials', true);
 - 返回数据，直接写在res.end(data); // 注意data要经过序列化处理


代理实际上是利用http-proxy-middleware中间件完成的,所以如果要通过文件夹的方式mock数据的话，要研究以下如何使用http-proxy-middleware
```





### **项目构建** 

- 1.理解`npm`、`yarn`依赖包管理的原理，两者的区别

- 2.可以使用`npm`运行自定义脚本

- 3.理解`Babel`、`ESLint`、`webpack`等工具在项目中承担的作用

- 4.`ESLint`规则检测原理，常用的`ESLint`配置

  [eslint原理]: https://www.jianshu.com/p/526db7eeeecc	"eslint原理"

  

- 5.`Babel`的核心原理，可以自己编写一个`Babel`插件

- 6.可以配置一种前端代码兼容方案，如`Polyfill`

- 7.`Webpack`的编译原理、构建流程、热更新原理，`chunk`、`bundle`和`module`的区别和应用

- 8.可熟练配置已有的`loaders`和`plugins`解决问题，可以自己编写`loaders`和`plugins`

## 内容平台建设、权限管理平台、单点登陆

### **nginx**

- 1.正向代理与反向代理的特点和实例
- 2.可手动搭建一个简单的`nginx`服务器、
- 3.熟练应用常用的`nginx`内置变量，掌握常用的匹配规则写法
- 4.可以用`nginx`实现请求过滤、配置`gzip`、负载均衡等，并能解释其内部原理

### **开发提速**

- 1.熟练掌握一种接口管理、接口`mock`工具的使用，如`yapi`
- 2.掌握一种高效的日志埋点方案，可快速使用日志查询工具定位线上问题
- 纯前端版本发布
- 3.理解`TDD`与`BDD`模式，至少会使用一种前端单元测试框架

### **持续集成**

- 1.理解`CI/CD`技术的意义，至少熟练掌握一种`CI/CD`工具的使用，如`Jenkins`
- 2.可以独自完成架构设计、技术选型、环境搭建、全流程开发、部署上线等一套完整的开发流程（包括`Web`应用、移动客户端应用、`PC`客户端应用、小程序、`H5`等等）





###### 打包流程

```javascript
# 打包环境的安装
# 安装依赖
# eslint
# 开始打包（uglify、source-map、css、img、iconfont、JSON、external package、JS）
# 加载插件，生成dist包
```

**npm安装依赖的原理是怎样的？怎样避免AB模块同时安装同一个模块？通过什么进行管理？有什么缺陷？怎么改进？npm、npx、yarn之间的区别是怎样的？如何发布一个包？发布一个包需要注意的事项？**



**eslint的使用原理是怎样的？怎样去写一个eslint校验器？**



**uglify原理是怎样的？怎么抽离css、img、iconfont、JS到不同的目录下？Sou'r'ce-map的原理？如何懒加载JS？external package是什么东西？**

**plugins的使用原理是怎样的？怎样写一个插件？**

**什么叫做Polyfill，它与babel有什么区别？怎么写一个babel？**

**你是如何发布一个包的？如何搭建一个内网的gitlab？里面的大概步骤是如何的？有什么需要注意吗？如何配置CI/CD？使用过金克斯吗？**



## **运行环境**

> ## 我们需要理清语言和环境的关系：
>
> `ECMAScript`描述了`JavaScript`语言的语法和基本对象规范
>
> 浏览器作为`JavaScript`的一种运行环境，为它提供了：文档对象模型（`DOM`），描述处理网页内容的方法和接口、浏览器对象模型（`BOM`），描述与浏览器进行交互的方法和接口
>
> Node也是`JavaScript`的一种运行环境，为它提供了操作`I/O`、网络等`API`



### **浏览器API**

- 1.浏览器提供的符合`W3C`标准的`DOM`操作`API`、浏览器差异、兼容性
- 2.浏览器提供的浏览器对象模型 (`BOM`)提供的所有全局`API`、浏览器差异、兼容性
- 3.大量`DOM`操作、海量数据的性能优化(合并操作、`Diff`、`requestAnimationFrame`等)
- 4.浏览器海量数据存储、操作性能优化
- 5.`DOM`事件流的具体实现机制、不同浏览器的差异、事件代理
- 6.前端发起网络请求的几种方式及其底层实现、可以手写原生`ajax`、`fetch`、可以熟练使用第三方库
- 7.浏览器的同源策略，如何避免同源策略，几种方式的异同点以及如何选型
- 8.浏览器提供的几种存储机制、优缺点、开发中正确的选择
- 9.浏览器跨标签通信



### **浏览器原理**

- 1.各浏览器使用的`JavaScript`引擎以及它们的异同点、如何在代码中进行区分

- 2.请求数据到请求结束与服务器进行了几次交互

- 3.可详细描述浏览器从输入`URL`到页面展现的详细过程

- 4.浏览器解析`HTML`代码的原理，以及构建`DOM`树的流程

- 5.浏览器如何解析`CSS`规则，并将其应用到`DOM`树上

- 6.浏览器如何将解析好的带有样式的`DOM`树进行绘制

- 7.浏览器的运行机制，如何配置资源异步同步加载

- 8.浏览器回流与重绘的底层原理，引发原因，如何有效避免

- 9.浏览器的垃圾回收机制，如何避免内存泄漏

- 10.浏览器采用的缓存方案，如何选择和控制合适的缓存方案

  

### **Node**

- 1.理解`Node`在应用程序中的作用，可以使用`Node`搭建前端运行环境、使用`Node`操作文件、操作数据库等等
- 2.掌握一种`Node`开发框架，如`Express`，`Express`和`Koa`的区别
- 3.熟练使用`Node`提供的`API`如`Path`、`Http`、`Child Process`等并理解其实现原理
- 4.`Node`的底层运行原理、和浏览器的异同
- 5.`Node`事件驱动、非阻塞机制的实现原理

