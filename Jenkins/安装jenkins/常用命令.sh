#! /bin/sh
systemctl enable jenkins #开机自启动
systemctl start jenkins
systemctl status jenkins