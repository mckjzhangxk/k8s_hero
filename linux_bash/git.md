 #### 安装&&帮助
```sh
apt install -y git git-man
git help
git help <sub commit>
```
#### 本地repo相关操作

```sh
git init  #初始化本地库
git add . #添加文件到本地库
git commit -m 'first commit' #保存本地库

git rm note.txt --cached #移除note.txt的staging的状态
git restore app.js #把app.js的change恢复。这个change是指activate change
```

提交需要记录用户信息，下面的命令设置
```
git config user.name sarah
git config user.email mckj_zhangxk@163.com
git config --get user.name #检查设置
git config --get user.email #检查设置
```

#### 概念
* working area: active change，
* *  untracked files:文件被新创建
* *  modified files: 文件被修改
* staging area:暂存到本地
* commit：持久化的本地

#### 日志查看
```
git log
git log --oneline
git log --name-only #现在提交的文件
git log -3  #显示最近3次的提交记录
git log --graph --decorate
git log master,git log origin/master
```

#### 分支
<font color=red>HEAD 总是指向【最后checkout 分支】的【最后commit】.</font>
**HEAD always points to the last commit on the currently checked-out branch.**
```git
#创建新的分支
git branch new_feature
#切换到新的分支
git checkout  new_feature
#创建并立即切换到新的分支
git checkout -b new_feature

#删除分支
git branch -d new_feature
#查看所有分支
git branch -a
```

```
保存当前分支，切换master分支
git commit -am '暂存未完成'
git checkout master
....
```

#### 分支merge
- fast-forward-merge: 分支落后于合并的分支
- non-fast-forward-merge:
```
git checkout master
# feature 分支被合并到 master
git merge feature 
```

### remote repository:[gitae](https://docs.gitea.io/en-us/install-with-docker/#basics)
```git
# origin是 远程的别名，用于代替connection string
git remote add origin [connection string]
#查看
git remote -v
#推送到origin 的 master分支上
git push origin master
```

#### pull request
- 相当于 再github,gitlab,某个【主分支】执行一个 合并其他分支的merge
- 注意 这里的发起者 是 **主分支**


<font color=red>对于untrack的文件，我们可以把 untrack文件切换到另外一个分支</font>
```
vi myfile.txt
git checkout branch1
ls myfile.txt #myfile.txt 不会丢失
```
fetch &&merge
当远程的repo是最新版本了，可以使用以下命令合并到本地repo
```
#拉取origin的master分支
git fetch origin master
#合并origin/master 到本地分支
git merge origin/master

#或者直接
git pull
```

merge conflict
HEAD表示本地的，origin/master表示远程的，通过=======来划分界限
```git
<<<<<<< HEAD
1. The Lion and the Mooose
2. The Frogs and the Ox
3. The Fox and the Grapes
4. The Donkey and the Dog
=======
1. The Lion and the Mouse
2. The Frogs and the Ox
3. The Fox and the Grapes
>>>>>>> origin/master


修改后的结果
1. The Lion and the Mouse
2. The Frogs and the Ox
3. The Fox and the Grapes
4. The Donkey and the Dog

git commit -am 'Resolve conflict'
```

### Fork(派生)
- 如果你对某个repo只有读的权限，又想贡献code,先fork一份备份
- 添加并提交code
- 发起pull request, from=fork repo,into=src reoo
- 由repo的原作者进行review,approve,reject....


### Rebase
```
#master作为 当前commit的base
git rebase master

#交互的方式，重新定义base
git rebase -i HEAD~3


#把hashvalue 的更改加入本分支，并提交
#更改是指 hashvalue对于提交的文件修改！！！
git cherry hashvalue
```

### reset,revert
<font color=red>HEAD~0表示 当前的commit</font>
```git
#提交回到 head-1
git revert HEAD~0
#提交回到 hashvalue对于提交的之前一次
git revert hashvalue

#都是恢复到HEAD-3的提交，区别在于恢复后是否
#保留HEAD~0,HEAD~1,HEAD~2的提交

git reset HEAD~3 --soft  #保存，临时文件，untrack
git reset HEAD~3 --hard  #不保存
```


stash
```
# 暂存当前状态，入栈，之后可以切换到其他分支，当前分支
#没提交的文件，不会丢失
git stash
git stash show stash@{1}
git stash list
# 出栈
git stash pop
git stash pop stash@{0} 
```