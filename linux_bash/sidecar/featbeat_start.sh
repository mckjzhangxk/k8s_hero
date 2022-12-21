
export name=$(curl -s cip.cc|head -n 1|tr -d " "|cut -d : -f 2)&&filebeat --path.config /conf -e