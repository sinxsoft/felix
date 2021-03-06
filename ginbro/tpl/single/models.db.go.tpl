package models

import (
	"fmt"
	"github.com/go-redis/redis"
    _ "github.com/jinzhu/gorm/dialects/mssql"
    _ "github.com/jinzhu/gorm/dialects/mysql"
    _ "github.com/jinzhu/gorm/dialects/postgres"
    _ "github.com/jinzhu/gorm/dialects/sqlite"
	"github.com/jinzhu/gorm"
	"github.com/sirupsen/logrus"
	"{{.ProjectPackage}}/config"
	"strings"
	"errors"
)

//redis client
var redisDB *redis.Client
var db *gorm.DB

const redisPrefix = "ginbro:"

func init() {
	//initializing redis client
	redisAddr, redisPassword := config.GetString("redis.addr"), config.GetString("redis.password")
	if redisAddr != "" {
		redisDB = redis.NewClient(&redis.Options{
			Addr:     redisAddr,
			Password: redisPassword,                 // no password set
			DB:       config.GetInt("redis.db_idx"), // use default DB
		})
		if pong, err := redisDB.Ping().Result(); err != nil || pong != "PONG" {
			logrus.WithError(err).Fatal("could not connect to the redis server")
		}
	}
	if gormDB, err := createDatabase(); err == nil {
		db = gormDB
	} else {
		logrus.WithError(err).Fatalln("create database connection failed")
	}
	//enable Gorm mysql log
	if flag := config.GetBool("app.enable_sql_log"); flag {
		db.LogMode(flag)
		//f, err := os.OpenFile("mysql_gorm.log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0666)
		//if err != nil {
		//	logrus.WithError(err).Fatalln("could not create mysql gorm log file")
		//}
		//logger :=  New(f,"", Ldate)
		//db.SetLogger(logger)
	}
	//db.AutoMigrate()

}

//Close clear db collection
func Close() {
	if db != nil {
		db.Close()
	}
	if redisDB != nil {
		redisDB.Close()
	}
}

func createDatabase() (*gorm.DB,error) {
	dbType := config.GetString("db.type")
	dbAddr := config.GetString("db.addr")
	dbName := config.GetString("db.database")
	dbUser := config.GetString("db.user")
	dbPassword := config.GetString("db.password")
	dbCharset := config.GetString("db.charset")
	conn := ""
	switch dbType {
	case "mysql":
		conn = fmt.Sprintf("%s:%s@(%s)/%s?charset=%s&parseTime=True&loc=Local", dbUser,dbPassword, dbAddr, dbName,dbCharset)
	case "sqlite":
		conn = dbAddr
	case "mssql":
		return nil,errors.New("TODO:suport sqlServer")
	case "postgres":
		hostPort := strings.Split(dbAddr, ":")
		if len(hostPort) == 2{
			return nil,errors.New("db.addr must be like this host:ip")
		}
		conn = fmt.Sprintf("host=%s port=%s user=%s dbname=%s password=%s sslmode=disable", hostPort[0], hostPort[1], dbUser, dbName, dbPassword)
	default:
		return nil,fmt.Errorf("database type %s is not supported by felix ginrbo",dbType)
	}
	return gorm.Open(dbType,conn)
}