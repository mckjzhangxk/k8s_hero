(1) context 指的是 有 Dockerfile 的location, 有关copy,add的命令 会从
context 传到 【docker daemon】
eg:
    // contex是当前目录
    docker build . -t zxk/brtc-intelrouter  

    //context 是 /Users/zzzlllll/myproject/brtc-intelrouter
    docker build /Users/zzzlllll/myproject/brtc-intelrouter -t zxk/brtc-intelrouter 

    <!-- git@git.baijiashilian.com:LLL/gloud/brtc-intelrouter.git -->
    docker build  https://git.baijiashilian.com/LLL/gloud/brtc-intelrouter.git -t zxk/brtc-intelrouter 
    docker build  git@git.baijiashilian.com:LLL/gloud/brtc-intelrouter.git -t zxk/brtc-intelrouter 
(2) 再.dockerignore的文件不会被 传送给【docker daemon】