A.volumes 这是在pod的角度（container_volume.yaml）

container volumn: 容器如果需要 把数据持久化，需要
    指定 volumn(name,...)，然后把这个volumn挂载到
    应用使用的目录中。

    volumn的种类很多：
        persistentVolumeClaim:(name,claimName)
        hostPath:(name,path,type)
        awsElasticBlockStore：(name,volumeID,fsType)
        。。。。

B. k8s中的持久化套：
    pv:存储卷
    pvc：存储卷的申请使用
    storageClass:动态创建pv

pv: k8s维护的持久卷，就是物理存储的概念， 全局的.(persistentVolume.yaml)
    pv的种类对应于 container volumn的种类，唯一的区间就是他的全局性

pvc: pv 空间的请求,隶属于 namespace的
    声明定义：yaml 定义.(persistentVolumeClaim)
    作为volumn使用： 在pod.container里面声明使用volumn=persistentVolumeClaim (pod_with_pvc.yaml)

    注意：1）pvc与pv的绑定是一一对应的，不会有2个pvc共有一个pv.
        匹配的规则可以根据 capicity是否足够，以及 match label进行选择,但不是所有storageClass
        都支持label匹配： StorageClass "local-path": claim.Spec.Selector
        2） pvc的绑定是在 第一个volumn创建的时候，否则一直是pending！！！

sc:存储类:
    存储量 是用于动态创建pv的.
    可以在pvc中设置storageClassName,这样k8s就会使用sc来动态创建Pv,
    可见，收到创建pv的过程就不需要了！！！