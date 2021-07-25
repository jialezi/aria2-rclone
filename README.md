# aria2-rclone
aria2下载后使用rclone自动上传到网盘的docker镜像

AMD64/ARM64

-------------------------------------

主要功能是Aria2下载+Rclone上传，Rclone上传默认没配置，具体设置方法看下面说明。

使用的软件版本：

- Aria2c 1.35.0 
- Rclone 官方v1.56.0（支持世纪互联，如果用世纪互联需要重新配置一下）
- ~~Rclone 魔改支持世纪互联的gclone v1.52.13~~
- Caddy 1.0.4
- Filebrowser 2.15.0
- AriaNg 1.1.6

-------------------------------------

#### 环境变量
env rpc jaz

aria2的密码：rpc=jaz（默认都是jaz）

#### 端口
Aria2端口：6800

AriaNg：80

#### 下载目录
Aria2下载目录  /home/aria2

Aria2配置目录 /root/.aria2

#### caddy
caddy配置文件  /home/caddy/Caddyfile

网站目录  /home/caddy/www

##### Filebrowser
Filebrowser默认用户名：admin

Filebrowser默认密码：admin

Filebrowser默认目录：/

> 提示：Filebrowser可以设置多用户

---------------------------------------------

#### docker运行

```
##docker启动
docker run -idt -p 80:80  -p 6800:6800 -v /home/aria2:/home/aria2 -e rpc=jaz --restart=always --name aria2 jialezi/aria2

##再执行docker logs查看信息
docker logs aria2
 ```

--------------------------------------

**运行后浏览器打开http://ip，先设置Aria2的端口密码**

 ![image](https://p.pstatp.com/origin/1376f0002ce22eb236bf8)

--------------------------------------

 ![image](https://i.imgur.com/xSk7NU7.jpg)

-------------------------------------

**点击文件管理，打开FileBrowser，默认admin:admin**

 ![image](https://p.pstatp.com/origin/1388800025805be0f3d6f)

--------------------------------------

 ![image](https://p.pstatp.com/origin/feff0003180f8a3621c8)

--------------------------------------

 ![image](https://p.pstatp.com/origin/138d20000bc8489cf3a8d)


--------------------------------------

### 配置Rclone和自动上传（ 重要！）

1.自行在别的地方（本地电脑/vps等等）配置好rclone，保存rclone.conf文件。
（配置文件：linux的一般存放在/root/.config/rclone/rclone.conf ， Win上的存放在 C:\Users\Administrator\.config\rclone\rclone.conf）

2.FileBrowser里面打开 /root/.config/rclone（里面有个up.sh.bak） ，把rclone.conf替换成你的配置文件rclone.conf。

3.把**up.sh.bak**改名为**up.sh**，之后打开修改文件开头的几个配置（主要是name和folder）。

**name='sa'  #配置Rclone时的name（就是rclone.conf里面[xxx]的xxx）**

**folder='drive'  #网盘里的文件夹**

-------------------------------------
最后提醒几点：

1.下载bt没速度的，可以试试添加tracker（AriaNG面板添加或配置文件/root/.aria2/aria2.conf添加），可以去https://sleele.gitee.io/aria2-trackers/ 获取tracker地址

2.AriaNg里面下载失败、手动删除的任务文件在本地是不会自动删除的，需要手动去删除。（也可以配合aria2配置相关脚本执行，本配置没有设置）

3.进入docker容器的命令：docker exec -it aria2 sh（aria2是容器的名字，sh是cmd命令）

4.如果只想使用一个端口（可能你使用内网穿透服务只有一个端口时），考虑反向代理aria2c 6800

Caddyfile里面添加   proxy /jsonrpc  127.0.0.1:6800

5.FileBrowser可以执行Linux命令代码，解锁unzip/wget等命令，需要手动添加 设置-用户管理—用户命令(Linux 代码)

6.需要更新/更改软件、修改自己配置，构建自己镜像的，参考以下方法（仓库内bin目录的软件均为linux-amd64版，其他系统请自行下载相应版本替换）
```
#先克隆本仓库
git clone https://github.com/jialezi/aria2-rclone
#再进入aria2-rclone，更换自己需要的配置/软件
cd aria2-rclone
#本地构建docker镜像（-f为Dockerfile文件，-t为镜像名称，不要漏了那一点.）
docker build -f Dockerfile . -t aria2
#之后启动镜像（同上介绍）
docker run -idt --name aria2 -p 80:80  -p 6800:6800 -v /home/aria2:/home/aria2 -e rpc=jaz --restart=always aria2
```

--------------------------------------
感谢相关项目：

https://rclone.org/ （https://rclone.org/downloads/）

https://github.com/q3aql/aria2-static-builds （https://github.com/q3aql/aria2-static-builds/releases）

https://caddyserver.com （https://github.com/caddyserver/caddy/releases/tag/v1.0.4）

https://filebrowser.org （https://github.com/filebrowser/filebrowser/releases）

http://ariang.mayswind.net/ 
