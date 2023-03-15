# Node Selectors


In this section, we will take a look at Node Selectors in Kubernetes


![nsel](../../images/nsel.PNG)

- To label nodes

  Syntax
  ```
  $ kubectl label nodes <node-name> <label-key>=<label-value>
  ```
  Example
  ```
  $ kubectl label nodes node-1 size=Large
  ```

![ln](../../images/ln.PNG)

- To create a pod definition
  ```
  apiVersion: v1
  kind: Pod
  metadata:
   name: myapp-pod
  spec:
   containers:
   - name: mpc
     image:  'registry.cn-beijing.aliyuncs.com/bjy-webrtc/mpc:v2023022701'
   nodeSelector:
      env: test-latest
      region: sh
  ```
  ```
  $ kubectl create -f pod-definition.yml
  ```
  
![nsel](../../images/nsel.PNG)
  
## Node Selector - Limitations
- We used a single label and selector to achieve our goal here. But what if our requirement is much more complex.
  
![nsl](../../images/nsl.PNG)
 
- For this we have **`Node Affinity and Anti Affinity`**




