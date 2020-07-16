# 部署
## 1.本地利用maven打包工具
    1.exploded是生成打包文件在target/下；
    2.inplace是生成打包文件在src/main/webapp下；
    3.war是生成war包和打包文件在target/下；

## 2.服务器进行部署（默认有有相应的环境）
#### 解压：
    tar -xvf blog_project-0.0.1-SNAPSHOT.tar.gz
#### 替换文件：
    cd blog_project-0.0.1-SNAPSHOT/WEB-INF/classes/
    rm -rf application.yml 
    rm -rf articleImage
    cp /root/backups/document/application.yml /root/blog/blog_project-0.0.1-SNAPSHOT/WEB-INF/classes
    cp -r /root/backups/articleImage/ /root/blog/blog_project-0.0.1-SNAPSHOT/WEB-INF/classes
#### 启动java进程
    cd /root/blog/blog_project-0.0.1-SNAPSHOT/
    nohup java -cp "WEB-INF/lib/*:WEB-INF/classes" com.gzmu.blog_project.BlogProjectApplication > blog.log 2>&1 &
#### 查看java进程
    ps -ef | grep java | grep -v grep
#### 修改niginx
    /usr/local/nginx/conf/nginx.conf
#### 重启niginx
    cd /usr/local/nginx/sbin
    ./nginx -s stop
    ./nginx
