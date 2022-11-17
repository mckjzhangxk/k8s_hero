while true
do
    echo "[1] reboot"
    echo "[2] exit"

    read -p "input your chioce:" chioce


    if [ $chioce -eq 1 ]
    then
        echo "Reboot System"
    elif [ $chioce -eq 2 ]
    then
        echo "Bye"
        break
    else
        continue
    fi
done