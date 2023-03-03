1.安装go插件

2.设置全局的go(可选，所有stages的go 由jekin统一管理)

    2.1全局工具配置下载go： http://zz02:8080/manage/configureTools/
    2.2 go的下载地址需要替换成 国内镜像
        vim /var/lib/jenkins/updates/org.jenkinsci.plugins.golang.GolangInstaller
        :s#https://golang.org/dl#https://gomirrors.org/dl/go#g



**4.所有的pipiline Root目录如下** 

```sh
#多个steps，执行的根目录
/var/lib/jenkins/workspace/$pipelineName
```

5 git 插件
```sh
git "https://github.com/kodekloudhub/go-webapp-sample.git"

#文件展开到 /var/lib/jenkins/workspace/$pipelineName 目录下
```

6 docker的使用

```sh
    chmod 777 /var/run/docker.sock #jenkins用户需要访问此文件
    # 推送前需要认证登录
    sh 'docker login -u zhangxiaokai -p Bai2021 harbor.baijiayun.com'
    sh 'docker push harbor.baijiayun.com/sidecar/jekendemo:0.0.2'
```

7
[k8s-jenkins](https://www.youtube.com/watch?v=ZXaorni-icg&t=1219s)