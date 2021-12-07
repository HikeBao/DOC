> 从你按下启动电源那一刻，电脑都发生了什么？
>
> 1、载入BIOS的硬件信息与进行自我检测，并依据设置取得第一个可开机的设备
>
> 2、读取并执行第一个可开机设备里面的BOOT LOADER程序
>
> 3、依据BOOT LOADER 的设置载入Kernel，Kernel监听硬件信息，载入驱动程序
>
> 4、再硬件驱动成功后，Kernel会主动调用Systemd程序

```shell
# 专有名词解释
BIOS：Basic Input Output System
MBR：虽然分区表有传统 MBR 以及新式 GPT，不过 GPT 也有保留一块相容 MBR 的区
块，因此，下面的说明在安装 boot loader 的部份， 鸟哥还是简称为 MBR 喔
```



- 安装docker过程中，出现了本地时间戳和线上得时间戳不一致问题，引发出一个要同步时间得概念

  ```javascript
  // 报错信息
  Error response from daemon: Get https://index.docker.io/v1/search?q=centos: x509: certificate has expired or is not yet valid
  
  // 解决方案
  ntpdate cn.pool.ntp.org
  ```

  

- 接下来就是链式错误，说没有这个指令

  ```javascript
  // 报错信息
  -bash: ntpdate: command not found
  
  // 解决方案
  sudo yum install ntpdate
  ```

  

- `docker search repositoryName[:tag] --filters-stars=num`   ：搜索仓库，类似git view packageName versions

- `docker pull packegeName`: 下载对应得仓库

- `docker images` ：查看本地仓库

- `docker push 镜像：tags `  :**如何将镜像推送到docker hub网站**

- docker三要素

  - 镜像
  - 容器
  - 仓库(docker registry)

### docker入门指令

- docker images  查看镜像

- docker run -t -i centos:latest /bin/bash 启动容器(允许交互)

- docker run centos:latest /bin/echo 'hellow' 在容器里面输出hellow 这也是创建一个实例。如果加上参数-d则会在后台运行docker run -d centos:latest /bin/sh -c ""，如果想要查看内容，则可以通过docker container logs containerID查看对应的实例情况

- docker container start/stop/restart 启动/终止/重启一个实例

- docker container ls -a 查看所有实例

- 重新进入实例进行操作

  - docker run -dit centos  // 启动镜像的某个实例
  - docker container ls // 查看实例
  - docker attach containerID 进入实例,如果退出exit,会导致容器的停止
  - docker exec -it containerID bash // 进入实例，如果退出，也不会导致容器的停止

- 导入导出实例: 

  - docker export containerID > InstanceName  // 导出实例快照
  - cat InstanceName | docker import - mirrorName:tagName  // 导入实例
  - docker import URL mirrorName:tagName // 通过url导入实例
  - tips:用户既可以使用docker load导入实例，区别是丢弃所有历史记录和元数据信息。
  - 删除实例：docker container rm containerID
  - 删除所有处于终止状态的实例：docker container prune

  > 1、按“Ctrl+Alt+T”即可打开终端窗口。
  >
  > 2、按“Ctrl+Alt+F1-F6”均可进入终端
  >
  > 使用以上两命令可以退出sh运行



#### docker搭建nginx服务器(Centos)

```ini
安装nginx源
rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm

该命令执行之后，会在/etc/yum.respos.d下面多出一个nginx.repo
yum install -y nginx  -- 安装nginx
whereis nginx     -- 查找nginx位置
/usr/sbin/nginx   --启动nginx
docker run -p 8080:80 -i -t ubuntu /bin/bash --映射端口
docker port web -- 查看docker给web实例映射的端口号
ip addr -- centos OS下是使用该命令，如果是其他系统则使用ifconfig，window是ipconfig,在里面找到对应的ip，然后配合docker映射的端口号即可访问nginx.一般都是ens33这个,如果不确定的话可以在cmd里面进行ping，ping通则ok
```

#### establish nginx server

```javascript
# step one
docker search nginx

# step two
docker pull imageName

# step three
docker run imageID

# step four
docker exec -it containerID bash

// How to get the containerID ?
Just use command `docker container ls`
```



#### How to install node

```javascript
# step one
Your OS must have wget command, otherwise `yum install wget`

# step two 
Go to the nodejs official website to get the latest install package URL.

# step three
wget URL
```



#### How to save the container 

```javascript
# step first
export containerID > fileName
execute above command, you will make a file name which you custom

# step second
cat fileName | docker import - imageName:Version
Then, you will get a image name `imageName`

# step third 
`docker run -p localIp:dockerIP -dit /bash/bin`
```

