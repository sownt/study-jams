package main

import (
	"github.com/gin-contrib/cache"
	"github.com/gin-contrib/cache/persistence"
	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
	"api.sownt.com/m/model"
	"time"
)

func main() {
	gin.SetMode(gin.ReleaseMode)

	config := cors.DefaultConfig()
	config.AllowOrigins = []string{"*"}
	config.AllowMethods = []string{"GET"}
	store := persistence.NewInMemoryStore(time.Second)

	r := gin.Default()
	r.Use(cors.New(config))
	r.MaxMultipartMemory = 8 << 20

	r.GET("/id", cache.CachePage(store, time.Hour*24, model.GetId))
	r.GET("/awards", cache.CachePage(store, time.Minute, model.GetAwards))

	err := r.Run(":8080")
	if err != nil {
		return
	}
}
