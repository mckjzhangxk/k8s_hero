mkdir /tmp/memory

mount -t tmpfs -o size=12000M tmpfs /tmp/memory

dd if=/dev/zero of=/tmp/memory/block


# 清理
rm /tmp/memory/block

umount /tmp/memory

rmdir /tmp/memory