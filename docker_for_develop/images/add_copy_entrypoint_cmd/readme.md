(1) Add 与 copy 的区别

  Add my.tar /root/    #/root/my/*
  Copy my.tar /root/   #/root/my.tar

(2)EntryPoint与 CMD的区别
  docker run ubuntu sleep 20 //sleep 20  覆盖 CMD
  docker run ububtu 20 //ububtu如果指定了entrypoint

  可以简单的吧entrypoint 理解成 一个可执行命令
