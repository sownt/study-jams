package model

import (
	"encoding/json"
	"errors"
	"github.com/gin-gonic/gin"
	"io"
	"api.sownt.com/m/constant"
	"net/http"
	"os"
	"path/filepath"
	"time"
)

type ProfileWrapper struct {
	Profile Profile `json:"profile"`
}

type Profile struct {
	Id       string `json:"obfuscatedProfileId"`
	Username string `json:"vanityId"`
}

type BadgeResponse struct {
	CreateTime string `json:"createTime"`
	Title      string `json:"title"`
	PathwayUrl string `json:"pathwayUrl,omitempty"`
}

type Awards struct {
	Awards []Award `json:"awards"`
}

type Award struct {
	Badge      Badge  `json:"badge"`
	CreateTime string `json:"createTime"`
	Title      string `json:"title"`
}

type Badge struct {
	AwardedBy []Course `json:"awardedBy"`
}

type Course struct {
	Url string `json:"url"`
}

func GetId(c *gin.Context) {
	username := c.Query("username")

	if username == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "username parameter is missing"})
		return
	}

	var profile ProfileWrapper
	res := getProfile(username, constant.ApiKey)

	if res.StatusCode != 200 {
		c.JSON(res.StatusCode, gin.H{"error": "get profile failed"})
		return
	}

	err := json.Unmarshal(getResponseBody(res), &profile)
	check(err)

	c.JSON(http.StatusOK, profile.Profile)
}

func GetAwards(c *gin.Context) {
	id := c.Query("id")

	if id == "" {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id parameter is missing"})
		return
	}

	var awards Awards
	res := getAwards(id, constant.ApiKey)

	if res.StatusCode != 200 {
		c.JSON(res.StatusCode, gin.H{"error": "get awards failed"})
		return
	}

	err := json.Unmarshal(getResponseBody(res), &awards)
	check(err)

	c.JSON(http.StatusOK, transform(awards))
}

func getProfile(username string, apiKey string) *http.Response {
	log(username)
	return request(
		http.MethodGet,
		constant.ProfileEndpoint+"?vanityId="+username+"&key="+apiKey,
		nil,
	)
}

func getAwards(profileId string, apiKey string) *http.Response {
	return request(
		http.MethodGet,
		constant.AwardsEndpoint+"?obfuscatedProfileId="+profileId+"&key="+apiKey,
		nil,
	)
}

func transform(awards Awards) []BadgeResponse {
	var br []BadgeResponse

	for i := range awards.Awards {
		var pathway string
		if len(awards.Awards[i].Badge.AwardedBy) != 0 {
			pathway = awards.Awards[i].Badge.AwardedBy[0].Url
		} else {
			pathway = ""
		}
		br = append(br, BadgeResponse{
			CreateTime: awards.Awards[i].CreateTime,
			Title:      awards.Awards[i].Title,
			PathwayUrl: pathway,
		})
	}

	return br
}

func request(method string, url string, body io.Reader) *http.Response {
	req, err := http.NewRequest(
		method,
		url,
		body,
	)
	check(err)

	req.Header.Set("Referer", "https://developers.google.com/")

	res, err := http.DefaultClient.Do(req)
	check(err)

	return res
}

func getResponseBody(res *http.Response) []byte {
	resData, err := io.ReadAll(res.Body)
	check(err)

	return resData
}

func check(err error) {
	if err != nil {
		panic(err)
	}
}

func log(username string) {
	dist := constant.StaticDir + "/" + "history.log"

	if _, err := os.Stat(dist); errors.Is(err, os.ErrNotExist) {
		err := os.MkdirAll(filepath.Dir(dist), 0755)
		check(err)
	}

	f, err := os.OpenFile(dist, os.O_APPEND|os.O_WRONLY|os.O_CREATE, 0600)
	check(err)
	defer f.Close()
	if _, err = f.WriteString(time.Now().Format(time.RFC3339) + " " + username + "\n"); err != nil {
		panic(err)
	}
}
