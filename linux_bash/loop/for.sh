#使用空格
for v in a b c
do
    echo "$v is comming"
done


# read from file
for v in $(cat data.txt)
do
    echo "$v is comming"
done


for v in {1..100}
do
    echo "$v is comming"
done

for (( v=0;v<3;v++))
do
    echo "$v is comming"
done