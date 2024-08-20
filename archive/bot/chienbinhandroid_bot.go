package main

import (
	"encoding/json"
	"io"
	"log"
	"net/http"
	"strconv"
	"strings"
	"time"

	tgbotapi "github.com/go-telegram-bot-api/telegram-bot-api/v5"
)

type Profile struct {
	Id       string `json:"obfuscatedProfileId"`
	Username string `json:"vanityId"`
}

type BadgeResponse struct {
	CreateTime string `json:"createTime"`
	Title      string `json:"title"`
	PathwayUrl string `json:"pathwayUrl,omitempty"`
}

var (
	pathwayList = []string{
		"introduction to programming in kotlin", // "introduction to kotlin",
		"set up android studio",                 // "setup android studio",
		"build a basic layout",
		"kotlin fundamentals",
		"add a button to an app",
		"interacting with ui and state",
		"more kotlin fundamentals",
		"build a scrollable list",
		"add theme and animation", // "build beautiful apps",
		"architecture components",
		"navigation in jetpack compose",
		"adaptive layouts", // "adapt for different screen sizes",
		"get data from the internet",
		"load and display images from the internet",
		"introduction to sql",
		"use room for data persistence",
		"store and access data using keys with datastore",
		"schedule tasks with workmanager",
		"android views and compose in views",
		"views in compose",
		"compose essentials",
		"layouts, theming, and animation",
		"architecture and state",
		"accessibility, testing, and performance",
		"form factors",
	}

	// Menu texts
	firstMenu = "Bạn muốn kiểm tra Tier qua?"

	idButton   = "ID"
	userButton = "Username"

	githubRepo    = "Tặng sao cho repository của dự án này"
	githubProfile = "Theo dõi mình trên Github <3"
	result        = "Kết quả chi tiết"

	mode            = 0
	startDateString = "2023-07-14T00:00:00Z"
	endDateString   = "2023-08-12T23:59:59Z"

	bot *tgbotapi.BotAPI

	// Keyboard layout for the first menu. One button, one row
	firstMenuMarkup = tgbotapi.NewInlineKeyboardMarkup(
		tgbotapi.NewInlineKeyboardRow(
			tgbotapi.NewInlineKeyboardButtonData(idButton, idButton),
			tgbotapi.NewInlineKeyboardButtonData(userButton, userButton),
		),
	)

	seedingMarkup = tgbotapi.NewInlineKeyboardMarkup(
		tgbotapi.NewInlineKeyboardRow(
			tgbotapi.NewInlineKeyboardButtonURL(githubRepo, "https://github.com/sownt/android-studyjams"),
		),
		tgbotapi.NewInlineKeyboardRow(
			tgbotapi.NewInlineKeyboardButtonURL(githubProfile, "https://github.com/sownt"),
		),
	)
)

func main() {
	var err error

	// API key
	bot, err = tgbotapi.NewBotAPI("")
	if err != nil {
		// Abort if something is wrong
		log.Panic(err)
	}

	// Set this to true to log all interactions with telegram servers
	bot.Debug = false

	u := tgbotapi.NewUpdate(0)
	u.Timeout = 60

	// `updates` is a golang channel which receives telegram updates
	updates := bot.GetUpdatesChan(u)

	for {
		handleUpdate(<-updates)
	}

}

func handleUpdate(update tgbotapi.Update) {
	switch {
	// Handle messages
	case update.Message != nil:
		handleMessage(update.Message)
		break

	// Handle button clicks
	case update.CallbackQuery != nil:
		handleButton(update.CallbackQuery)
		break
	}
}

func handleMessage(message *tgbotapi.Message) {
	user := message.From
	text := message.Text

	if user == nil {
		return
	}

	var err error
	if strings.HasPrefix(text, "/") {
		err = handleCommand(*message, text)
	} else if mode != 0 {
		id := text
		sendMessage(user.ID, "Chờ chút nhé!")
		if mode == 2 {
			id = getProfile(text).Id
		}
		checkTier(user.ID, id, getAwards(id))
		mode = 0
	}

	if err != nil {
		log.Printf("An error occured: %s", err.Error())
	}
}

// When we get a command, we react accordingly
func handleCommand(message tgbotapi.Message, command string) error {
	var err error

	// Check if the command contains a mention
	if strings.Contains(command, "@") {
		// Split the command at the "@" symbol
		parts := strings.SplitN(command, "@", 2)
		command = parts[0]
	}

	switch command {
	case "/chienbinhandroid":
		err = sendMenu(message.From.ID)
		if err != nil {
			log.Println(err.Error())
		}
		break
	case "/start":
		err = sendMenu(message.Chat.ID)
		if err != nil {
			log.Println(err.Error())
		}
		break
	default:
		sendMessage(message.Chat.ID, "Command "+command+" không tồn tại!")
	}

	return err
}

func handleButton(query *tgbotapi.CallbackQuery) {
	var text string

	markup := tgbotapi.NewInlineKeyboardMarkup()
	message := query.Message

	if query.Data == idButton {
		msg := tgbotapi.NewMessage(query.From.ID, "Gửi cho mình ID của bạn nhé!")
		mode = 1
		_, err := bot.Send(msg)
		if err != nil {
			return
		}
	} else if query.Data == userButton {
		msg := tgbotapi.NewMessage(query.From.ID, "Gửi cho mình username của bạn nhé!")
		mode = 2
		_, err := bot.Send(msg)
		if err != nil {
			return
		}
	}

	callbackCfg := tgbotapi.NewCallback(query.ID, "")
	_, err := bot.Send(callbackCfg)
	if err != nil {
		return
	}

	// Replace menu text and keyboard
	msg := tgbotapi.NewEditMessageTextAndMarkup(message.Chat.ID, message.MessageID, text, markup)
	msg.ParseMode = tgbotapi.ModeHTML
	_, err = bot.Send(msg)
	if err != nil {
		return
	}
}

func checkTier(chatId int64, id string, badges []BadgeResponse) {
	var count = 0
	for _, element := range badges {
		if containsString(pathwayList, strings.ToLower(element.Title)) && IsDateInRange(element.CreateTime, startDateString, endDateString) {
			count++
		}
	}
	if count == 0 {
		viewResult(chatId, id, "Bắt đầu thôi! Bạn chưa có badge hợp lệ nào :(")
	} else if count > 0 && count < 12 {
		viewResult(chatId, id, "Cố gắng lên! Hiện tại số badge hợp lệ của bạn là "+strconv.Itoa(count)+" / 12 badges nên chưa đạt điều kiện nhận quà của #ChienBinhAndroid")
	} else if count < 20 {
		viewResult(chatId, id, "Chúc mừng! Bạn đã hoàn thành "+strconv.Itoa(count)+" / 12 badges đạt điều kiện để nhận quà Tier 1 của #ChienBinhAndroid rồi")
	} else {
		viewResult(chatId, id, "Tuyệt vời! Bạn đã hoàn thành "+strconv.Itoa(count)+" / 20 badges và đạt điều kiện để nhận quà Tier 2 của #ChienBinhAndroid rồi")
	}
	sendMessage(chatId, "Xin lưu ý rằng, kết quả từ ChienBinhAndroidBot chỉ mang tính chất tham khảo, quyết quyết định cuối cùng thuộc về BTC. Vì vậy mọi người kiên nhẫn đợi nhé!")
	seeding(chatId)
}

func sendMenu(chatId int64) error {
	msg := tgbotapi.NewMessage(chatId, firstMenu)
	msg.ParseMode = tgbotapi.ModeHTML
	msg.ReplyMarkup = firstMenuMarkup
	_, err := bot.Send(msg)
	return err
}

func viewResult(chatId int64, id string, m string) {
	msg := tgbotapi.NewMessage(chatId, m)
	msg.ParseMode = tgbotapi.ModeHTML
	msg.ReplyMarkup = tgbotapi.NewInlineKeyboardMarkup(
		tgbotapi.NewInlineKeyboardRow(
			tgbotapi.NewInlineKeyboardButtonURL(result, "https://chienbinhandroid.sownt.com/result/"+id),
		),
	)
	_, err := bot.Send(msg)
	if err != nil {
		return
	}
}

func seeding(chatId int64) {
	msg := tgbotapi.NewMessage(chatId, "Cảm ơn bạn đã ủng hộ tool của mình! Nếu thích dự án này, hãy ủng hộ mình bằng cách")
	msg.ParseMode = tgbotapi.ModeHTML
	msg.ReplyMarkup = seedingMarkup
	_, err := bot.Send(msg)
	if err != nil {
		return
	}
}

func containsString(list []string, target string) bool {
	for _, s := range list {
		if s == target {
			return true
		}
	}
	return false
}

func IsDateInRange(dateString, startDateString, endDateString string) bool {
	date, err := time.Parse(time.RFC3339, dateString)
	if err != nil {
		return false
	}

	startDate, err := time.Parse(time.RFC3339, startDateString)
	if err != nil {
		return false
	}

	endDate, err := time.Parse(time.RFC3339, endDateString)
	if err != nil {
		return false
	}

	return date.After(startDate) && date.Before(endDate)
}

func getAwards(profileId string) []BadgeResponse {
	var awards []BadgeResponse
	res := request(
		http.MethodGet,
		"https://api.sownt.com/awards?id="+profileId,
		nil,
	)

	if res.StatusCode != 200 {
		return []BadgeResponse{}
	}

	err := json.Unmarshal(getResponseBody(res), &awards)
	check(err)

	return awards
}

func getProfile(username string) Profile {
	var profile Profile
	res := request(
		http.MethodGet,
		"https://api.sownt.com/id?username="+username,
		nil,
	)

	if res.StatusCode != 200 {
		return Profile{}
	}

	err := json.Unmarshal(getResponseBody(res), &profile)
	check(err)

	return profile
}

func request(method string, url string, body io.Reader) *http.Response {
	req, err := http.NewRequest(
		method,
		url,
		body,
	)
	check(err)

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

func sendMessage(chatId int64, text string) {
	msg := tgbotapi.NewMessage(chatId, text)
	_, err := bot.Send(msg)
	if err != nil {
		log.Panic(err)
	}
}
