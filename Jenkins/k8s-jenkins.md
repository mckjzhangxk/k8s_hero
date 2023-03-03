## Table of Conents
- [Table of Conents](#table-of-conents)
- [服务地址信息](#服务地址信息)
- [创建jenkin工程](#创建jenkin工程)
- [git仓库集成](#git仓库集成)
- [构建发布版本](#构建发布版本)

## 服务地址信息
| 服务器地址 | 用户名/密码 |
| - | - |
| [link](http://10.16.31.253:32000/) | LDAP账户


## 创建jenkin工程

- 【新建任务】 ->【输入一个任务名称】 ->【选择流水线】,点击【确定】。
- 勾选【参数化构建过程】，设置如下变量：
   | 变量名称  | 作用 | 类型 |   eg|
   | -        | -   | -    |-    |
   | BRANCH| git分支名   | 字符参数 | master
   | REPOSITORY_URL|docker仓库地址   | 字符参数 |registry.cn-beijing.aliyuncs.com
   | PROJECT|docker仓库地址项目名称  | 字符参数 |bjy-webrtc/rtcs
   | TAG|打包镜像tag  | 字符参数 | 202303092020
-  【流水线 定义】下拉框 添加此文件内容[JenkinsFile](JekinsFile/k8s-jenkinFile/JenkinsFile)，点击【保存】。
_HINT 1_:以下需要替换
> **NOTE**   替换url为git项目地址。
```
stage('clone') {
    steps {
        checkout scmGit(branches: [[name: '$BRANCH']], extensions: [], userRemoteConfigs: [[credentialsId: 'zhangxk', url: 'https://git.baijiashilian.com/cloud/BRTC/msms.git']])
    }
}
```
> **NOTE**  ###替换zhangxiaokai,Bai2021 为 docker仓库 账号，密码
```
container('go') {
                            sh 'docker build -t ${REPOSITORY_URL}/${PROJECT}:${TAG} -f rest.Dockerfile .'
                            sh 'docker login -u zhangxiaokai -p Bai2021 ${REPOSITORY_URL}'
                            sh 'docker push ${REPOSITORY_URL}/${PROJECT}:${TAG}'
}
```
> **NOTE** 替换msms-deployment为对于服务，见下表
```
script {
    withKubeConfig([credentialsId: 'kubeconfig',contextName: 'idc']) {
        sh "sed 's#REPOSITORY_AND_TAG#${REPOSITORY_URL}/${PROJECT}:${TAG}#g' patch.template.yaml > patch.yaml"
        sh "kubectl patch  deployment msms-deployment -n test-sh --patch-file  patch.yaml"
        sh "kubectl patch  deployment msms-deployment -n test-bj --patch-file  patch.yaml"
}
```

|服务| 替换为|
|-|-|
|master|master-deployment|
|router|router-deployment|
|messaging|messaging-deployment|
|intelroute|intelroute-deployment|
|mpc|mpc-deployment|
|msms|msms-deployment|
|sentinel|sentinel-deployment|
|puller|puller-deployment|

## git仓库集成
项目根目录添加：patch.template.yaml
```
spec:
  template:
    spec:
      containers:
        #替换为 对于的服务：master,messaging,intelrouter,router,msms,mpc,sentinel,puller
        - name: mpc
          image: "REPOSITORY_AND_TAG"
```
```sh
.
├── go.mod
├── ...
├── ...
├── patch.template.yaml
```

## 构建发布版本
- 进入[dashboard](http://10.16.31.253:32000/blue/organizations/jenkins/pipelines) ->点击创建的项目.
- 运行-> 更新Tag字段-> Run
- 查看日志，等待【步骤执行】执行完成，项目会自动发布到test-latest环境。