### AlertManager

独立的服务，prometheus的alert rule触发之后，会上报给 alert manager,
alert manager 聚合alert,决定是否下发通知
###  概念
### 配置AlertManager
* Grouping:相似的alert被分成一组，一组会触发一个notification
* Inhibition: 某些 alert notification被触发了，就忽视（抑制）与这个alert相关的notofication
* Silences: 通过正则的匹配，匹配成功的alert忽视。不再发生notification
### 配置Prometheus与AlertManager通信