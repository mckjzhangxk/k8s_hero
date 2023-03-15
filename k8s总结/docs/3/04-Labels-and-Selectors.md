# Labels and Selectors

#### Labels and Selectors are standard methods to group things together.
  
#### Labels are properties attached to each item.

  ![labels-ckc](../../images/labels-ckc.PNG)
  
#### Selectors help you to filter these items
 
  ![sl](../../images/sl.PNG)
  
How are labels and selectors are used in kubernetes?
- We have created different types of objects in kubernetes such as **`PODs`**, **`ReplicaSets`**, **`Deployments`** etc.
  
  ![ls](../../images/ls.PNG)
  

 ![lpod](../../images/lpod.PNG)
 
Once the pod is created, to select the pod with labels run the below command
```
$ kubectl get pods --selector app=App1
```

For services
 
      ```
      apiVersion: v1
      kind: Service
      metadata:
       name: my-service
      spec:
       selector:
         app: App1
       ports:
       - protocol: TCP
         port: 80
         targetPort: 9376 
       ```
  ![lrs1](../../images/lrs1.PNG)
