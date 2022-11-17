为啥需要插件？
    登录github,azure,这些功能都是通过插件实现的。
    plugin就是命令，比如sh,git,
方法1：
    查看已经安装的插件
    http://zz02:8080/manage/pluginManager/installed


    To install a new plugin in Jenkins
    1) Go to Manage Jenkins -> Manager Plugins
    2) Click Available and search for the desired plugin.
    3) Select the desired plugin and Install.
    Note: Few plugins may need a restart 
    To restart Jenkins
    $ sudo systemctl restart jenkins
方法2：
https://plugins.jenkins.io/