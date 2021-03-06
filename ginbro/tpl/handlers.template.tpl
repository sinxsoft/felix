package handlers

import (
	"{{.ProjectPackage}}/models"
	"github.com/gin-gonic/gin"
)

func init() {
	groupApi.GET("{{.ResourceName}}",{{if .IsAuthTable}}jwtMiddleware,{{end}} {{.HandlerName}}All)
	{{if .HasId}}groupApi.GET("{{.ResourceName}}/:id", {{if .IsAuthTable}}jwtMiddleware,{{end}} {{.HandlerName}}One){{end}}
	groupApi.POST("{{.ResourceName}}", {{if .IsAuthTable}}jwtMiddleware,{{end}} {{.HandlerName}}Create)
	groupApi.PATCH("{{.ResourceName}}", {{if .IsAuthTable}}jwtMiddleware,{{end}} {{.HandlerName}}Update)
	{{if .HasId}}groupApi.DELETE("{{.ResourceName}}/:id", {{if .IsAuthTable}}jwtMiddleware,{{end}} {{.HandlerName}}Delete){{end}}
}
//All
func {{.HandlerName}}All(c *gin.Context) {
	mdl := models.{{.ModelName}}{}
	query := &models.PaginationQuery{}
	err := c.ShouldBindQuery(query)
	if handleError(c, err) {
		return
	}
	list, total, err := mdl.All(query)
	if handleError(c, err) {
		return
	}
	jsonPagination(c, list, total, query)
}
{{if .HasId}}
//One
func {{.HandlerName}}One(c *gin.Context) {
	var mdl models.{{.ModelName}}
	id, err := parseParamID(c)
	if handleError(c, err) {
		return
	}
	mdl.Id = id
	data, err := mdl.One()
	if handleError(c, err) {
		return
	}
	jsonData(c, data)
}
{{end}}
//Create
func {{.HandlerName}}Create(c *gin.Context) {
	var mdl models.{{.ModelName}}
	err := c.ShouldBind(&mdl)
	if handleError(c, err) {
		return
	}
	err = mdl.Create()
	if handleError(c, err) {
		return
	}
	jsonData(c, mdl)
}
//Update
func {{.HandlerName}}Update(c *gin.Context) {
	var mdl models.{{.ModelName}}
	err := c.ShouldBind(&mdl)
	if handleError(c, err) {
		return
	}
	err = mdl.Update()
	if handleError(c, err) {
		return
	}
	jsonSuccess(c)
}
{{if .HasId}}
//Delete
func {{.HandlerName}}Delete(c *gin.Context) {
	var mdl models.{{.ModelName}}
	id, err := parseParamID(c)
	if handleError(c, err) {
		return
	}
	mdl.Id = id
	err = mdl.Delete()
	if handleError(c, err) {
		return
	}
	jsonSuccess(c)
}
{{end}}