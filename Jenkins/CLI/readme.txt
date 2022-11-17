使用 jenkins客户单而不是UI 来操作 jenkins.


A.鉴权，生成访问token
访问 http://zz02:8080/user/zxk/configure
加入 ssh pub key,生成token,11d350ac2eea9833de55085a24bc825e39

B.查看本页面(http://zz02:8080/manage/cli/)
java 版本必须>=11,/opt/homebrew/Cellar/openjdk/16.0.1/bin/java

#登录鉴权：
java -jar jenkins-cli.jar -s http://zz02:8080/ -auth zxk:11d350ac2eea9833de55085a24bc825e39

#查看帮助
java -jar jenkins-cli.jar -s http://zz02:8080/ -auth zxk:11d350ac2eea9833de55085a24bc825e39  -webSocket help

#展示全部任务
java -jar jenkins-cli.jar -s http://zz02:8080/ -auth zxk:11d350ac2eea9833de55085a24bc825e39  -webSocket list-jobs

#构建任务 
java -jar jenkins-cli.jar -s http://zz02:8080/ -auth zxk:11d350ac2eea9833de55085a24bc825e39  -webSocket build myjob1