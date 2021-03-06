# [MySQL数据库生成RESTful APIs APP](https://github.com/dejavuzhou/ginbro)
[![Build Status](https://travis-ci.org/dejavuzhou/ginbro.svg?branch=master)](https://travis-ci.org/dejavuzhou/ginbro) 
[![GoDoc](http://godoc.org/github.com/dejavuzhou/ginbro?status.svg)](http://godoc.org/github.com/dejavuzhou/ginbro) 
[![Go Report Card](https://goreportcard.com/badge/github.com/dejavuzhou/ginbro)](https://goreportcard.com/report/github.com/dejavuzhou/ginbro)
![stability-stable](https://img.shields.io/badge/stability-stable-brightgreen.svg)
[![codebeat badge](https://codebeat.co/badges/650029a5-fcea-4416-925e-277e2f178e96)](https://codebeat.co/projects/github-com-dejavuzhou-ginbro-master)
[![codecov](https://codecov.io/gh/dejavuzhou/ginbro/branch/master/graph/badge.svg)](https://codecov.io/gh/dejavuzhou/ginbro)

## 一个命令行工具:快速生成go语言RESTful APIs应用 
## 文档和DEMO
- [在线DEMO](http://ginbro.mojotv.cn/swagger/)
- [中文文档](readme_zh.md)            
- [Video-Demo-Youtube](https://www.youtube.com/watch?v=TvWQhNKfmCo&feature=youtu.be)
- [Video-Demo-Bilibili](https://www.bilibili.com/video/av36804258/)

## Feature
- [生成完善RESTful APIs 应用](/boilerplate)
- [自动生成完善的Swagger文档](boilerplate/static/swagger)
- [自动生成数据库表的模型和标注](boilerplate/models)
- 支持 [JWT Authorization Bearer](boilerplate/handlers/middleware_jwt.go) [身份验证](boilerplate/handlers/handler_auth.go) and [JWT 中间件](boilerplate/models/jwt.go)
- [支持登陆防火墙](boilerplate/models/model_users.go)
- [支持静态资源替代nginx](boilerplate/static)
- [可配置的跨域cors中间件](boilerplate/handlers/gin_helper.go)
- [用户友好的自定义配置](tpl/config.toml)
- [支持定时任务](boilerplate/tasks)
- [支持图形工具GUI](gui)
- [内置高效率的内存数据库](https://github.com/dejavuzhou/ginbro/blob/master/boilerplate/models/db_memory.go)

## ginbro工具安装
您可以通过如下的方式安装 ginbro 工具：
```shell
go get github.com/dejavuzhou/ginbro
```
安装完之后，`ginbro` 可执行文件默认存放在 `$GOPATH/bin` 里面，所以您需要把 `$GOPATH/bin` 添加到您的环境变量中，才可以进行下一步。
如何添加环境变量，请自行搜索
如果你本机设置了`GOBIN`,那么上面的命令就会安装到 `GOBIN`下，请添加`GOBIN`到你的环境变量中

### 如果没有配置GOBIN到环境变量,执行下面命令
```shell
cd $GOPATH/src/github.com/dejavuzhou/ginbro
go build
./ginbro -h
```

## 使用
`ginbro gen -u root -p ginbro -c utf8 -a 127.0.0.1:3306 --authTable=users --authPassword=password  --outPackage=github.com/dejavuzhou/ginbro_demo -d=ginbro`
- cd 到生成的项目
- go build  和run
- 访问[`http://127.0.0.1:5555/swagger`](http://127.0.0.1:5555/swagger)

### 生成新project目录树 [ginbro-son DEMO代码](https://github.com/dejavuzhou/ginbro-son)
```shell
C:\Users\zhouqing1\go\src\github.com\mojocn\apiapp>tree /f /a
|   config.toml
|   main.go
|   readme.md
|
+---config
|       viper.go
+---handlers
|       gin.go
|       handler_wp_posts.go
|       handler_wp_users.go
|
+---models
|       db.go
|       model_wp_posts.go
|       model_wp_users.go
|
+---static
|   |   .gitignore
|   |   index.html
|   |   readme.md
|   |
|   \---index_files
|           style.css
|           syntax.css
|
\---swagger
        .gitignore
        doc.yml
        favicon-16x16.png
        favicon-32x32.png
        index.html
        oauth2-redirect.html
        readme.md

```
### 命令参数说明
```shell
ginbro gen -h
generate a RESTful APIs app with gin and gorm for gophers. For example:
        ginbro gen -u eric -p password -a "127.0.0.1:3306" -d "mydb"

Usage:
  create gen [flags]

Flags:
  -a, --Mysql IP PORT    mysql host:port (default "dev.mojotv.com:3306")
  -l, --应用地址端口    app listen Address eg:mojotv.cn, use domain will support gin-TLS (default "127.0.0.1:5555")
  -c, --数据库字符集    database charset (default "utf8")
  -d, --数据库名称   database name (default "dbname")
  -h, --help              help for gen
  -o, --输出地址      输出地址相对于$GOPATH/src
  -p, --数据库密码   database password (default "Password")
  -u, --数据库用户     database user name (default "root")
  --authTable 登陆用户表名  default users
  --authPassword 登陆用户密码字段 default password
```

## 依赖 go packages
```shell
go get github.com/gin-contrib/cors
go get github.com/gin-contrib/static
go get github.com/gin-gonic/autotls
go get github.com/gin-gonic/gin
go get github.com/sirupsen/logrus
go get github.com/spf13/viper
go get github.com/spf13/cobra
go get github.com/go-redis/redis
go get github.com/go-sql-driver/mysql
go get github.com/jinzhu/gorm
go get github.com/dgrijalva/jwt-go
```
## 开发计划
- [x] Auth 和 JWT middleware
- [x] 支持一键生产jwt密码验证
- [x] 分页总数做mem缓存
- [x] json不现实password等隐私字段
- [x] 生成友好的.gitignore
- [x] go test 单元测试
- [x] 完善go doc
- [ ] 支持MongoDB数据库
- [ ] 更具体数据映射关联模型
- [ ] 支持PostgreSQL数据库
- [ ] 支持生成gRPC服务
- [ ] 更详细的gorm tag信息
- [ ] swaggerDoc参数说明继续优化
- [ ] 支持其他语言框架(php-laravel/lumne ,python flask ...)
- [ ] sqlite

## 注意
- mysql表中没有id/ID/Id/iD字段将不会生成路由和模型
- json字段 在update/create的时候 必须使可以序列号的json字符串(`eg0:"{}" eg1:"[]"`),否则mysql会报错

## 致谢
- [swagger规范](https://swagger.io/specification/)
- [gin-gonic/gin框架](https://github.com/gin-gonic/gin)
- [GORM数据库ORM](http://gorm.io/)
- [viper配置文件读取](https://github.com/spf13/viper)
- [cobra命令行工具](https://github.com/spf13/cobra#getting-started)
- [我的另外一个go图像验证码开源项目](https://github.com/mojocn/base64Captcha)

## 请各位大神不要吝惜提[`issue`](https://github.com/dejavuzhou/ginbro/issues)同时附上数据库表结构文件