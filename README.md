# Goodfood
受 [g0v.tw](http://g0v.tw) 啟發，以「吃當季、吃在地、建立農人與消費者的連結」為出發的計畫。  
借[台灣好食協會](http://www.taiwangoodfood.org.tw/fishmap01.php)的資料，包裝成[好食API](http://goodfood.cades.tw)。

## Usage
這個專案用 caveman (common lisp 的 web framework) 寫成, 資料庫使用 mongodb.  

- 原始資料以json格式保存, 放在 `data/raw/` .
- mongodb 的匯出檔放在 `data/mongodb/` .  
- 網頁放在相關檔案放在 `template/` 和 `static/`.
- lisp 檔案放在 `src/`, 主要寫在 `src/controller.lisp`.

## Installation

###資料庫

```
# 安裝 mongodb. 請參閱 http://docs.mongodb.org/manual/installation/
# 如果您的作業系統是 OS X, 推薦用 homebrew 安裝:
brew update
brew install mongodb

# 更改 mongod.conf
fork = true
rest = true

# 啟動mongod. --fork 讓 mongod 在背景執行; --rest 啟用 Simple REST interface
# linux
sudo service mongod start  --rest --fork
# OS X
sudo mongod --rest --fork

# 匯入資料庫
mongoimport --db opendata --collection goodfood --file data/mongodb/goodfood.json

```

###caveman

```
# 請先確定你的系統已經裝好 sbcl 和 quicklisp

# get project source
git clone git@github.com:cades/goodfood.git

# 進入 lisp REPL. 也可以用emacs/slime。
sbcl

# 初次載入, quicklisp 會花點時間安裝相依套件
(load "/path/to/goodfood/goodfood.asd")
(ql:quickload :goodfood)
(goodfood:start)
```

現在好食API已經跑在 [http://localhost:5000](http://localhost:5000)

## 如何參與
歡迎在 github 上開 issue 或者發 pull request 給我:)  


## Licence
The MIT Licence
