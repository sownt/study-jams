# Profile Validator for Android Study Jams

### What's new
 - Add support for #JuaraAndroid season 3

### How to use
 - Juara Android S3
   1. First, visit the website [https://juara.sownt.com](https://juara.sownt.com)
   2. Enter your profile url (or your username, userId)
   3. Press `ENTER` and get your result

### How it works
This project includes 3 software
 - Telegram Bot is developed using Golang (currently only supports #ChienBinhAndroid)
 - Web client is developed based on Flutter
 - Backend is developed using Golang

and this is the folder structure of this project
```
.
├── bot             // Telegram Bot
├── images
├── lib             // Flutter Web App
├── LICENSE
├── pubspec.lock
├── pubspec.yaml
├── README.md
├── server          // Gin RESTful APIs
├── site
├── test
└── web

8 directories, 7 files
```
Users will access the web client to fill in the path to their Google Developer Profile, and the data
will be pushed to the server. The backend software will parse the profile and check its validity 
with the specific requirements of each challenge, then return the results to the web client.

### Why do we need a backend server?
Currently, the web client is having problems with **CORS** and it cannot download your profile
directly. So I used the server to temporarily fix that problem.
