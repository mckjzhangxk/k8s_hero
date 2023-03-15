# ReplicaSets



- Replication Controller
- ReplicaSet

#### Controllers are brain behind kubernetes

## What is a Replica and Why do we need a replication controller?

  ![rc](../../images/rc.PNG)
  
  ![rc1](../../images/rc1.PNG)
  

## Replication Controller Definition File
  
   ![rc2](../../images/rc2.PNG)
  
```yaml
    apiVersion: v1
    kind: ReplicationSet
    metadata:
      name: redis
    spec:
     template:
        metadata:
          name: redis-pod
          labels:
            app: redis
        spec:
         containers:
         - name: redis
           image: redis:latest
     replicas: 3
     selector:
       matchLabels:
         app: redis
```

#### 命令
   
  - To Create the replicaset
    ```
    $ kubectl create -f replicaset-definition.yaml
    ```
  - To list all the replicaset
    ```
    $ kubectl get replicaset
    ```
  - To list pods that are launch by the replicaset
    ```
    $ kubectl get pods
    ```
   
    ![rs1](../../images/rs1.PNG)
