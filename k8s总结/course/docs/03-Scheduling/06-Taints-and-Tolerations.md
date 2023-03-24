# Taints and Tolerations

#### 污点（Taints）和容忍度（Tolerations）用于限制哪些Pod可以在节点上调度。 
- 只有那些对节点上特定污点具有容忍度的Pod才能在该节点上调度。

  ![tandt](../../images/tandt.PNG)
上图中，node1上有污点，A,B,C都不会被调度到node1上，D会被调度到，因为D有对污点的容忍度。  
## Taints
- 使用 **`kubectl taint nodes`** 命令给node打污点。

  Syntax
  ```
  $ kubectl taint nodes <node-name> key=value:taint-effect
  ```
 
  Example
  ```
  $ kubectl taint nodes node1 app=blue:NoSchedule
  ```
  
- 污点效应定义了如果Pod不能容忍该污点会发生什么情况。.
- 3种污点效应（taint effects）
  - **`NoSchedule`**：新节点不会被调度，已经调度的不受影响
  - **`PreferNoSchedule`** ：新节点尽量不会被调度
  - **`NoExecute`** 新节点不会被调度，已经调度的被驱逐。
  
  ![tn](../../images/tn.PNG)
  
## Tolerations
   - Tolerations are added to pods by adding a **`tolerations`** section in pod definition.
     ```
     apiVersion: v1
     kind: Pod
     metadata:
      name: myapp-pod
     spec:
      containers:
      - name: nginx-container
        image: nginx
      tolerations:
      - key: "app"
        operator: "Equal"
        value: "blue"
        effect: "NoSchedule"
     ```
  ![tp](../../images/tp.PNG)


#### 污点和容忍并不告诉Pod要去哪个特定的节点。相反，它们告诉节点只接受具有特定容忍的Pod。
- To see this taint, run the below command
  ```
  $ kubectl describe node kubemaster |grep Taint
  ```
 
 ![tntm](../../images/tntm.PNG)
  