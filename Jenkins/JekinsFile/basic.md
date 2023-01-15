1.jenkinsfile是如下结构组成的：

 pipeline ： 理解成 要执行的任务
    agent   ：worker节点？,从那里运行pipeline
    stages
        stage{} 每一个阶段
            steps 完成很阶段任务的 指令序列

注意 ：不同多个stage叫做multi stages ?,stages直接执行的步骤
是相近的。

2. multi stages:
        多个 jenkinsfile
        或者一个jenkinsfile 包括多个stage?
