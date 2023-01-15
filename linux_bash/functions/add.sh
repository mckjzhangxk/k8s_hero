

function add(){

    c=$1+$2 
    echo $c
    echo 22    #外面使用sum 接住
    return 33  #只能返回数字
}


sum=$(add 33 44)
result=$?
echo $sum
echo $result
