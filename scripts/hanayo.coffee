# Description:
#   Execute 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Kentaro KAZUHAMA

# "かよちん"で出すフレーズ
phrases = [ 
    "みんなーっ！ご飯炊けたよっ♪"
    "ﾀﾞﾚｶﾀｽｹﾃｰ"
    "イ゛エ゛ニ゛カ゛エ゛ッチ゛ャッタ゛ノ゛？"
    "あ、はい..."
    "あ、すみません...私、余計なこと..."
    "こ、こんにちは..."
    "ご...ごめんなさい..."
    "でも、私...向いてないですから..."
    "この時期は美味しいものが多くて......危険です！"
    "おはようっ！"
]

child_process = require('child_process')

module.exports = (robot) ->

    # "kayochin date"でdateコマンドを実行
    robot.hear /^date$/i, (msg) ->
        child_process.exec "date", (error, stdout, stderr) ->
            msg.send(stdout)

    #"かよちん"フレーズをランダムで投げる
    robot.hear /^かよちん$/, (msg) ->
        msg.send msg.random phrases

    #指定チャネルの2h分の番組表
    robot.hear /^getpg$/i, (msg) ->
        for ch, x in ['GR_23608','GR_24632','GR_1056','GR_1048','GR_1072']
            target = process.env.CHINACHU_API_URL+"/schedule/#{ch}.json"
            request = require('request')
            request.get
                url: target, (err, response, body) ->
                    for val, i in JSON.parse(body)["programs"]
                        nowTime = Math.floor(new Date().getTime())
                        startTime = JSON.parse(body)["programs"][i]["start"]
                        if nowTime <= startTime && startTime  <= nowTime + (7200*1000)
                            date = new Date(JSON.parse(body)["programs"][i]["start"])
                            msg.send(JSON.parse(body)["name"]+":"+
                            date.getHours()+":"+date.getMinutes()+":"+
                            JSON.parse(body)["programs"][i]["title"]+
                            ":"+JSON.parse(body)["programs"][i]["id"])

    #プログラムIDを指定して録画する
    robot.hear /^setrec (.*)/i, (msg) ->
        target = process.env.CHINACHU_API_URL+"/program/#{msg.match[1]}.json"
        request = require('request')
        request.put
            url: target, (err, response, body) ->
                msg.send("予約しました＞＜")


