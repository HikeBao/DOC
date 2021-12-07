#### Establish CI/CD

```javascript
# step first
安装gitlab-runner
参考： 
https://docs.gitlab.com/runner/install/linux-repository.html

# step second
安装runner
sudo yum install gitlab-runner

# step third
gitlab-ci-multi-runner register
```



#### Why GitLab running slow？

```javascript
Because of less than cpu amount or memory

Gitlab的运行对CPU是有要求的：2核心 支持500用户，这也是官方推荐的最低标准。
Gitlab的运行对内存是有要求的：Memory 4GB 物理内存 支持100用户，也是 官方推荐 的配置。
打开 /etc/gitlab/gitlab.rb 文件
```



#### VI useful command

```javascript
/searchString search what you want to search
:set nu set every line number
:number go to the line which was number in

# vue frame
vue init webpack vue-project-name
```



#### give user power

```javascript
# solution one
usermod -g root tommy -- 将tommy加入root组

# solution two
modify /etc/sudoers,find which one `root ALL=(ALL) ALL`
below add `username ALL=(ALL) ALL`

这里可能会遇到sudo权限报错提示
```



#### cicd坑

```javascript
每个作业完成后都会删除上一个作业残留下来的东西才会开始下一个作业。

summary：发现对于linux系统玩得还是不够6，导致一些很基本的查看用户组、权限以及网络设置都不会，这块要跟shell结合一起来。
```



#### Runner注册之后发现有错该怎么办

```javascript
Setp 1 - 查找错误Runner的token和url
gitlab-runner list

Step 2 - 取消注册错误的Runner
gitlab-runner unregister -u 错误Runner的URL -t 错误Runner的TOKEN

Step 3 - 重新注册Runner
gitlab-runner register
```