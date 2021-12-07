#### 一号开发任务坑

```ini
2019年7月9日这天，当时有个紧急的bug需要从分支2.0.10切换到2.0.8，为了不再去拉代码，所以第一次使用了命令stash，当时出现了一个问题，就是提示说...rm: commond not found。原来stash命令底层应用到rm，而且当时我的git内置的rm不知道咋滴就没了，后来重装一次git后rm命令就回来了。然后git stash也成功了，结合git stash list，
git apply stashName一起使用超级棒
```



#### 二号不懂英文坑

```ini
git checkout master
Switched to branch 'master'
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
  
explain: 当前`master`分支比远程的`origin/master`分支要超前1个提交。提示将本地的提交推送到远程分支。出现`origin/master`表示的是远程分支，`master`表示是本地分支
```



#### 三号长期存在坑

```ini
当master分支或者origin/master分支与feature分支同时有提交的时候，那么就很可能产生冲突。
git merge feature1
Auto-merging readme.txt
CONFLICT (content): Merge conflict in readme.txt
Automatic merge failed; fix conflicts and then commit the result.

explain：一般情况下，如果线上和本地的提交没有同时修改同一个文件的话，系统会自动合并。
如果产生冲突Git用<<<<<<<，=======，>>>>>>>标记出不同分支的内容

橙色部分是`origin/master`分支上面的，绿色部分是本地的
# <<<<<<< HEAD
# Creating a new branch is quick & simple.
# =======
: Creating a new branch is quick AND simple.
: >>>>>>> feature1'
```

![产生冲突原因](.\img\conflict.png)

![成功处理冲突](.\img\solution_conflict.png)



#### 四号提交冲突坑

```ini
// 由于远程分支已经存在而产生的错误 

! [rejected]  257-master-cp -> bug-34687-ccq (fetch first)
error: failed to push some refs to 'http://****.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```



#### 五号专业名词坑

```ini
Git 常见英文意思
hint: 提示
remote: 远程仓库
ref: 引用 reference的缩写
reflog： reference log 每一次你提交或改变分支，引用日志都会被更新。
integrate: 集成
```



#### 六号提交中断坑

```ini
fatal: Unable to create 'C:/Users/lenovo/Desktop/getfilename/fsdf/.git/index.lock': File exists.

Another git process seems to be running in this repository, e.g.an editor opened by 'git commit'. Please make sure all processesare terminated then try again. If it still fails, a git process may have crashed in this repository earlier:remove the file manually to continue.

通俗讲，就是我们在commit的时候，会自动生成一个index.lock文件，操作完成后，会自动删除。如果在commit过程中，产生了意外，比如手动退出了，电脑死机了，断网了等等，导致操作失败，没有自动删除index.lock文件，那么下次再commit的时候，系统不知道你的index.lock没删除，它会傻傻的再去创建index.lock文件，这时候，发现已经目录下已经有一个index.lock文件了，懵逼了，不知道咋处理了，所以抛错给你：
: 在确定要删除index.lock文件之前，要确定产生index.lock文件的程序已经不再运行了,不然会导致数据丢失或者冲突的危机
```



#### 七号回退版本坑

```ini
回退前先在主线上创建一个分支，git branch mainLineBranch。然后再使用git reset --hard HEAD ^ 回退上一次的版本，等对应的代码修改完毕后再使用git merge mainLineBranch恢复到最新版本的代码，很可能会有冲突。
```



#### 八号误删分支坑

```ini
使用git reflog查看上一次的哈希值，然后使用git show HashID查看修改的内容是否正确，然后使用git branch branchName hashID恢复指定的分支，前提是里面的reflog还是完好无损。
由于reflog是依赖于.git/logs/文件，如果logs文件没有的话，怎么办？可以使用git fsck --full指令匹配悬空的分支对象，然后老规矩使用git show hashID展示对应的分支内容
```



#### fork

```javascript
GitHub的Fork 是什么意思# 现在有这样一种情形：有一个叫做Joe的程序猿写了一个游戏程序，而你可能要去改进它。并且Joe将他的代码放在了GitHub仓库上。# 下面是你要做的事情fork并且更新GitHub仓库的图表演示 // 如下图1. Fork他的仓库：这是GitHub操作，这个操作会复制Joe的仓库（包括文件，提交历史，issues，和其余一些东西）。复制后的仓库在你自己的GitHub帐号下。目前，你本地计算机对这个仓库没有任何操作。2. Clone你的仓库：这是Git操作。使用该操作让你发送"请给我发一份我仓库的复制文件"的命令给GitHub。现在这个仓库就会存储在你本地计算机上。3. 更新某些文件：现在，你可以在任何程序或者环境下更新仓库里的文件。4. 提交你的更改：这是Git操作。使用该操作让你发送"记录我的更改"的命令至GitHub。此操作只在你的本地计算机上完成。5. 将你的更改push到你的GitHub仓库：这是Git操作。使用该操作让你发送"这是我的修改"的信息给GitHub。Push操作不会自动完成，所以直到你做了push操作，GitHub才知道你的提交。6. 给Joe发送一个pull request：如果你认为Joe会接受你的修改，你就可以给他发送一个pull request。这是GitHub操作，使用此操作可以帮助你和Joe交流你的修改，并且询问Joe是否愿意接受你的"pull request"，当然，接不接受完全取决于他自己。7. 如果Joe接受了你的pull request，他将把那些修改拉到自己的仓库！
```

![fork](.\img\fork.png)



#### Local Rollback

```javascript
# modifies
git checkout FileName

# untracked
git clean -f FileName | rm -rf FileName

# staged but not commit
git rm --cache FileName | git rm --cache .

# after commit
git reset --hard origin/master | git reset --hard HashId
// tips: reset can't replace by revert, otherwise will launch an error;
// Before use git revert HEAD@{number} or git revert HashId, you must be in revert target branch
// if not, you will get a error tips;

# A lot of files want to ignort
You can create a directory names .gitignore, and add url which folder do you want to ignore.
```



#### git command

```javascript
git branch -av // add option v,can show more information about lasted commit
# show remote detail
git remote -v
```



#### git reset --hard 

```javascript
# 缺省情况
git reset缺省为git reset --soft

# 二者区别：
git reset –-soft：回退到某个版本，只回退了commit的信息，不会恢复到index file一级。如果还要提交，直接commit即可
git reset -–hard：彻底回退到某个版本，本地的源码也会变为上一个版本的内容，撤销的commit中所包含的更改被冲掉
```



#### How recover local deleted file

```javascript
# staged
git reset HEAD FileName

# modifies
git checkout FileName
```



#### cherry-pick

```javascript
获取某分支上的某个提交到当前分支
eg: git cherry-pick C1 C2 获取C1 C2到当前分支currentBranch <- C1 <- C2
```



#### rebase

```javascript
rebase：from the word meaning change the base branch.So generally be use to which branch would you want to change the base.
ex: git rebase -i targetBase // -i means interactive,targetBase can be hashID or branchName.
```



#### tag

```javascript
tag just as a reference for which one want to as a version milepost indentification. 
git tag v1.0 // tiny label
git tag -a v1.0 -m 'description' // tagging label
git push origin v1.0 // push the tag to the remote repository
after commit: git tag -a v1.0 hashID
```



#### Basic Git

```javascript
将git add命令理解为“添加内容到下一次提交中”而不是“将一个文件添加到项目中”要更加合适。

根据文件可能存在的状态，可将Git划分为三个区：暂存区、工作区以及仓库区。而工作区只是仓库区里面的一个版本。

# 文件 .gitignore 的格式规范如下：
1. 所有空行或者以 ＃ 开头的行都会被 Git 忽略。
2. 可以使用标准的 glob 模式匹配。
3. 匹配模式可以以（ / ）开头防止递归。
4. 匹配模式可以以（ / ）结尾指定目录。
5. 要忽略指定模式以外的文件或目录，可以在模式前加上惊叹号（ ! ）取反。

# only ignore the TODO file in the current directory, not subdir/TODO
/build
# ignore all files in the build/ directory
build/
    
    
记住，在 Git 中任何 已提交的 东西几乎总是可以恢复的。 甚至那些被删除的分支中的提交或
使用 --amend 选项覆盖的提交也可以恢复。 然而，任何你未提交的东西丢失后很可能再也找不到了。

# git remote
如果你已经克隆了自己的仓库，那么至少应该能看到 origin - 这是Git 给你克隆的仓库服务器的默认名字：

# git remote add
# git remote rm 
# git remote show remoteName
它也同样地列出了哪些远程分支不在你的本地，哪些远程分支已经从服务器上移除了，还有当你执行 git pull 时哪些分支会自动合并。

# git remote rename A B  将仓库A命名为仓库B
如果使用git branch -vv查看的话，可以看见斜杠左侧第一个名字就是远程仓库的名字，后面的如果有斜杠或者其他一些标识符都可以认为是命名空间。而且要注意的是，是在当前仓库敲git branch的，所以第一个名字要么没有，要么就是一样。而也可以查看其他远程分支，你可以使用"git pull remoteName/branchName"合并到当前分支上

对了，这里的remote概念可以跟之前的"git branch --set-upstream-to"以及"git branch --track"联系起来

# git remote prune originName
表示本地分支和远程仓库保持一致，如果远程仓库已经删除了某分支，但是本地分支还存在，那么可以使用该命令来同步本地分支的状态，后面的originName是远程仓库的名字

# git别名
git config --global alias.co checkout

# git reset HEAD -- FileName // 恢复某个文件，注意有两个中横线
  git reset HEAD . // 从暂存区中恢复中恢复所有文件
  git rest HEAD URL/* 恢复某个路径下面的所有文件
```



#### Git Branch

```javascript
# 微信版本踩坑，在Git branch章节开始就说明了分支的作用使用分支意味着你可以把你的工作从开发主线上分离开来，以免影响开发主线。# master分支Git 的 `master` 分支并不是一个特殊分支。 它就跟其它分支完全没有区别。 之所以几乎每一个仓库都有 master 分支，是因为 `git init` 命令默认创建它，并且大多数人都懒得去改动它。哈哈哈，这里跟远程仓库origin有异曲同工之妙Git 的分支，其实本质上仅仅是指向提交对象的可变指针。那么，Git 又是怎么知道当前在哪一个分支上呢？ 也很简单，它有一个名为 HEAD 的特殊指针。 请注意它和许多其它版本控制系统（如 Subversion 或 CVS）里的 HEAD 概念完全不同。 在 Git 中，它是一个指针，指向当前所在的本地分支（译注：将 HEAD 想象为当前分支的别名）。# git checkout master这条命令做了两件事。 一是使 HEAD 指回 master 分支，二是将工作目录恢复成 master 分支所指向的快照内容。由于 Git 的分支实质上仅是包含所指对象校验和（长度为 40 的 SHA-1 值字符串）的文件，所以它的创建和销毁都异常高效。 创建一个新分支就像是往一个文件中写入 41 个字节（40个字符和 1 个换行符），如此的简单能不快吗？这与过去大多数版本控制系统形成了鲜明的对比，它们在创建分支时，将所有的项目文件都复制一遍，并保存到一个特定的目录。 完成这样繁琐的过程通常需要好几秒钟，有时甚至需要好几分钟。所需时间的长短，完全取决于项目的规模。而在 Git 中，任何规模的项目都能在瞬间创建新分支。 同时，由于每次提交都会记录父对象，所以寻找恰当的合并基础（译注：即共同祖先）也是同样的简单和高效。 这些高效的特性使得 Git 鼓励开发人员频繁地创建和使用分支。
```

#### 分支合并

```javascript
三方合并称为diverged，Git 会使用两个分支的末端所指的快照（ C4 和 C5 ）以及这两个分支的工作祖先（ C2 ），做一个简单的三方合并。
```



#### 分支推送

```javascript
如果并不想让远程仓库上的分支叫做 serverfix ，可以运行git push origin serverfix:awesomebranch 来将本地的 serverfix 分支推送到远程仓库上的awesomebranch 分支。

# details
这里要详细讲解一下git push origin A:B。
git push origin 表示要推送分支到名为origin的远程仓库
A:B表示的是要将本地的分支A推送到对应的远程分支B上面
```



#### 远程分支

```javascript
# 这就是为甚什么当初我删除不了本地的远程分支原因，这里可是大有学问
要特别注意的一点是当抓取到新的远程跟踪分支时，本地不会自动生成一份可编辑的副本（拷贝）。 换一句话说，这种情况下，不会有一个新的 serverfix 分支 - 只有一个不可以修改的 origin/serverfix 指针。
可以运行 git merge origin/remoteBranchName 将这些工作合并到当前所在的分支。 如果想要在自己的 serverfix 分支上工作，可以将其建立在远程跟踪分支之上：git checkout -b customBranchName origin/remoteBranchName
```



#### 重大公告

```javascript
git branch --set-upstream-to remoteName/remoteBranchName
其中--set-upstream-to 可以缩写为-u
git branch -u remoteName/remoteBranchName

当设置好跟踪分支后，可以通过 @{upstream} 或 @{u} 快捷方式来引用它。 所以在 master 分支时并且它正在跟踪 origin/master 时，如果愿意的话可以使用 git merge @{u} 来取代 git merge origin/master 。

git log --pretty=online可以缩减为git log --oneline
```



#### 重新理解git fetch的作用

```javascript
当使用git branch -vv 命令时会展示分支的关联情况.这个命令并没有连接服务器，它只会告诉你关于本地缓存的服务器数据。 如果想要统计最新的领先与落后数字，需要在运行此命令前抓取所有的远程仓库。 可以像这样做： $ git fetch --all;git branch -vv
```



#### 变基原则

```javascript
总的原则是，只对尚未推送或分享给别人的本地修改执行变基操作清理历史，从不对已推送至别处的提交执行变基操作，这样，你才能享受到两种方式带来的便利。
```



#### 删除某个版本最佳实践

```javascript
使用git cherry-pick deleteVersion即可,因为这样可以对照着删除，而不会影响其他已提交的版本
```



#### git reset 常见的参数配置

```javascript
git reset <commit-id>  # 默认就是-mixed参数。

git reset –mixed HEAD^  # 回退至上个版本，它将重置HEAD到另外一个commit,并且重置暂存区以便和HEAD相匹配，但是也到此为止。工作区不会被更改。

git reset –soft HEAD~3  # 回退至三个版本之前，只回退了commit的信息，暂存区和工作区与回退之前保持一致。如果还要提交，直接commit即可  

git reset –hard <commit-id>  # 彻底回退到指定commit-id的状态，暂存区和工作区也会变为指定commit-id版本的内容

注意了，这里的HEAD用来表示当前的工作区更为准确，因为分支可以有很多，但是，工作区只有一个，用什么可以唯一标志当前的工作区呢？很明显用HEAD 是最为恰当。
而且，你可能注意到了，无论是branchName、HEAD、和tag，他们都是唯一指向一个哈希值，而git对比其他VC，最大的特点就是使用键值数据库来存储当前的数据。
另外git的命令有点类似bash，完全可以自己手写一个git仓库出来。无论是命令提示还是参数，都与脚手架很类似。
```



#### 增加远程仓库

```javascript
# git remote add remoteName URL
```



#### 快速切换到上一个分支

```javascript
git checkout -
```



#### 关联远程分支

```sh
关联之后，`git branch -vv` 就可以展示关联的远程分支名了，同时推送到远程仓库直接：`git push`，不需要指定远程仓库了。git branch -u origin/mybranch或者在 push 时加上 `-u` 参数git push origin/mybranch -u
```



#### 重命名分支

```sh
git branch -m <new-branch-name>
```

#### 推送方式

```javascript
# 解释了当时为什么要注册账号才能推送的问题。
一般通过http可以免账号，使用ssh要用账号密码登陆。通常对于公开项目可以优先分享基于 HTTP 的 URL，因为用户克隆项目不需要有一个 GitHub 帐号。 如果你分享 SSH URL，用户必须有一个帐号并且上传SSH 密钥才能访问你的项目。 HTTP URL 与你贴到浏览器里查看项目用的地址是一样的。
```



#### 2019年10月5日

到目前为止，Git学习已经取得阶段成成功，接下来就是如何利用掌握的的知识应用到日常开发活动中，并思考如何提高开发效率。接下来就是考虑Git的诞生以及如何影响开发，通过Git思考如何去创建一个类似的APP应用



#### git和svn的区别

```javascript
# git是分布式版本控制系统
git 支持离线工作，提交。每一个子仓库都是一个完整的系统，保存着项目正常工作所需要的所有文件。服务器宕机后还可以继续正常工作，查看日志，回退版本，修改分支

# svn是集中式版本控制系统
不支持离线工作，每一个子仓库都只是版本里面的一部分，服务器宕机后将不能进行正常操作

他们都是增量式记录每个版本的不同。
```



#### fetch、merge和pull的区别

```javascript
fetch + merge = pull
fetch获取remote上面的最新提交，merge是将最新的提交合并到分支里面去。而pull则是fetch后立即merge
```



#### 什么是tag,他有什么作用

```javascript
一般而言，分支会随着提交的改变而移动，有没有一种办法，用一个像标签一样记录某个提交记录而不随着提交的改变而改变呢？那就是tag
```



#### **Git工作流程**

```javascript
1. 在工作区进行文件的修改
2. 将修改提交到暂存区
3. 将暂存区推送到仓储区

# 1 > 2 之间发生了什么？
- 对每个改变的文件分别生成一个内容对象并生成唯一标识符
- 然后将每个内容对象用一个树对象串联起来,形成清晰的目录结构

# 2 > 3 之间发生了什么
- 生成提交对象，结合树对象生成唯一标识符，并将唯一标识符推送到仓储区
```



#### HEAD、工作树和index之间的区别

```javascript
HEAD是包含当前工作分支的引用
工作树是把某分支检出到工作区形成的目录树
index文件是对工作树进行代码修改后通过add命令更新索引文件
```



#### 之前项目中是使用的GitFlow工作流程吗？它有什么好处？

```javascript
master
 - develop
	- feature
		- bug/fix/hot

好处：明确每个分支的作用，有利于快速迭代和多版本并行开发
```



#### Git基本原理总结

```javascript
Git 的核心部分是一个简单的键值对数据库（key-value data store）。其中保存着git的对象，其中最重要的是`blob`、`tree`和`commit`对象，blob对象实现了对文件内容的记录，tree对象实现了对文件名、文件目录结构的记录，commit对象实现了对版本提交时间、版本作者、版本序列、版本说明等附加信息的记录。这三类对象，完美实现了git的基础功能：对版本状态的记录。

Git引用是指向git对象hash键值的类似指针的文件。通过Git引用，我们可以更加方便的定位到某一版本的提交。Git分支、tags等功能都是基于Git引用实现的。

git仓库主要关注点：`index`(暂存区)，`objects`(目录)，`config`(用户信息)，`refs`(分支信息)，HEAD(指向当前分支)，
```



#### 内容对象（content object）

```javascript
- git init  用于创建一个空的git仓库，或重置一个已存在的git仓库
- git hash-object -w --stdin，用于向Git数据库中写入数据
  该命令可将任意数据保存于 .git 对象数据库，并返回相应的键值。

  -w 选项指示 hash-object 命令存储数据对象；若不指定此选项，则该命令仅返回对应的键值。 --stdin选项则指示该命令从标准输入读取内容；若不指定此选项，则须在命令尾部给出待存储文件的路径。 **注意，这里并没有创建新的文件便直接存进数据库**

# 将文件保存至git数据对象中
  - echo 'xxxx' > test.txt 
    git hash-object -w test.txt 

# 查看Git数据库中数据。其中，-t选项用于查看键值对应数据的类型，-p选项用于查看键值对应的数据内容
  - git cat-file -t/-p <hashValue>
    
# 恢复test.txt文件某个版本的内容
	git cat-file -p hashValue > test.txt
```



**树对象（tree object）**

> 如果不是外部引入树对象，那么在暂存区里面的对象都是blob对象。

- 创建树对象之前首先要通过暂存一些文件来创建一个暂存区。可以通过命令update-index为一个单独文件创建一个暂存区`

  - ```console
    git update-index --add --cacheinfo <mode> <hashValue> <fileName>`
    ```

- 创建好了暂存区就可以往暂存区里面存一个或多个数据对象

  - ```console
    git write-tree
    ```

- 也可以往暂存区里面存放一个或多个树对象

  - ```console
    git read-tree --prefix=bak <hashValue>
    ```

- 查看暂存区内容

  - ```console
    git ls-files --stage   
    ```

    

**提交对象（commit object）**

> 现在有N个树对象，分别代表了我们想要跟踪的不同项目快照。然而问题依旧：若想重用这些快照，你必须记住所有三个 `SHA-1` 哈希值。 并且，你也完全不知道是谁保存了这些快照，在什么时刻保存的，以及为什么保存这些快照。 而以上这些，正是提交对象（commit object）能为你保存的基本信息

- 创建一个提交对象

  

  ```ini
  echo 'first commit' | git commit-tree d8329f
  提交对象的格式很简单：它先指定一个顶层树对象，代表当前项目快照；然后是作者/提交者信息（依据你的 user.name 和 user.email 配置来设定，外加一个时间戳）；留空一行，最后是提交注释。
  ```

**Git引用**

> 我们可以借助类似于 `git log 1a410e` 这样的命令来浏览完整的提交历史，但为了能遍历那段历史从而找到所有相关对象，你仍须记住 `1a410e` 是最后一个提交。 我们需要一个文件来保存 `SHA-1` 值，并给文件起一个简单的名字，然后用这个名字指针来替代原始的 `SHA-1` 值。

- 更新某个引用

  - ```console
    git update-ref refs/heads/master 1a410efbd13591db07496601ebc7a059dd55cfe9
    ```

**HEAD引用（HEAD reference）**

> 现在的问题是，当你执行 `git branch (branchname)` 时，Git 如何知道最新提交的` SHA-1` 值呢？ 答案是 HEAD 文件。

- 查看`HEAD`引用的值

  - ```console
    cat .git/HEAD
    ```

- 设置 HEAD 引用的值

  - ```console
    // 如果branchName是x/y/z的形式，则会在heads文件夹// 下面创建文件名闻x>y下的z文件 这里解释了胡雷当初为// 什么会有斜杠的分支名git symbolic-ref HEAD refs/heads/<branchName>
    ```

**标签引用（tag reference）**

> 前文我们刚讨论过 Git 的三种主要对象类型，事实上还有第四种。 标签对象（tag object）非常类似于一个提交对象——它包含一个标签创建者信息、一个日期、一段注释信息，以及一个指针。 主要的区别在于，标签对象通常指向一个提交对象，而不是一个树对象。 它像是一个永不移动的分支引用——永远指向同一个提交对象，只不过给这个提交对象加上一个更友好的名字罢了。

- 创建一个轻量标签

  - ```console
    // 轻量标签 一般是用于临时的标签 ，轻量标签仅仅记录了// commit的信息git update-ref refs/tags/test <hashValue>
    ```

- 创建一个附注标签

  - ```console
    // 附注标签 记录的信息更为详细 它包含了创建标签的作者 // 创建日期 以及标签信息。一般建议创建附注标签。git tag -a <tagName> <hashValue> -m <tagComment>
    ```

**引用规格**

纵观全书，我们已经使用过一些诸如远程分支到本地引用的简单映射方式，但这种映射可以更复杂。 假设你添加了这样一个远程版本库：

```console
$ git remote add origin https://github.com/schacon/simplegit-progit
```

上述命令会在你的 `.git/config` 文件中添加一个小节，并在其中指定远程版本库的名称（`origin`）、URL 和一个用于获取操作的引用规格（refspec）：

```ini
[remote "origin"]	url = https://github.com/schacon/simplegit-progit	fetch = +refs/heads/*:refs/remotes/origin/*
```

引用规格的格式由一个可选的 `+` 号和紧随其后的 `<src>:<dst>` 组成，其中 `<src>` 是一个模式（pattern），代表远程版本库中的引用；`<dst>` 是那些远程引用在本地所对应的位置。 `+` 号告诉 Git 即使在不能快进的情况下也要（强制）更新引用。

默认情况下，引用规格由 `git remote add` 命令自动生成， Git 获取服务器中 `refs/heads/` 下面的所有引用，并将它写入到本地的 `refs/remotes/origin/` 中。 所以，如果服务器上有一个 `master` 分支，我们可以在本地通过下面这种方式来访问该分支上的提交记录：

```console
$ git log origin/master$ git log remotes/origin/master$ git log refs/remotes/origin/master
```

上面的三个命令作用相同，因为 Git 会把它们都扩展成 `refs/remotes/origin/master`。

如果想让 Git 每次只拉取远程的 `master` 分支，而不是所有分支，可以把（引用规格的）获取那一行修改为：

```
fetch = +refs/heads/master:refs/remotes/origin/master
```

这仅是针对该远程版本库的 `git fetch` 操作的默认引用规格。 如果有某些只希望被执行一次的操作，我们也可以在命令行指定引用规格。 若要将远程的 `master` 分支拉到本地的 `origin/mymaster` 分支，可以运行：

```console
$ git fetch origin master:refs/remotes/origin/mymaster
```

你也可以指定多个引用规格。 在命令行中，你可以按照如下的方式拉取多个分支：

```console
$ git fetch origin master:refs/remotes/origin/mymaster \	 topic:refs/remotes/origin/topicFrom git@github.com:schacon/simplegit ! [rejected]        master     -> origin/mymaster  (non fast forward) * [new branch]      topic      -> origin/topic
```

在这个例子中，对 `master` 分支的拉取操作被拒绝，因为它不是一个可以快进的引用。 我们可以通过在引用规格之前指定 `+` 号来覆盖该规则。

你也可以在配置文件中指定多个用于获取操作的引用规格。 如果想在每次获取时都包括 `master` 和 `experiment` 分支，添加如下两行：

```ini
[remote "origin"]	url = https://github.com/schacon/simplegit-progit	fetch = +refs/heads/master:refs/remotes/origin/master	fetch = +refs/heads/experiment:refs/remotes/origin/experiment
```

我们不能在模式中使用部分通配符，所以像下面这样的引用规格是不合法的：

```
fetch = +refs/heads/qa*:refs/remotes/origin/qa*
```

但我们可以使用命名空间（或目录）来达到类似目的。 假设你有一个 QA 团队，他们推送了一系列分支，同时你只想要获取 `master` 和 QA 团队的所有分支而不关心其他任何分支，那么可以使用如下配置：

```ini
[remote "origin"]	url = https://github.com/schacon/simplegit-progit	fetch = +refs/heads/master:refs/remotes/origin/master	fetch = +refs/heads/qa/*:refs/remotes/origin/qa/*
```

如果项目的工作流很复杂，有 QA 团队推送分支、开发人员推送分支、集成团队推送并且在远程分支上展开协作，你就可以像这样（在本地）为这些分支创建各自的命名空间，非常方便。

### 引用规格推送

像上面这样从远程版本库获取已在命名空间中的引用当然很棒，但 QA 团队最初应该如何将他们的分支放入远程的 `qa/` 命名空间呢？ 我们可以通过引用规格推送来完成这个任务。

如果 QA 团队想把他们的 `master` 分支推送到远程服务器的 `qa/master` 分支上，可以运行：

```console
$ git push origin master:refs/heads/qa/master
```

如果他们希望 Git 每次运行 `git push origin` 时都像上面这样推送，可以在他们的配置文件中添加一条 `push` 值：

```ini
[remote "origin"]	url = https://github.com/schacon/simplegit-progit	fetch = +refs/heads/*:refs/remotes/origin/*	push = refs/heads/master:refs/heads/qa/master
```

正如刚才所指出的，这会让 `git push origin` 默认把本地 `master` 分支推送到远程 `qa/master` 分支。

### 删除引用

你还可以借助类似下面的命令通过引用规格从远程服务器上删除引用：

```console
$ git push origin :topic
```

因为引用规格（的格式）是 `<src>:<dst>`，所以上述命令把 `<src>` 留空，意味着把远程版本库的 `topic` 分支定义为空值，也就是删除它。

或者你可以使用更新的语法（自Git v1.7.0以后可用）：

```console
$ git push origin --delete topic
```



注意每当仓库有任何改动的时候。eg：commit、pull、reset，文件refs下面的heads对应的分支哈希值会改变到最新，所以，当使用git branch newBranch的时候，git可以通过HEAD指向的最新的哈希值进行更新最新值



#### 配置文件

```javascript
# git三类配置文件
系统级 < 用户级 < 本地仓库级，优先级依次递增，文件名均是gitconfig

# 位置
系统级：C:\Program Files\Git\mingw64\etc
用户级：C:\Users\登陆的用户名\.gitconfig
本地仓库级：当前开发项目的.git文件下

一般配置默认账号和用户存放在在用户级的配置文件.gitconfig
系统级配置文件一般配置告警颜色、字体大小等
```



#### 项目常用命令

```javascript
# branch
`git branch -a`:查看所有本地的分支情况
`git branch -r`:查看所有远程仓库分支情况
`git branch -vv`:查看本地分支与远程仓库的关系
`git branch -D A`:删除A分支
`git branch --track A B`:将本地分支A关联到远程分支B,注意A不存在,所以会创建一个A
`git branch --set-upstream-to A `:将当前分支关联到远程分支A
`git branch recoverBranch <hashValue>`:恢复某一个分支

# remote
`git remote rename oldName newName`:给远程分支换个名字
`git remote rm B`:删除远程分支B
`git remote add origin URL`:将本地程序关联远程<b>空仓库</b>

# stash
`git stash`:保存当前工作栈，用于临时checkout其他分支
`git stash list`:查看当前分支的工作栈情况，为了获取上一次保存的工作栈值
`git stash apply stash@{n}`:恢复到指定栈
`git stash clear` 清除stash栈

# log
`git log --pretty=oneline`:每一条提交记录都在一行内显示
`git reflog`:查看日志，用于获取版本的哈希值或者查看提交记录

# other
`git status`:查看当前仓库状态，用于查看modifies了啥文件
`git add F`: 将文件F加入本地暂存区
`git commit -m 'remark'`:  将文件加入本地仓库，其中remark为注释
`git commit -am 'remark'`:git add 与git commit的结合体
`git commit push origin  B`: 将B分支的内容推送至远程仓库
`git commit -amend` 修改最近一次提交记录
`git fetch B`:获取远程仓库B分支的数据
`git merge B`:将B分支合并到当前分支，用于合并指定分支到当前分支。
`git pull B`:git fetch与git merge的结合体
`git clone -b <branch-name> --single-branch URL` 仅克隆仓库里面的某一个分支
`git config --global credential.helper store` 默认保存用户的信息，下次`push`或者`pull`不用用输入账号密码
`git push -u -f B`:强制把本地数据覆盖远程分支B

# 回滚
`git reset --hard HEAD^`:回退一次版本
`git reset --hard hashValue`: 回退到指定哈希值的版本，目标和其他提交一并回退，log回退到目标log
`git revert hashID`: 回退到目标提交，不影响其他提交，在原基础上生成新的log
`~<num> ^ ` 移动HEAD步数,其中~是可以一次回退多步，而^ 一次只能回退一步

相对引用最多的就是移动分支。可以直接使用 `-f` 选项让分支指向另一个提交。例如: git branch -f master HEAD~3
上面的命令会将 master 分支强制指向 HEAD 的第 3 级父提交。
```



#### 回滚详解

```javascript
# git reset --hard hashID
适用场景： 如果想恢复到之前某个提交的版本，且那个版本之后提交的版本我们都不要了，就可以用这种方法。

# git revert hashID
适用场景： 如果我们想撤销之前的某一版本，但是又想保留该目标版本后面的版本，记录下这整个版本变动流程，就可以用这种方法。

# git reset HEAD fileName
文件状态处于已经staged

# git checkout FileName/.
文件状态处于modifies

# git reset --hard origin/master
文件处于commited状态

# git clean -f FileName/.
```



#### 2019年9月7日

```javascript
# git branch --track A B   git branch --set-upstream-to B
问：同样是将本地分支关联到远程分支B，它们的区别是什么
答：git branch --track A B 前提是A分支不存在，系统会自动创建一个分支关联到远程分支B；而git branch --set-upstream-to B是当将前分支关联到远程分支B，前提是存在分支。
'公告：git branch --set-upstream-to 可以缩写为git branch -u'

# git仓库管理有多少种状态
 - untrack（未跟踪，一般是新创建的文件）
 - deleted (被删除)、modifies(被修改也称为not staged)
 - stage （已被暂存）
 - commited (已经存放到本地仓库)

# git reset --soft与git reset --hard 以及git reset --mixed(默认)的区别
答：git reset 默认就是--mixed模式，返回到指定的版本未被commit的状态即回退HEAD和index，对工作区不影响
git reset --hard 模式，返回到指定的版本且modifies的文件全部丢失，而且git reflog上面没有对应的返回信息.
reset有个问题，就是可以回退到某个版本，但是会遗留多余的提交，ex: 下面的 7ea179d
```

![](C:\Users\root\Desktop\workNote\技能类\专业技能\项目依赖、开发与打包\Git\img\reset.png)

#### 2020年10月24日

```javascript
# 当遇到一些文件没有被添加进来.gitignore的时候。希望git不跟踪，但是保留磁盘文件
- 当已经存放到暂存区了可以使用 git reset HEAD [filename | glob模式]
- 当已经提交了 可以使用git rm --cache [filename | glob模式] -r 将其从跟踪状态变为删除状态且保留磁盘文件，然后再git commit -m 'xxx'移除git的跟踪模式即可

# git checkout 其工作范畴有限
只能对Modified文件生效，使其回退至Unmodified状态。面对已经存放在暂存区的工作文件是起不了作用的。

# 直接rm -rf 文件和git rm 之间的区别
git rm 在rm -rf原基础上多加了一步将修改存放至缓存区的操作，其它都一样

# 日常生活中使用频率较多的操作
git status		--- 查看状态	
git checkout .   --- 快速清理没有add的文件
git commit -am ''  --- 快速提交（这个快捷面对还没被git跟踪的文件是无效的，必须是已经跟踪的文件才能生效）
git reset --hard  --- 用于同步远程分支，回退到无或者unmodified状态
git reset --soft  --- 用于将所有的提交放在一次性提交里面执行,回退到缓冲区状态
git log --oneline -xx --- 用于查看回退至哪条日志
git branch xxxx --- 新增个人分支，一般都会在版本分支上面直接进行开发，直到推送至远程的时候才会创建分支
git push origin developBranch:remoteBranch --- 用于将本地的修改推送到远程的remoteBranch分支上面去
git branch -a -- 查看当前存在哪些分支
git clean . -f --- 用于清理Untrack文件，因为前端会打出很多dist包
git stash  --- 保留现场
git stash pop --- 恢复现场

为什么最近开发很少使用
git branch -vv
git branch -u
git reset --mixed hashValue ---主要用于将已经cmmited的文件回退到untrack/modified的状态  
```

### **版本控制**

- 1.理解`Git`的核心原理、工作流程、和`SVN`的区别
- 2.熟练使用常规的`Git`命令、`git rebase`、`git stash`等进阶命令
- 3.可以快速解决`线上分支回滚`、`线上分支错误合并`等复杂问题
- 发布后分支锁死，不可更改
- 全自动流程发布，多版本并存
- 自建GitLab，(代码管理、权限管理、提交日志查询)







### Other e-Book

# Flight rules for Git

🌍
*[English](README.md) ∙ [Español](README_es.md)  ∙  [Русский](README_ru.md) ∙ [简体中文](README_zh-CN.md)∙ [한국어](README_kr.md)  ∙  [Tiếng Việt](README_vi.md) ∙ [Français](README_fr.md)*

#### What are "flight rules"?

A guide for astronauts (now, programmers using Git) about what to do when things go wrong.

>  *Flight Rules* are the hard-earned body of knowledge recorded in manuals that list, step-by-step, what to do if X occurs, and why. Essentially, they are extremely detailed, scenario-specific standard operating procedures. [...]

> NASA has been capturing our missteps, disasters and solutions since the early 1960s, when Mercury-era ground teams first started gathering "lessons learned" into a compendium that now lists thousands of problematic situations, from engine failure to busted hatch handles to computer glitches, and their solutions.

&mdash; Chris Hadfield, *An Astronaut's Guide to Life*.

#### Conventions for this document

For clarity's sake all examples in this document use a customized bash prompt in order to indicate the current branch and whether or not there are staged changes. The branch is enclosed in parentheses, and a `*` next to the branch name indicates staged changes.

All commands should work for at least git version 2.13.0. See the [git website](https://www.git-scm.com/) to update your local git version.

[![Join the chat at https://gitter.im/k88hudson/git-flight-rules](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/k88hudson/git-flight-rules?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Table of Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

  - [Repositories](#repositories)
    - [I want to start a local repository](#i-want-to-start-a-local-repository)
    - [I want to clone a remote repository](#i-want-to-clone-a-remote-repository)
    - [I set the wrong remote repository](#i-set-the-wrong-remote-repository)
    - [I want to add code to someone else's repository](#i-want-to-add-code-to-someone-elses-repository)
      - [Suggesting code via pull requests](#suggesting-code-via-pull-requests)
      - [I need to update my fork with latest updates from original repository](#i-need-to-update-my-fork-with-latest-updates-from-original-repository)
  - [Editing Commits](#editing-commits)
    - [What did I just commit?](#what-did-i-just-commit)
    - [I wrote the wrong thing in a commit message](#i-wrote-the-wrong-thing-in-a-commit-message)
    - [I committed with the wrong name and email configured](#i-committed-with-the-wrong-name-and-email-configured)
    - [I want to remove a file from the previous commit](#i-want-to-remove-a-file-from-the-previous-commit)
    - [I want to delete or remove my last commit](#i-want-to-delete-or-remove-my-last-commit)
    - [Delete/remove arbitrary commit](#deleteremove-arbitrary-commit)
    - [I tried to push my amended commit to a remote, but I got an error message](#i-tried-to-push-my-amended-commit-to-a-remote-but-i-got-an-error-message)
    - [I accidentally did a hard reset, and I want my changes back](#i-accidentally-did-a-hard-reset-and-i-want-my-changes-back)
    - [I accidentally committed and pushed a merge](#i-accidentally-committed-and-pushed-a-merge)
    - [I accidentally committed and pushed files containing sensitive data](#i-accidentally-committed-and-pushed-files-containing-sensitive-data)
    - [I want to remove a large file from ever existing in repo history](#i-want-to-remove-a-large-file-from-ever-existing-in-repo-history)
      - [Recommended Technique: Use third-party bfg](#recommended-technique-use-third-party-bfg)
      - [Built-in Technique: Use git-filter-branch](#built-in-technique-use-git-filter-branch)
      - [Final Step: Pushing your changed repo history](#final-step-pushing-your-changed-repo-history)
    - [I need to change the content of a commit which is not my last](#i-need-to-change-the-content-of-a-commit-which-is-not-my-last)
  - [Staging](#staging)
    - [I need to add staged changes to the previous commit](#i-need-to-add-staged-changes-to-the-previous-commit)
    - [I want to stage part of a new file, but not the whole file](#i-want-to-stage-part-of-a-new-file-but-not-the-whole-file)
    - [I want to add changes in one file to two different commits](#i-want-to-add-changes-in-one-file-to-two-different-commits)
    - [I staged too many edits, and I want to break them out into a separate commit](#i-staged-too-many-edits-and-i-want-to-break-them-out-into-a-separate-commit)
    - [I want to stage my unstaged edits, and unstage my staged edits](#i-want-to-stage-my-unstaged-edits-and-unstage-my-staged-edits)
  - [Unstaged Edits](#unstaged-edits)
    - [I want to move my unstaged edits to a new branch](#i-want-to-move-my-unstaged-edits-to-a-new-branch)
    - [I want to move my unstaged edits to a different, existing branch](#i-want-to-move-my-unstaged-edits-to-a-different-existing-branch)
    - [I want to discard my local uncommitted changes (staged and unstaged)](#i-want-to-discard-my-local-uncommitted-changes-staged-and-unstaged)
    - [I want to discard specific unstaged changes](#i-want-to-discard-specific-unstaged-changes)
    - [I want to discard specific unstaged files](#i-want-to-discard-specific-unstaged-files)
    - [I want to discard only my unstaged local changes](#i-want-to-discard-only-my-unstaged-local-changes)
    - [I want to discard all of my untracked files](#i-want-to-discard-all-of-my-untracked-files)
    - [I want to unstage a specific staged file](#i-want-to-unstage-a-specific-staged-file)
  - [Branches](#branches)
    - [I want to list all branches](#i-want-to-list-all-branches)
    - [Create a branch from a commit](#create-a-branch-from-a-commit)
    - [I pulled from/into the wrong branch](#i-pulled-frominto-the-wrong-branch)
    - [I want to discard local commits so my branch is the same as one on the server](#i-want-to-discard-local-commits-so-my-branch-is-the-same-as-one-on-the-server)
    - [I committed to master instead of a new branch](#i-committed-to-master-instead-of-a-new-branch)
    - [I want to keep the whole file from another ref-ish](#i-want-to-keep-the-whole-file-from-another-ref-ish)
    - [I made several commits on a single branch that should be on different branches](#i-made-several-commits-on-a-single-branch-that-should-be-on-different-branches)
    - [I want to delete local branches that were deleted upstream](#i-want-to-delete-local-branches-that-were-deleted-upstream)
    - [I accidentally deleted my branch](#i-accidentally-deleted-my-branch)
    - [I want to delete a branch](#i-want-to-delete-a-branch)
    - [I want to delete multiple branches](#i-want-to-delete-multiple-branches)
    - [I want to rename a branch](#i-want-to-rename-a-branch)
    - [I want to checkout to a remote branch that someone else is working on](#i-want-to-checkout-to-a-remote-branch-that-someone-else-is-working-on)
    - [I want to create a new remote branch from current local one](#i-want-to-create-a-new-remote-branch-from-current-local-one)
    - [I want to set a remote branch as the upstream for a local branch](#i-want-to-set-a-remote-branch-as-the-upstream-for-a-local-branch)
    - [I want to set my HEAD to track the default remote branch](#i-want-to-set-my-head-to-track-the-default-remote-branch)
    - [I made changes on the wrong branch](#i-made-changes-on-the-wrong-branch)
  - [Rebasing and Merging](#rebasing-and-merging)
    - [I want to undo rebase/merge](#i-want-to-undo-rebasemerge)
    - [I rebased, but I don't want to force push](#i-rebased-but-i-dont-want-to-force-push)
    - [I need to combine commits](#i-need-to-combine-commits)
      - [Safe merging strategy](#safe-merging-strategy)
      - [I need to merge a branch into a single commit](#i-need-to-merge-a-branch-into-a-single-commit)
      - [I want to combine only unpushed commits](#i-want-to-combine-only-unpushed-commits)
      - [I need to abort the merge](#i-need-to-abort-the-merge)
    - [I need to update the parent commit of my branch](#i-need-to-update-the-parent-commit-of-my-branch)
    - [Check if all commits on a branch are merged](#check-if-all-commits-on-a-branch-are-merged)
    - [Possible issues with interactive rebases](#possible-issues-with-interactive-rebases)
      - [The rebase editing screen says 'noop'](#the-rebase-editing-screen-says-noop)
      - [There were conflicts](#there-were-conflicts)
  - [Stash](#stash)
    - [Stash all edits](#stash-all-edits)
    - [Stash specific files](#stash-specific-files)
    - [Stash with message](#stash-with-message)
    - [Apply a specific stash from list](#apply-a-specific-stash-from-list)
  - [Finding](#finding)
    - [I want to find a string in any commit](#i-want-to-find-a-string-in-any-commit)
    - [I want to find by author/committer](#i-want-to-find-by-authorcommitter)
    - [I want to list commits containing specific files](#i-want-to-list-commits-containing-specific-files)
    - [I want to view the commit history for a specific function](#i-want-to-view-the-commit-history-for-a-specific-function)
    - [Find a tag where a commit is referenced](#find-a-tag-where-a-commit-is-referenced)
  - [Submodules](#submodules)
    - [Clone all submodules](#clone-all-submodules)
    - [Remove a submodule](#remove-a-submodule)
  - [Miscellaneous Objects](#miscellaneous-objects)
    - [Restore a deleted file](#restore-a-deleted-file)
    - [Delete tag](#delete-tag)
    - [Recover a deleted tag](#recover-a-deleted-tag)
    - [Deleted Patch](#deleted-patch)
    - [Exporting a repository as a Zip file](#exporting-a-repository-as-a-zip-file)
    - [Push a branch and a tag that have the same name](#push-a-branch-and-a-tag-that-have-the-same-name)
  - [Tracking Files](#tracking-files)
    - [I want to change a file name's capitalization, without changing the contents of the file](#i-want-to-change-a-file-names-capitalization-without-changing-the-contents-of-the-file)
    - [I want to overwrite local files when doing a git pull](#i-want-to-overwrite-local-files-when-doing-a-git-pull)
    - [I want to remove a file from Git but keep the file](#i-want-to-remove-a-file-from-git-but-keep-the-file)
    - [I want to revert a file to a specific revision](#i-want-to-revert-a-file-to-a-specific-revision)
    - [I want to list changes of a specific file between commits or branches](#i-want-to-list-changes-of-a-specific-file-between-commits-or-branches)
    - [I want Git to ignore changes to a specific file](#i-want-git-to-ignore-changes-to-a-specific-file)
  - [Debugging with Git](#debugging-with-git)
  - [Configuration](#configuration)
    - [I want to add aliases for some Git commands](#i-want-to-add-aliases-for-some-git-commands)
    - [I want to add an empty directory to my repository](#i-want-to-add-an-empty-directory-to-my-repository)
    - [I want to cache a username and password for a repository](#i-want-to-cache-a-username-and-password-for-a-repository)
    - [I want to make Git ignore permissions and filemode changes](#i-want-to-make-git-ignore-permissions-and-filemode-changes)
    - [I want to set a global user](#i-want-to-set-a-global-user)
    - [I want to add command line coloring for Git](#i-want-to-add-command-line-coloring-for-git)
  - [I've no idea what I did wrong](#ive-no-idea-what-i-did-wrong)
  - [Git Shortcuts](#git-shortcuts)
    - [Git Bash](#git-bash)
    - [PowerShell on Windows](#powershell-on-windows)
- [Other Resources](#other-resources)
  - [Books](#books)
  - [Tutorials](#tutorials)
  - [Scripts and Tools](#scripts-and-tools)
  - [GUI Clients](#gui-clients)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Repositories

### I want to start a local repository

To initialize an existing directory as a Git repository:

```sh
(my-folder) $ git init
```

### I want to clone a remote repository

To clone (copy) a remote repository, copy the url for the repository, and run:

```sh
$ git clone [url]
```

This will save it to a folder named the same as the remote repository's. Make sure you have connection to the remote server you are cloning from (for most purposes this means making sure you are connected to the internet).

To clone it into a folder with a different name than the default repository name:

```sh
$ git clone [url] name-of-new-folder
```

### I set the wrong remote repository

There are a few possible problems here:

If you cloned the wrong repository, simply delete the directory created after running `git clone` and clone the correct repository.

If you set the wrong repository as the origin of an existing local repository, change the url of your origin by running:

```sh
$ git remote set-url origin [url of the actual repo]
```

For more, see [this StackOverflow topic](https://stackoverflow.com/questions/2432764/how-to-change-the-uri-url-for-a-remote-git-repository#2432799).


### I want to add code to someone else's repository

Git doesn't allow you to add code to someone else's repository without access rights. Neither does GitHub, which is not the same as Git, but rather a hosted service for Git repositories. However, you can suggest code using patches, or, on GitHub, forks and pull requests.

First, a bit about forking. A fork is a copy of repository. It is not a git operation, but is a common action on GitHub, Bitbucket, GitLab — or anywhere people host Git repositories. You can fork a repository through the hosted UI.

#### Suggesting code via pull requests

After you've forked a repository, you normally need to clone the repository to your machine. You can do some small edits on GitHub, for instance, without cloning, but this isn't a github-flight-rules list, so let's go with how to do this locally.

```sh
# if you are using ssh
$ git clone git@github.com:k88hudson/git-flight-rules.git

# if you are using https
$ git clone https://github.com/k88hudson/git-flight-rules.git
```

If you `cd` into the resulting directory, and type `git remote`, you'll see a list of the remotes. Normally there will be one remote - `origin` - which will point to `k88hudson/git-flight-rules`. In this case, we also want a remote that will point to your fork.

First, to follow a Git convention, we normally use the remote name `origin` for your own repository, and `upstream` for whatever you've forked. So, rename the `origin` remote to `upstream`

```sh
$ git remote rename origin upstream
```

You can also do this using `git remote set-url`, but it takes longer and is more steps.

Then, set up a new remote that points to your project.

```sh
$ git remote add origin git@github.com:YourName/git-flight-rules.git
```

Note that now you have two remotes.

- `origin` references your own repository.
- `upstream` references the original one.

From origin, you can read and write. From upstream, you can only read.

When you've finished making whatever changes you like, push your changes (normally in a branch) to the remote named `origin`. If you're on a branch, you could use `--set-upstream` to avoid specifying the remote tracking branch on every future push using this branch. For instance:

```sh
$ (feature/my-feature) git push --set-upstream origin feature/my-feature
```

There is no way to suggest a pull request using the CLI using Git (although there are tools, like [hub](http://github.com/github/hub), which will do this for you). So, if you're ready to make a pull request, go to your GitHub (or other Git host) and create a new pull request. Note that your host automatically links the original and forked repositories.

After all of this, do not forget to respond to any code review feedback.

#### I need to update my fork with latest updates from original repository

After a while, the `upstream` repository may have been updated, and these updates need to be pulled into your `origin` repo. Remember that like you, other people are contributing too. Suppose that you are in your own feature branch and you need to update it with the original repository updates.

You probably have set up a remote that points to the original project. If not, do this now. Generally we use `upstream` as a remote name:

```sh
$ (master) git remote add upstream <link-to-original-repository># $ (master) git remote add upstream git@github.com:k88hudson/git-flight-rules.git
```

Now you can fetch from upstream and get the lastet updates.

```sh
$ (master) git fetch upstream$ (master) git merge upstream/master# or using a single command$ (master) git pull upstream master
```

## Editing Commits

<a name="diff-last"></a>

### What did I just commit?

Let's say that you just blindly committed changes with `git commit -a` and you're not sure what the actual content of the commit you just made was. You can show the latest commit on your current HEAD with:

```sh
(master)$ git show
```

Or

```sh
$ git log -n1 -p
```

If you want to see a file at a specific commit, you can also do this (where `<commitid>` is the commit you're interested in):

```sh
$ git show <commitid>:filename
```

### I wrote the wrong thing in a commit message

If you wrote the wrong thing and the commit has not yet been pushed, you can do the following to change the commit message without changing the changes in the commit:

```sh
$ git commit --amend --only
```

This will open your default text editor, where you can edit the message. On the other hand, you can do this all in one command:

```sh
$ git commit --amend --only -m 'xxxxxxx'
```

If you have already pushed the message, you can amend the commit and force push, but this is not recommended.

<a name="commit-wrong-author"></a>

### I committed with the wrong name and email configured

If it's a single commit, amend it

```sh
$ git commit --amend --no-edit --author "New Authorname <authoremail@mydomain.com>"
```

An alternative is to correctly configure your author settings in `git config --global author.(name|email)` and then use

```sh
$ git commit --amend --reset-author --no-edit
```

If you need to change all of history, see the man page for `git filter-branch`.

### I want to remove a file from the previous commit

In order to remove changes for a file from the previous commit, do the following:

```sh
$ git checkout HEAD^ myfile$ git add myfile$ git commit --amend --no-edit
```

In case the file was newly added to the commit and you want to remove it (from Git alone), do:

```sh
$ git rm --cached myfile$ git commit --amend --no-edit
```

This is particularly useful when you have an open patch and you have committed an unnecessary file, and need to force push to update the patch on a remote. The `--no-edit` option is used to keep the existing commit message.

<a name="delete-pushed-commit"></a>

### I want to delete or remove my last commit

If you need to delete pushed commits, you can use the following. However, it will irreversibly change your history, and mess up the history of anyone else who had already pulled from the repository. In short, if you're not sure, you should never do this, ever.

```sh
$ git reset HEAD^ --hard$ git push --force-with-lease [remote] [branch]
```

If you haven't pushed, to reset Git to the state it was in before you made your last commit (while keeping your staged changes):

```
(my-branch*)$ git reset --soft HEAD@{1}
```

This only works if you haven't pushed. If you have pushed, the only truly safe thing to do is `git revert SHAofBadCommit`. That will create a new commit that undoes all the previous commit's changes. Or, if the branch you pushed to is rebase-safe (ie. other devs aren't expected to pull from it), you can just use `git push --force-with-lease`. For more, see [the above section](#deleteremove-last-pushed-commit).

<a name="delete-any-commit"></a>

### Delete/remove arbitrary commit

The same warning applies as above. Never do this if possible.

```sh
$ git rebase --onto SHA1_OF_BAD_COMMIT^ SHA1_OF_BAD_COMMIT$ git push --force-with-lease [remote] [branch]
```

Or do an [interactive rebase](#interactive-rebase) and remove the line(s) corresponding to commit(s) you want to see removed.

<a name="#force-push"></a>

### I tried to push my amended commit to a remote, but I got an error message

```sh
To https://github.com/yourusername/repo.git! [rejected]        mybranch -> mybranch (non-fast-forward)error: failed to push some refs to 'https://github.com/tanay1337/webmaker.org.git'hint: Updates were rejected because the tip of your current branch is behindhint: its remote counterpart. Integrate the remote changes (e.g.hint: 'git pull ...') before pushing again.hint: See the 'Note about fast-forwards' in 'git push --help' for details.
```

Note that, as with rebasing (see below), amending **replaces the old commit with a new one**, so you must force push (`--force-with-lease`) your changes if you have already pushed the pre-amended commit to your remote. Be careful when you do this &ndash; *always* make sure you specify a branch!

```sh
(my-branch)$ git push origin mybranch --force-with-lease
```

In general, **avoid force pushing**. It is best to create and push a new commit rather than force-pushing the amended commit as it will cause conflicts in the source history for any other developer who has interacted with the branch in question or any child branches. `--force-with-lease` will still fail, if someone else was also working on the same branch as you, and your push would overwrite those changes.

If you are *absolutely* sure that nobody is working on the same branch or you want to update the tip of the branch *unconditionally*, you can use `--force` (`-f`), but this should be avoided in general.

<a href="undo-git-reset-hard"></a>

### I accidentally did a hard reset, and I want my changes back

If you accidentally do `git reset --hard`, you can normally still get your commit back, as git keeps a log of everything for a few days.

Note: This is only valid if your work is backed up, i.e., either committed or stashed. `git reset --hard` _will remove_ uncommitted modifications, so use it with caution. (A safer option is `git reset --keep`.)

```sh
(master)$ git reflog
```

You'll see a list of your past commits, and a commit for the reset. Choose the SHA of the commit you want to return to, and reset again:

```sh
(master)$ git reset --hard SHA1234
```

And you should be good to go.

<a href="undo-a-commit-merge"></a>

### I accidentally committed and pushed a merge

If you accidentally merged a feature branch to the main development branch before it was ready to be merged, you can still undo the merge. But there's a catch: A merge commit has more than one parent (usually two).

The command to use

```sh
(feature-branch)$ git revert -m 1 <commit>
```

where the -m 1 option says to select parent number 1 (the branch into which the merge was made) as the parent to revert to.

Note: the parent number is not a commit identifier. Rather, a merge commit has a line `Merge: 8e2ce2d 86ac2e7`. The parent number is the 1-based index of the desired parent on this line, the first identifier is number 1, the second is number 2, and so on.

<a href="undo-sensitive-commit-push"></a>

### I accidentally committed and pushed files containing sensitive data

If you accidentally pushed files containing sensitive, or private data (passwords, keys, etc.), you can amend the previous commit. Keep in mind that once you have pushed a commit, you should consider any data it contains to be compromised. These steps can remove the sensitive data from your public repo or your local copy, but you **cannot** remove the sensitive data from other people's pulled copies. If you committed a password, **change it immediately**. If you committed a key, **re-generate it immediately**. Amending the pushed commit is not enough, since anyone could have pulled the original commit containing your sensitive data in the meantime.

If you edit the file and remove the sensitive data, then run

```sh
(feature-branch)$ git add edited_file(feature-branch)$ git commit --amend --no-edit(feature-branch)$ git push --force-with-lease origin [branch]
```

If you want to remove an entire file (but keep it locally), then run

```sh
(feature-branch)$ git rm --cached sensitive_fileecho sensitive_file >> .gitignore(feature-branch)$ git add .gitignore(feature-branch)$ git commit --amend --no-edit(feature-branch)$ git push --force-with-lease origin [branch]
```

Alternatively store your sensitive data in local environment variables.

If you want to completely remove an entire file (and not keep it locally), then run

```sh
(feature-branch)$ git rm sensitive_file(feature-branch)$ git commit --amend --no-edit(feature-branch)$ git push --force-with-lease origin [branch]
```

If you have made other commits in the meantime (i.e. the sensitive data is in a commit before the previous commit), you will have to rebase.

<a href="#i-want-to-remove-a-large-file-from-ever-existing-in-repo-history"></a>

### I want to remove a large file from ever existing in repo history

If the file you want to delete is secret or sensitive, instead see [how to remove sensitive files](#i-accidentally-committed-and-pushed-files-containing-sensitive-data).

Even if you delete a large or unwanted file in a recent commit, it still exists in git history, in your repo's `.git` folder, and will make `git clone` download unneeded files.

The actions in this part of the guide will require a force push, and rewrite large sections of repo history, so if you are working with remote collaborators, check first that any local work of theirs is pushed.

There are two options for rewriting history, the built-in `git-filter-branch` or [`bfg-repo-cleaner`](https://rtyley.github.io/bfg-repo-cleaner/). `bfg` is significantly cleaner and more performant, but it is a third-party download and requires java. We will describe both alternatives. The final step is to force push your changes, which requires special consideration on top of a regular force push, given that a great deal of repo history will have been permanently changed.

#### Recommended Technique: Use third-party bfg

Using bfg-repo-cleaner requires java. Download the bfg jar from the link [here](https://rtyley.github.io/bfg-repo-cleaner/). Our examples will use `bfg.jar`, but your download may have a version number, e.g. `bfg-1.13.0.jar`.

To delete a specific file.

```sh
(master)$ git rm path/to/filetoremove(master)$ git commit -m "Commit removing filetoremove"(master)$ java -jar ~/Downloads/bfg.jar --delete-files filetoremove
```

Note that in bfg you must use the plain file name even if it is in a subdirectory.

You can also delete a file by pattern, e.g.:

```sh
(master)$ git rm *.jpg(master)$ git commit -m "Commit removing *.jpg"(master)$ java -jar ~/Downloads/bfg.jar --delete-files *.jpg
```

With bfg, the files that exist on your latest commit will not be affected. For example, if you had several large .tga files in your repo, and then in an earlier commit, you deleted a subset of them, this call does not touch files present in the latest commit

Note, if you renamed a file as part of a commit, e.g. if it started as `LargeFileFirstName.mp4` and a commit changed it to `LargeFileSecondName.mp4`, running `java -jar ~/Downloads/bfg.jar --delete-files LargeFileSecondName.mp4` will not remove it from git history. Either run the `--delete-files` command with both filenames, or with a matching pattern.

#### Built-in Technique: Use git-filter-branch

`git-filter-branch` is more cumbersome and has less features, but you may use it if you cannot install or run `bfg`.

In the below, replace `filepattern` may be a specific name or pattern, e.g. `*.jpg`. This will remove files matching the pattern from all history and branches.

```sh
(master)$ git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch filepattern' --prune-empty --tag-name-filter cat -- --all
```

Behind-the-scenes explanation:

`--tag-name-filter cat` is a cumbersome, but simplest, way to apply the original tags to the new commits, using the command cat.

`--prune-empty` removes any now-empty commits.

#### Final Step: Pushing your changed repo history

Once you have removed your desired files, test carefully that you haven't broken anything in your repo - if you have, it is easiest to re-clone your repo to start over.
To finish, optionally use git garbage collection to minimize your local .git folder size, and then force push.

```sh
(master)$ git reflog expire --expire=now --all && git gc --prune=now --aggressive(master)$ git push origin --force --tags
```

Since you just rewrote the entire git repo history, the `git push` operation may be too large, and return the error `“The remote end hung up unexpectedly”`. If this happens, you can try increasing the git post buffer:

```sh
(master)$ git config http.postBuffer 524288000(master)$ git push --force
```

If this does not work, you will need to manually push the repo history in chunks of commits. In the command below, try increasing `<number>` until the push operation succeeds.

```sh
(master)$ git push -u origin HEAD~<number>:refs/head/master --force
```

Once the push operation succeeds the first time, decrease `<number>` gradually until a conventional `git push` succeeeds.

<a href="i-need-to-change-the-content-of-a-commit-which-is-not-my-last"></a>

### I need to change the content of a commit which is not my last

Consider you created some (e.g. three) commits and later realize you missed doing something that belongs contextually into the first of those commits. This bothers you, because if you'd create a new commit containing those changes, you'd have a clean code base, but your commits weren't atomic (i.e. changes that belonged to each other weren't in the same commit). In such a situation you may want to change the commit where these changes belong to, include them and have the following commits unaltered. In such a case, `git rebase` might save you.

Consider a situation where you want to change the third last commit you made.

```sh
(your-branch)$ git rebase -i HEAD~4
```

gets you into interactive rebase mode, which allows you to edit any of your last three commits. A text editor pops up, showing you something like

```sh
pick 9e1d264 The third last commitpick 4b6e19a The second to last commitpick f4037ec The last commit
```

which you change into

```sh
edit 9e1d264 The third last commitpick 4b6e19a The second to last commitpick f4037ec The last commit
```

This tells rebase that you want to edit your third last commit and keep the other two unaltered. Then you'll save (and close) the editor. Git will then start to rebase. It stops on the commit you want to alter, giving you the chance to edit that commit. Now you can apply the changes which you missed applying when you initially commited that commit. You do so by editing and staging them. Afterwards you'll run

```sh
(your-branch)$ git commit --amend
```

which tells Git to recreate the commit, but to leave the commit message unedited. Having done that, the hard part is solved.

```sh
(your-branch)$ git rebase --continue
```

will do the rest of the work for you.

## Staging

<a href="#i-need-to-add-staged-changes-to-the-previous-commit"></a>

### I need to add staged changes to the previous commit

```sh
(my-branch*)$ git commit --amend
```

If you already know you don't want to change the commit message, you can tell git to reuse the commit message:

```sh
(my-branch*)$ git commit --amend -C HEAD
```

<a name="commit-partial-new-file"></a>

### I want to stage part of a new file, but not the whole file

Normally, if you want to stage part of a file, you run this:

```sh
$ git add --patch filename.x
```

`-p` will work for short. This will open interactive mode. You would be able to use the `s` option to split the commit - however, if the file is new, you will not have this option. To add a new file, do this:

```sh
$ git add -N filename.x
```

Then, you will need to use the `e` option to manually choose which lines to add. Running `git diff --cached` or
`git diff --staged` will show you which lines you have staged compared to which are still saved locally.

<a href="stage-in-two-commits"></a>

### I want to add changes in one file to two different commits

`git add` will add the entire file to a commit. `git add -p` will allow to interactively select which changes you want to add.

<a href="selective-unstage-edits"></a>

### I staged too many edits, and I want to break them out into a separate commit

`git reset -p` will open a patch mode reset dialog.  This is similar to `git add -p`, except that selecting "yes" will unstage the change, removing it from the upcoming commit.

<a href="unstaging-edits-and-staging-the-unstaged"></a>

### I want to stage my unstaged edits, and unstage my staged edits

This is tricky. The best I figure is that you should stash your unstaged edits. Then, reset. After that, pop your stashed edits back, and add them.

```sh
$ git stash -k$ git reset --hard$ git stash pop$ git add -A
```

## Unstaged Edits

<a href="move-unstaged-edits-to-new-branch"></a>

### I want to move my unstaged edits to a new branch

```sh
$ git checkout -b my-branch
```

<a href="move-unstaged-edits-to-old-branch"></a>

### I want to move my unstaged edits to a different, existing branch

```sh
$ git stash$ git checkout my-branch$ git stash pop
```

<a href="i-want-to-discard-my-local-uncommitted-changes"></a>

### I want to discard my local uncommitted changes (staged and unstaged)

If you want to discard all your local staged and unstaged changes, you can do this:

```sh
(my-branch)$ git reset --hard# or(master)$ git checkout -f
```

This will unstage all files you might have staged with `git add`:

```sh
$ git reset
```

This will revert all local uncommitted changes (should be executed in repo root):

```sh
$ git checkout .
```

You can also revert uncommitted changes to a particular file or directory:

```sh
$ git checkout [some_dir|file.txt]
```

Yet another way to revert all uncommitted changes (longer to type, but works from any subdirectory):

```sh
$ git reset --hard HEAD
```

This will remove all local untracked files, so only files tracked by Git remain:

```sh
$ git clean -fd
```

`-x` will also remove all ignored files.

### I want to discard specific unstaged changes

When you want to get rid of some, but not all changes in your working copy.

Checkout undesired changes, keep good changes.

```sh
$ git checkout -p# Answer y to all of the snippets you want to drop
```

Another strategy involves using `stash`. Stash all the good changes, reset working copy, and reapply good changes.

```sh
$ git stash -p# Select all of the snippets you want to save$ git reset --hard$ git stash pop
```

Alternatively, stash your undesired changes, and then drop stash.

```sh
$ git stash -p# Select all of the snippets you don't want to save$ git stash drop
```

### I want to discard specific unstaged files

When you want to get rid of one specific file in your working copy.

```sh
$ git checkout myFile
```

Alternatively, to discard multiple files in your working copy, list them all.

```sh
$ git checkout myFirstFile mySecondFile
```

### I want to discard only my unstaged local changes

When you want to get rid of all of your unstaged local uncommitted changes

```sh
$ git checkout .
```

<a href="i-want-to-discard-all-my-untracked-files"></a>

### I want to discard all of my untracked files

When you want to get rid of all of your untracked files

```sh
$ git clean -f
```

<a href="I-want-to-unstage-specific-staged-file"></a>

### I want to unstage a specific staged file

Sometimes we have one or more files that accidentally ended up being staged, and these files have not been committed before. To unstage them:

```sh
$ git reset -- <filename>
```

This results in unstaging the file and make it look like it's untracked.

## Branches

### I want to list all branches

List local branches

```sh
$ git branch
```

List remote branches

```sh
$ git branch -r
```

List all branches (both local and remote)

```sh
$ git branch -a
```

<a name="create-branch-from-commit"></a>

### Create a branch from a commit

```sh
$ git checkout -b <branch> <SHA1_OF_COMMIT>tip：create new branch was no track
```

<a name="pull-wrong-branch"></a>

### I pulled from/into the wrong branch

This is another chance to use `git reflog` to see where your HEAD pointed before the bad pull.

```sh
(master)$ git reflogab7555f HEAD@{0}: pull origin wrong-branch: Fast-forwardc5bc55a HEAD@{1}: checkout: checkout message goes here
```

Simply reset your branch back to the desired commit:

```sh
$ git reset --hard c5bc55a
```

Done.

<a href="discard-local-commits"></a>

### I want to discard local commits so my branch is the same as one on the server

Confirm that you haven't pushed your changes to the server.

`git status` should show how many commits you are ahead of origin:

```sh
(my-branch)$ git status# On branch my-branch# Your branch is ahead of 'origin/my-branch' by 2 commits.#   (use "git push" to publish your local commits)#
```

One way of resetting to match origin (to have the same as what is on the remote) is to do this:

```sh
(master)$ git reset --hard origin/my-branch
```

<a name="commit-wrong-branch"></a>

### I committed to master instead of a new branch

Create the new branch while remaining on master:

```sh
(master)$ git branch my-branch
```

Reset the branch master to the previous commit:

```sh
(master)$ git reset --hard HEAD^
```

`HEAD^` is short for `HEAD^1`. This stands for the first parent of `HEAD`, similarly `HEAD^2` stands for the second parent of the commit (merges can have 2 parents).

Note that `HEAD^2` is **not** the same as `HEAD~2` (see [this link](http://www.paulboxley.com/blog/2011/06/git-caret-and-tilde) for more information).

Alternatively, if you don't want to use `HEAD^`, find out what the commit hash you want to set your master branch to (`git log` should do the trick). Then reset to that hash. `git push` will make sure that this change is reflected on your remote.

For example, if the hash of the commit that your master branch is supposed to be at is `a13b85e`:

```sh
(master)$ git reset --hard a13b85eHEAD is now at a13b85e
```

Checkout the new branch to continue working:

```sh
(master)$ git checkout my-branch
```

<a name="keep-whole-file"></a>

### I want to keep the whole file from another ref-ish

Say you have a working spike (see note), with hundreds of changes. Everything is working. Now, you commit into another branch to save that work:

```sh
(solution)$ git add -A && git commit -m "Adding all changes from this spike into one big commit."
```

When you want to put it into a branch (maybe feature, maybe `develop`), you're interested in keeping whole files. You want to split your big commit into smaller ones.

Say you have:

  * branch `solution`, with the solution to your spike. One ahead of `develop`.
  * branch `develop`, where you want to add your changes.

You can solve it bringing the contents to your branch:

```sh
(develop)$ git checkout solution -- file1.txt
```

This will get the contents of that file in branch `solution` to your branch `develop`:

```sh
# On branch develop# Your branch is up-to-date with 'origin/develop'.# Changes to be committed:#  (use "git reset HEAD <file>..." to unstage)##        modified:   file1.txt
```

Then, commit as usual.

Note: Spike solutions are made to analyze or solve the problem. These solutions are used for estimation and discarded once everyone gets clear visualization of the problem. ~ [Wikipedia](https://en.wikipedia.org/wiki/Extreme_programming_practices).

<a name="cherry-pick"></a>

### I made several commits on a single branch that should be on different branches

Say you are on your master branch. Running `git log`, you see you have made two commits:

```sh
(master)$ git logcommit e3851e817c451cc36f2e6f3049db528415e3c114Author: Alex Lee <alexlee@example.com>Date:   Tue Jul 22 15:39:27 2014 -0400    Bug #21 - Added CSRF protectioncommit 5ea51731d150f7ddc4a365437931cd8be3bf3131Author: Alex Lee <alexlee@example.com>Date:   Tue Jul 22 15:39:12 2014 -0400    Bug #14 - Fixed spacing on titlecommit a13b85e984171c6e2a1729bb061994525f626d14Author: Aki Rose <akirose@example.com>Date:   Tue Jul 21 01:12:48 2014 -0400    First commit
```

Let's take note of our commit hashes for each bug (`e3851e8` for #21, `5ea5173` for #14).

First, let's reset our master branch to the correct commit (`a13b85e`):

```sh
(master)$ git reset --hard a13b85eHEAD is now at a13b85e
```

Now, we can create a fresh branch for our bug #21:

```sh
(master)$ git checkout -b 21(21)$
```

Now, let's *cherry-pick* the commit for bug #21 on top of our branch. That means we will be applying that commit, and only that commit, directly on top of whatever our head is at.

```sh
(21)$ git cherry-pick e3851e8
```

At this point, there is a possibility there might be conflicts. See the [**There were conflicts**](#merge-conflict) section in the [interactive rebasing section above](#interactive-rebase) for how to resolve conflicts.

Now let's create a new branch for bug #14, also based on master

```sh
(21)$ git checkout master(master)$ git checkout -b 14(14)$
```

And finally, let's cherry-pick the commit for bug #14:

```sh
(14)$ git cherry-pick 5ea5173
```

<a name="delete-stale-local-branches"></a>

### I want to delete local branches that were deleted upstream

Once you merge a pull request on GitHub, it gives you the option to delete the merged branch in your fork. If you aren't planning to keep working on the branch, it's cleaner to delete the local copies of the branch so you don't end up cluttering up your working checkout with a lot of stale branches.

```sh
$ git fetch -p upstream
```

where, `upstream` is the remote you want to fetch from.

<a name='restore-a-deleted-branch'></a>

### I accidentally deleted my branch

If you're regularly pushing to remote, you should be safe most of the time. But still sometimes you may end up deleting your branches. Let's say we create a branch and create a new file:

```sh
(master)$ git checkout -b my-branch(my-branch)$ git branch(my-branch)$ touch foo.txt(my-branch)$ lsREADME.md foo.txt
```

Let's add it and commit.

```sh
(my-branch)$ git add .(my-branch)$ git commit -m 'foo.txt added'(my-branch)$ foo.txt added 1 files changed, 1 insertions(+) create mode 100644 foo.txt(my-branch)$ git logcommit 4e3cd85a670ced7cc17a2b5d8d3d809ac88d5012Author: siemiatj <siemiatj@example.com>Date:   Wed Jul 30 00:34:10 2014 +0200    foo.txt addedcommit 69204cdf0acbab201619d95ad8295928e7f411d5Author: Kate Hudson <katehudson@example.com>Date:   Tue Jul 29 13:14:46 2014 -0400    Fixes #6: Force pushing after amending commits
```

Now we're switching back to master and 'accidentally' removing our branch.

```sh
(my-branch)$ git checkout masterSwitched to branch 'master'Your branch is up-to-date with 'origin/master'.(master)$ git branch -D my-branchDeleted branch my-branch (was 4e3cd85).(master)$ echo oh noes, deleted my branch!oh noes, deleted my branch!
```

At this point you should get familiar with 'reflog', an upgraded logger. It stores the history of all the action in the repo.

```
(master)$ git reflog69204cd HEAD@{0}: checkout: moving from my-branch to master4e3cd85 HEAD@{1}: commit: foo.txt added69204cd HEAD@{2}: checkout: moving from master to my-branch
```

As you can see we have commit hash from our deleted branch. Let's see if we can restore our deleted branch.

```sh
(master)$ git checkout -b my-branch-helpSwitched to a new branch 'my-branch-help'(my-branch-help)$ git reset --hard 4e3cd85HEAD is now at 4e3cd85 foo.txt added(my-branch-help)$ lsREADME.md foo.txt
```

Voila! We got our removed file back. `git reflog` is also useful when rebasing goes terribly wrong.

### I want to delete a branch

To delete a remote branch:

```sh
(master)$ git push origin --delete my-branch
```

You can also do:

```sh
(master)$ git push origin :my-branch
```

To delete a local branch:

```sh
(master)$ git branch -d my-branch
```

To delete a local branch that *has not* been merged to the current branch or an upstream:

```sh
(master)$ git branch -D my-branch
```

### I want to delete multiple branches

Say you want to delete all branches that start with `fix/`:

```sh
(master)$ git branch | grep 'fix/' | xargs git branch -d
```

### I want to rename a branch

To rename the current (local) branch:

```sh
(master)$ git branch -m new-name
```

To rename a different (local) branch:

```sh
(master)$ git branch -m old-name new-name
```

<a name="i-want-to-checkout-to-a-remote-branch-that-someone-else-is-working-on"></a>

### I want to checkout to a remote branch that someone else is working on

First, fetch all branches from remote:

```sh
(master)$ git fetch --all
```

Say you want to checkout to `daves` from the remote.

```sh
(master)$ git checkout --track origin/davesBranch daves set up to track remote branch daves from origin.Switched to a new branch 'daves'
```

(`--track` is shorthand for `git checkout -b [branch] [remotename]/[branch]`)

This will give you a local copy of the branch `daves`, and any update that has been pushed will also show up remotely.

### I want to create a new remote branch from current local one

```sh
$ git push <remote> HEAD
```

If you would also like to set that remote branch as upstream for the current one, use the following instead:

```sh
$ git push -u <remote> HEAD
```

With the `upstream` mode and the `simple` (default in Git 2.0) mode of the `push.default` config, the following command will push the current branch with regards to the remote branch that has been registered previously with `-u`:

```sh
$ git push
```

The behavior of the other modes of `git push` is described in the [doc of `push.default`](https://git-scm.com/docs/git-config#git-config-pushdefault).

### I want to set a remote branch as the upstream for a local branch

You can set a remote branch as the upstream for the current local branch using:

```sh
$ git branch --set-upstream-to [remotename]/[branch]# or, using the shorthand:$ git branch -u [remotename]/[branch]
```

To set the upstream remote branch for another local branch:

```sh
$ git branch -u [remotename]/[branch] [local-branch]
```

<a name="i-want-to-set-my-HEAD-to-track-the-default-remote-branch"></a>

### I want to set my HEAD to track the default remote branch

By checking your remote branches, you can see which remote branch your HEAD is tracking. In some cases, this is not the desired branch.

```sh
$ git branch -r  origin/HEAD -> origin/gh-pages  origin/master
```

To change `origin/HEAD` to track `origin/master`, you can run this command:

```sh
$ git remote set-head origin --autoorigin/HEAD set to master
```

### I made changes on the wrong branch

You've made uncommitted changes and realise you're on the wrong branch. Stash changes and apply them to the branch you want:

```sh
(wrong_branch)$ git stash(wrong_branch)$ git checkout <correct_branch>(correct_branch)$ git stash apply
```

## Rebasing and Merging

<a name="undo-rebase"></a>

### I want to undo rebase/merge

You may have merged or rebased your current branch with a wrong branch, or you can't figure it out or finish the rebase/merge process. Git saves the original HEAD pointer in a variable called ORIG_HEAD before doing dangerous operations, so it is simple to recover your branch at the state before the rebase/merge.

```sh
(my-branch)$ git reset --hard ORIG_HEAD
```

<a name="force-push-rebase"></a>

### I rebased, but I don't want to force push

Unfortunately, you have to force push, if you want those changes to be reflected on the remote branch. This is because you have changed the history. The remote branch won't accept changes unless you force push. This is one of the main reasons many people use a merge workflow, instead of a rebasing workflow - large teams can get into trouble with developers force pushing. Use this with caution. A safer way to use rebase is not to reflect your changes on the remote branch at all, and instead to do the following:

```sh
(master)$ git checkout my-branch(my-branch)$ git rebase -i master(my-branch)$ git checkout master(master)$ git merge --ff-only my-branch
```

For more, see [this SO thread](https://stackoverflow.com/questions/11058312/how-can-i-use-git-rebase-without-requiring-a-forced-push).

<a name="interactive-rebase"></a>

### I need to combine commits

Let's suppose you are working in a branch that is/will become a pull-request against `master`. In the simplest case when all you want to do is to combine *all* commits into a single one and you don't care about commit timestamps, you can reset and recommit. Make sure the master branch is up to date and all your changes committed, then:

```sh
(my-branch)$ git reset --soft master(my-branch)$ git commit -am "New awesome feature"
```

If you want more control, and also to preserve timestamps, you need to do something called an interactive rebase:

```sh
(my-branch)$ git rebase -i master
```

If you aren't working against another branch you'll have to rebase relative to your `HEAD`. If you want to squash the last 2 commits, for example, you'll have to rebase against `HEAD~2`. For the last 3, `HEAD~3`, etc.

```sh
(master)$ git rebase -i HEAD~2
```

After you run the interactive rebase command, you will see something like this in your  text editor:

```vim
pick a9c8a1d Some refactoringpick 01b2fd8 New awesome featurepick b729ad5 fixuppick e3851e8 another fix# Rebase 8074d12..b729ad5 onto 8074d12## Commands:#  p, pick = use commit#  r, reword = use commit, but edit the commit message#  e, edit = use commit, but stop for amending#  s, squash = use commit, but meld into previous commit#  f, fixup = like "squash", but discard this commit's log message#  x, exec = run command (the rest of the line) using shell## These lines can be re-ordered; they are executed from top to bottom.## If you remove a line here THAT COMMIT WILL BE LOST.## However, if you remove everything, the rebase will be aborted.## Note that empty commits are commented out
```

All the lines beginning with a `#` are comments, they won't affect your rebase.

Then you replace `pick` commands with any in the list above, and you can also remove commits by removing corresponding lines.

For example, if you want to **leave the oldest (first) commit alone and combine all the following commits with the second oldest**, you should edit the letter next to each commit except the first and the second to say `f`:

```vim
pick a9c8a1d Some refactoringpick 01b2fd8 New awesome featuref b729ad5 fixupf e3851e8 another fix
```

If you want to combine these commits **and rename the commit**, you should additionally add an `r` next to the second commit or simply use `s` instead of `f`:

```vim
pick a9c8a1d Some refactoringpick 01b2fd8 New awesome features b729ad5 fixups e3851e8 another fix
```

You can then rename the commit in the next text prompt that pops up.

```vim
Newer, awesomer features# Please enter the commit message for your changes. Lines starting# with '#' will be ignored, and an empty message aborts the commit.# rebase in progress; onto 8074d12# You are currently editing a commit while rebasing branch 'master' on '8074d12'.## Changes to be committed:#   modified:   README.md#
```

If everything is successful, you should see something like this:

```sh
(master)$ Successfully rebased and updated refs/heads/master.
```

#### Safe merging strategy

`--no-commit` performs the merge but pretends the merge failed and does not autocommit, giving the user a chance to inspect and further tweak the merge result before committing. `no-ff` maintains evidence that a feature branch once existed, keeping project history consistent.

```sh
(master)$ git merge --no-ff --no-commit my-branch
```

#### I need to merge a branch into a single commit

```sh
(master)$ git merge --squash my-branch
```

<a name="rebase-unpushed-commits"></a>

#### I want to combine only unpushed commits

Sometimes you have several work in progress commits that you want to combine before you push them upstream. You don't want to accidentally combine any commits that have already been pushed upstream because someone else may have already made commits that reference them.

```sh
(master)$ git rebase -i @{u}
```

This will do an interactive rebase that lists only the commits that you haven't already pushed, so it will be safe to reorder/fix/squash anything in the list.

#### I need to abort the merge

Sometimes the merge can produce problems in certain files, in those cases we can use the option `abort` to abort the current conflict resolution process, and try to reconstruct the pre-merge state.

```sh
(my-branch)$ git merge --abort
```

This command is available since Git version >= 1.7.4

### I need to update the parent commit of my branch

Say I have a master branch, a feature-1 branch branched from master, and a feature-2 branch branched off of feature-1. If I make a commit to feature-1, then the parent commit of feature-2 is no longer accurate (it should be the head of feature-1, since we branched off of it). We can fix this with `git rebase --onto`.

```sh
(feature-2)$ git rebase --onto feature-1 <the first commit in your feature-2 branch that you don't want to bring along> feature-2
```

This helps in sticky scenarios where you might have a feature built on another feature that hasn't been merged yet, and a bugfix on the feature-1 branch needs to be reflected in your feature-2 branch.

### Check if all commits on a branch are merged

To check if all commits on a branch are merged into another branch, you should diff between the heads (or any commits) of those branches:

```sh
(master)$ git log --graph --left-right --cherry-pick --oneline HEAD...feature/120-on-scroll
```

This will tell you if any commits are in one but not the other, and will give you a list of any nonshared between the branches. Another option is to do this:

```sh
(master)$ git log master ^feature/120-on-scroll --no-merges
```

### Possible issues with interactive rebases

<a name="noop"></a>

#### The rebase editing screen says 'noop'

If you're seeing this:

```
noop
```

That means you are trying to rebase against a branch that is at an identical commit, or is *ahead* of your current branch. You can try:

* making sure your master branch is where it should be
* rebase against `HEAD~2` or earlier instead

<a name="merge-conflict"></a>

#### There were conflicts

If you are unable to successfully complete the rebase, you may have to resolve conflicts.

First run `git status` to see which files have conflicts in them:

```sh
(my-branch)$ git statusOn branch my-branchChanges not staged for commit:  (use "git add <file>..." to update what will be committed)  (use "git checkout -- <file>..." to discard changes in working directory)  both modified:   README.md
```

In this example, `README.md` has conflicts. Open that file and look for the following:

```vim
   <<<<<<< HEAD   some code   =========   some code   >>>>>>> new-commit
```

You will need to resolve the differences between the code that was added in your new commit (in the example, everything from the middle line to `new-commit`) and your `HEAD`.

If you want to keep one branch's version of the code, you can use `--ours` or `--theirs`:

```sh
(master*)$ git checkout --ours README.md
```

- When *merging*, use `--ours` to keep changes from the local branch, or `--theirs` to keep changes from the other branch.
- When *rebasing*, use `--theirs` to keep changes from the local branch, or `--ours` to keep changes from the other branch. For an explanation of this swap, see [this note in the Git documentation](https://git-scm.com/docs/git-rebase#git-rebase---merge).

If the merges are more complicated, you can use a visual diff editor:

```sh
(master*)$ git mergetool -t opendiff
```

After you have resolved all conflicts and tested your code, `git add` the files you have changed, and then continue the rebase with `git rebase --continue`

```sh
(my-branch)$ git add README.md(my-branch)$ git rebase --continue
```

If after resolving all the conflicts you end up with an identical tree to what it was before the commit, you need to `git rebase --skip` instead.

If at any time you want to stop the entire rebase and go back to the original state of your branch, you can do so:

```sh
(my-branch)$ git rebase --abort
```

<a name="stashing"></a>

## Stash

### Stash all edits

To stash all the edits in your working directory

```sh
$ git stash
```

If you also want to stash untracked files, use `-u` option.

```sh
$ git stash -u
```

### Stash specific files

To stash only one file from your working directory

```sh
$ git stash push working-directory-path/filename.ext
```

To stash multiple files from your working directory

```sh
$ git stash push working-directory-path/filename1.ext working-directory-path/filename2.ext
```

<a name="stash-msg"></a>

### Stash with message

```sh
$ git stash save <message>
```

<a name="stash-apply-specific"></a>

### Apply a specific stash from list

First check your list of stashes with message using

```sh
$ git stash list
```

Then apply a specific stash from the list using

```sh
$ git stash apply "stash@{n}"
```

Here, 'n' indicates the position of the stash in the stack. The topmost stash will be position 0.

## Finding

### I want to find a string in any commit

To find a certain string which was introduced in any commit, you can use the following structure:

```sh
$ git log -S "string to find"
```

Commons parameters:

* `--source` means to show the ref name given on the command line by which each commit was reached.

* `--all` means to start from every branch.

* `--reverse` prints in reverse order, it means that will show the first commit that made the change.

<a name="i-want-to-find-by-author-committer"></a>

### I want to find by author/committer

To find all commits by author/committer you can use:

```sh
$ git log --author=<name or email>$ git log --committer=<name or email>
```

Keep in mind that author and committer are not the same. The `--author` is the person who originally wrote the code; on the other hand, the `--committer`, is the person who committed the code on behalf of the original author.

### I want to list commits containing specific files

To find all commits containing a specific file you can use:

```sh
$ git log -- <path to file>
```

You would usually specify an exact path, but you may also use wild cards in the path and file name:

```sh
$ git log -- **/*.js
```

While using wildcards, it's useful to inform `--name-status` to see the list of committed files:

```sh
$ git log --name-status -- **/*.js
```

<a name="#i-want-to-view-the-commit-history-for-a-specific-function"></a>

### I want to view the commit history for a specific function

To trace the evolution of a single function you can use:

```sh
$ git log -L :FunctionName:FilePath
```

Note that you can combine this with further `git log` options, like [revision ranges](https://git-scm.com/docs/gitrevisions) and [commit limits](https://git-scm.com/docs/git-log/#_commit_limiting).

### Find a tag where a commit is referenced

To find all tags containing a specific commit:

```sh
$ git tag --contains <commitid>
```

## Submodules

<a name="clone-submodules"></a>

### Clone all submodules

```sh
$ git clone --recursive git://github.com/foo/bar.git
```

If already cloned:

```sh
$ git submodule update --init --recursive
```

<a name="delete-submodule"></a>

### Remove a submodule

Creating a submodule is pretty straight-forward, but deleting them less so. The commands you need are:

```sh
$ git submodule deinit submodulename$ git rm submodulename$ git rm --cached submodulename$ rm -rf .git/modules/submodulename
```

## Miscellaneous Objects

### Restore a deleted file

First find the commit when the file last existed:

```sh
$ git rev-list -n 1 HEAD -- filename
```

Then checkout that file:

```
git checkout deletingcommitid^ -- filename
```

### Delete tag

```sh
$ git tag -d <tag_name>$ git push <remote> :refs/tags/<tag_name>
```

<a name="recover-tag"></a>

### Recover a deleted tag

If you want to recover a tag that was already deleted, you can do so by following these steps: First, you need to find the unreachable tag:

```sh
$ git fsck --unreachable | grep tag
```

Make a note of the tag's hash. Then, restore the deleted tag with following, making use of [`git update-ref`](https://git-scm.com/docs/git-update-ref):

```sh
$ git update-ref refs/tags/<tag_name> <hash>
```

Your tag should now have been restored.

### Deleted Patch

If someone has sent you a pull request on GitHub, but then deleted their original fork, you will be unable to clone their repository or to use `git am` as the [.diff, .patch](https://github.com/blog/967-github-secrets) urls become unavailable. But you can checkout the PR itself using [GitHub's special refs](https://gist.github.com/piscisaureus/3342247). To fetch the content of PR#1 into a new branch called pr_1:

```sh
$ git fetch origin refs/pull/1/head:pr_1From github.com:foo/bar * [new ref]         refs/pull/1/head -> pr_1
```

### Exporting a repository as a Zip file

```sh
$ git archive --format zip --output /full/path/to/zipfile.zip master
```

### Push a branch and a tag that have the same name

If there is a tag on a remote repository that has the same name as a branch you will get the following error when trying to push that branch with a standard `$ git push <remote> <branch>` command.

```sh
$ git push origin <branch>error: dst refspec same matches more than one.error: failed to push some refs to '<git server>'
```

Fix this by specifying you want to push the head reference.

```sh
$ git push origin refs/heads/<branch-name>
```

If you want to push a tag to a remote repository that has the same name as a branch, you can use a similar command.

```sh
$ git push origin refs/tags/<tag-name>
```

## Tracking Files

<a href="i-want-to-change-a-file-names-capitalization-without-changing-the-contents-of-the-file"></a>

### I want to change a file name's capitalization, without changing the contents of the file

```sh
(master)$ git mv --force myfile MyFile
```

### I want to overwrite local files when doing a git pull

```sh
(master)$ git fetch --all(master)$ git reset --hard origin/master
```

<a href="remove-from-git"></a>

### I want to remove a file from Git but keep the file

```sh
(master)$ git rm --cached log.txt
```

### I want to revert a file to a specific revision

Assuming the hash of the commit you want is c5f567:

```sh
(master)$ git checkout c5f567 -- file1/to/restore file2/to/restore
```

If you want to revert to changes made just 1 commit before c5f567, pass the commit hash as c5f567~1:

```sh
(master)$ git checkout c5f567~1 -- file1/to/restore file2/to/restore
```

### I want to list changes of a specific file between commits or branches

Assuming you want to compare last commit with file from commit c5f567:

```sh
$ git diff HEAD:path_to_file/file c5f567:path_to_file/file
```

Same goes for branches:

```sh
$ git diff master:path_to_file/file staging:path_to_file/file
```

### I want Git to ignore changes to a specific file

This works great for config templates or other files that require locally adding credentials that shouldn't be committed.

```sh
$ git update-index --assume-unchanged file-to-ignore
```

Note that this does *not* remove the file from source control - it is only ignored locally. To undo this and tell Git to notice changes again, this clears the ignore flag:

```sh
$ git update-index --no-assume-unchanged file-to-stop-ignoring
```

## Debugging with Git

The [git-bisect](https://git-scm.com/docs/git-bisect) command uses a binary search to find which commit in your Git history introduced a bug.

Suppose you're on the `master` branch, and you want to find the commit that broke some feature. You start bisect:

```sh
$ git bisect start
```

Then you should specify which commit is bad, and which one is known to be good. Assuming that your *current* version is bad, and `v1.1.1` is good:

```sh
$ git bisect bad$ git bisect good v1.1.1
```

Now `git-bisect` selects a commit in the middle of the range that you specified, checks it out, and asks you whether it's good or bad. You should see something like:

```sh
$ Bisecting: 5 revision left to test after this (roughly 5 step)$ [c44abbbee29cb93d8499283101fe7c8d9d97f0fe] Commit message$ (c44abbb)$
```

You will now check if this commit is good or bad. If it's good:

```sh
$ (c44abbb)$ git bisect good
```

and `git-bisect` will select another commit from the range for you. This process (selecting `good` or `bad`) will repeat until there are no more revisions left to inspect, and the command will finally print a description of the **first** bad commit.

## Configuration

### I want to add aliases for some Git commands

On OS X and Linux, your git configuration file is stored in ```~/.gitconfig```.  I've added some example aliases I use as shortcuts (and some of my common typos) in the ```[alias]``` section as shown below:

```vim
[alias]    a = add    amend = commit --amend    c = commit    ca = commit --amend    ci = commit -a    co = checkout    d = diff    dc = diff --changed    ds = diff --staged    extend = commit --amend -C HEAD    f = fetch    loll = log --graph --decorate --pretty=oneline --abbrev-commit    m = merge    one = log --pretty=oneline    outstanding = rebase -i @{u}    reword = commit --amend --only    s = status    unpushed = log @{u}    wc = whatchanged    wip = rebase -i @{u}    zap = fetch -p    day = log --reverse --no-merges --branches=* --date=local --since=midnight --author=\"$(git config --get user.name)\"    delete-merged-branches = "!f() { git checkout --quiet master && git branch --merged | grep --invert-match '\\*' | xargs -n 1 git branch --delete; git checkout --quiet @{-1}; }; f"
```

### I want to add an empty directory to my repository

You can’t! Git doesn’t support this, but there’s a hack. You can create a .gitignore file in the directory with the following contents:

```
 # Ignore everything in this directory * # Except this file !.gitignore
```

Another common convention is to make an empty file in the folder, titled .gitkeep.

```sh
$ mkdir mydir$ touch mydir/.gitkeep
```

You can also name the file as just .keep , in which case the second line above would be ```touch mydir/.keep```

### I want to cache a username and password for a repository

You might have a repository that requires authentication.  In which case you can cache a username and password so you don't have to enter it on every push and pull. Credential helper can do this for you.

```sh
$ git config --global credential.helper cache# Set git to use the credential memory cache
```

```sh
$ git config --global credential.helper 'cache --timeout=3600'# Set the cache to timeout after 1 hour (setting is in seconds)
```

To find a credential helper:

```sh
$ git help -a | grep credential# Shows you possible credential helpers
```

For OS specific credential caching:

```sh
$ git config --global credential.helper osxkeychain# For OSX
```

```sh
$ git config --global credential.helper manager# Git for Windows 2.7.3+
```

```sh
$ git config --global credential.helper gnome-keyring# Ubuntu and other GNOME-based distros
```

More credential helpers can likely be found for different distributions and operating systems.

### I want to make Git ignore permissions and filemode changes

```sh
$ git config core.fileMode false
```

If you want to make this the default behaviour for logged-in users, then use:

```sh
$ git config --global core.fileMode false
```

### I want to set a global user

To configure user information used across all local repositories, and to set a name that is identifiable for credit when review version history:

```sh
$ git config --global user.name “[firstname lastname]”
```

To set an email address that will be associated with each history marker:

```sh
git config --global user.email “[valid-email]”
```

### I want to add command line coloring for Git

To set automatic command line coloring for Git for easy reviewing:

```sh
$ git config --global color.ui auto
```

## I've no idea what I did wrong

So, you're screwed - you `reset` something, or you merged the wrong branch, or you force pushed and now you can't find your commits. You know, at some point, you were doing alright, and you want to go back to some state you were at.

This is what `git reflog` is for. `reflog` keeps track of any changes to the tip of a branch, even if that tip isn't referenced by a branch or a tag. Basically, every time HEAD changes, a new entry is added to the reflog. This only works for local repositories, sadly, and it only tracks movements (not changes to a file that weren't recorded anywhere, for instance).

```sh
(master)$ git reflog0a2e358 HEAD@{0}: reset: moving to HEAD~20254ea7 HEAD@{1}: checkout: moving from 2.2 to masterc10f740 HEAD@{2}: checkout: moving from master to 2.2
```

The reflog above shows a checkout from master to the 2.2 branch and back. From there, there's a hard reset to an older commit. The latest activity is represented at the top labeled `HEAD@{0}`.

If it turns out that you accidentally moved back, the reflog will contain the commit master pointed to (0254ea7) before you accidentally dropped 2 commits.

```sh
$ git reset --hard 0254ea7
```

Using `git reset` it is then possible to change master back to the commit it was before. This provides a safety net in case history was accidentally changed.

(copied and edited from [Source](https://www.atlassian.com/git/tutorials/rewriting-history/git-reflog)).

<a name="git-shortcuts"></a>

## Git Shortcuts

### Git Bash

Once you're comfortable with what the above commands are doing, you might want to create some shortcuts for Git Bash. This allows you to work a lot faster by doing complex tasks in really short commands.

```sh
alias sq=squashfunction squash() {    git rebase -i HEAD~$1}
```

Copy those commands to your .bashrc or .bash_profile.

### PowerShell on Windows

If you are using PowerShell on Windows, you can also set up aliases and functions. Add these commands to your profile, whose path is defined in the `$profile` variable. Learn more at the [About Profiles](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles) page on the Microsoft documentation site.

```powershell
Set-Alias sq Squash-Commitsfunction Squash-Commits {  git rebase -i HEAD~$1}
```

# Other Resources

## Books

* [Learn Enough Git to Be Dangerous](https://www.learnenough.com/git-tutorial) - A book by Michael Hartl covering Git from basics
* [Pro Git](https://git-scm.com/book/en/v2) - Scott Chacon and Ben Straub's excellent book about Git
* [Git Internals](https://github.com/pluralsight/git-internals-pdf) - Scott Chacon's other excellent book about Git

## Tutorials

* [19 Git Tips For Everyday Use](https://www.alexkras.com/19-git-tips-for-everyday-use) - A list of useful Git one liners
* [Atlassian's Git tutorial](https://www.atlassian.com/git/tutorials) Get Git right with tutorials from beginner to advanced.
* [Learn Git branching](https://learngitbranching.js.org/) An interactive web based branching/merging/rebasing tutorial
* [Getting solid at Git rebase vs. merge](https://medium.com/@porteneuve/getting-solid-at-git-rebase-vs-merge-4fa1a48c53aa)
* [Git Commands and Best Practices Cheat Sheet](https://zeroturnaround.com/rebellabs/git-commands-and-best-practices-cheat-sheet) - A Git cheat sheet in a blog post with more explanations
* [Git from the inside out](https://codewords.recurse.com/issues/two/git-from-the-inside-out) - A tutorial that dives into Git's internals
* [git-workflow](https://github.com/asmeurer/git-workflow) - [Aaron Meurer](https://github.com/asmeurer)'s howto on using Git to contribute to open source repositories
* [GitHub as a workflow](https://hugogiraudel.com/2015/08/13/github-as-a-workflow/) - An interesting take on using GitHub as a workflow, particularly with empty PRs
* [Githug](https://github.com/Gazler/githug) - A game to learn more common Git workflows
* [learnGitBranching](https://github.com/pcottle/learnGitBranching) - An interactive git visualization to challenge and educate!

## Scripts and Tools

* [firstaidgit.io](http://firstaidgit.io/) A searchable selection of the most frequently asked Git questions
* [git-extra-commands](https://github.com/unixorn/git-extra-commands) - a collection of useful extra Git scripts
* [git-extras](https://github.com/tj/git-extras) - GIT utilities -- repo summary, repl, changelog population, author commit percentages and more
* [git-fire](https://github.com/qw3rtman/git-fire) - git-fire is a Git plugin that helps in the event of an emergency by adding all current files, committing, and pushing to a new branch (to prevent merge conflicts).
* [git-tips](https://github.com/git-tips/tips) - Small Git tips
* [git-town](https://github.com/Originate/git-town) - Generic, high-level Git workflow support! http://www.git-town.com

## GUI Clients

* [GitKraken](https://www.gitkraken.com/) - The downright luxurious Git client,for Windows, Mac & Linux
* [git-cola](https://git-cola.github.io/) - another Git client for Windows and OS X
* [GitUp](https://github.com/git-up/GitUp) - A newish GUI that has some very opinionated ways of dealing with Git's complications
* [gitx-dev](https://rowanj.github.io/gitx/) - another graphical Git client for OS X
* [Sourcetree](https://www.sourcetreeapp.com/) - Simplicity meets power in a beautiful and free Git GUI. For Windows and Mac.
* [Tower](https://www.git-tower.com/) - graphical Git client for OS X (paid)
* [tig](https://jonas.github.io/tig/) - terminal text-mode interface for Git
* [Magit](https://magit.vc/) - Interface to Git implemented as an Emacs package.
* [GitExtensions](https://github.com/gitextensions/gitextensions) - a shell extension, a Visual Studio 2010-2015 plugin and a standalone Git repository tool.
* [Fork](https://git-fork.com/) - a fast and friendly Git client for Mac (beta)
* [gmaster](https://gmaster.io/) - a Git client for Windows that has 3-way merge, analyze refactors, semantic diff and merge (beta)
* [gitk](https://git-scm.com/docs/gitk) - a Git client for linux to allow simple view of repo state.
* [SublimeMerge](https://www.sublimemerge.com/) - Blazing fast, extensible client that provides 3-way merges, powerful search and syntax highlighting, in active development.