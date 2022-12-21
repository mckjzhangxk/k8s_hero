#!/bin/sh
while true
do
    echo "[1] reboot"
    echo "[2] exit"

    read -p "input your chioce:" chioce


    case $chioce in
        1) 
        echo "\tReboot System"
        ;;
        2) 
        echo "Bye"
        break
        ;;
        *)
        continue
        ;;
    esac
done