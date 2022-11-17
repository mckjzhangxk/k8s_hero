### Authentication 认证


任何对api-server的访问，首先认证用户是否合法，然后是用户是否有权限访问，最终把结果返回给用户。



### 最基本的 认证方式:

1.本地保存statis username,password
    /tmp/users/user-details.csv

    然后api-server pod的spec.contains.command加入以下命令
        --basic-auth-file=/tmp/users/user-details.csv 
2.本地保存 token方式
    /tmp/users/user-details.csv
    
    然后api-server pod的spec.contains.command加入以下命令
        --token-auth-file=/tmp/users/user-details.csv 