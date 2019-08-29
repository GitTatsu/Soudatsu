//
//  ViewController.swift
//  Soudatsu
//
//  Created by USER on 2019/08/18.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import UIKit
import RealmSwift

class DataBase : Object {
    @objc dynamic var date : String?
    @objc dynamic var time : String?
    @objc dynamic var count : Int = 0
    @objc dynamic var map : String = ""
    @objc dynamic var score : Int = 0
    @objc dynamic var lap : Int = 0
}

class ViewController: UIViewController{
    
    //タイマーラベル
    @IBOutlet var timeLabel: UILabel!
    //テキストビュー
    @IBOutlet var textView: UITextView!
    //ボタン
    @IBOutlet var bossButton: UIButton!
    @IBOutlet var way3Button: UIButton!
    @IBOutlet var boss3Button: UIButton!
    @IBOutlet var way4Button: UIButton!
    @IBOutlet var escapeButton: UIButton!
    @IBOutlet var kuruButton: UIButton!
    @IBOutlet var hisekiButton: UIButton!
    @IBOutlet var leverButton: UIButton!
    @IBOutlet var ghostButton: UIButton!
    @IBOutlet var slotButton: UIButton!
    @IBOutlet var blackholeButton: UIButton!
    @IBOutlet var togeButton: UIButton!
    @IBOutlet var bereButton: UIButton!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var menuOpenButton: UIButton!
    
    //マップ名
    var mapName : String = ""
    var boss : Int = 0
    var way3 : Int = 0
    var boss3 : Int = 0
    var way4 : Int = 0
    var escape : Int = 0
    var kuru : Int = 0
    var hiseki : Int = 0
    var lever : Int = 0
    var ghost : Int = 0
    var slot : Int = 0
    var blackhole : Int = 0
    var toge : Int = 0
    var bere : Int = 0
    //マップカウント
    var mapCount : Int = 0
    @IBOutlet var mapCountLabel: UILabel!
    //スコアカウント
    var score : Int = 0
    var preScore : Int = 0
    @IBOutlet var scoreLabel: UILabel!
    //CT解除用
    @IBOutlet var bereTimeLabel: UILabel!
    @IBOutlet var slotTimeLabel: UILabel!
    //backボタンフラグ
    var backFlag : Bool = true
    //ラップ
    var lapTime : Int = 0
    
    override func viewDidLoad() {
        
        //Realm Browser 用のURL
        let realm = try! Realm()
        print(realm.configuration.fileURL!)
        
        super.viewDidLoad()
        //テキストビュー
        textView.isEditable = false
        textView.adjustsFontForContentSizeCategory = true
        //backボタンの無効化
        backButton.isEnabled = false
        
        //時計
        timeCheck()
        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeCheck), userInfo: nil, repeats: true)
        
        menuOpenButton.layer.borderColor = UIColor.black.cgColor
        menuOpenButton.layer.borderWidth = 1.0
        menuOpenButton.layer.cornerRadius = 10.0
        menuOpenButton.layer.masksToBounds = true
        
        bossButton.layer.borderColor = UIColor.black.cgColor
        bossButton.layer.borderWidth = 1.0
        bossButton.layer.cornerRadius = 10.0
        
        way3Button.layer.borderColor = UIColor.black.cgColor
        way3Button.layer.borderWidth = 1.0
        way3Button.layer.cornerRadius = 10.0
        
        boss3Button.layer.borderColor = UIColor.black.cgColor
        boss3Button.layer.borderWidth = 1.0
        boss3Button.layer.cornerRadius = 10.0
        
        way4Button.layer.borderColor = UIColor.black.cgColor
        way4Button.layer.borderWidth = 1.0
        way4Button.layer.cornerRadius = 10.0
        
        escapeButton.layer.borderColor = UIColor.black.cgColor
        escapeButton.layer.borderWidth = 1.0
        escapeButton.layer.cornerRadius = 10.0
        
        kuruButton.layer.borderColor = UIColor.black.cgColor
        kuruButton.layer.borderWidth = 1.0
        kuruButton.layer.cornerRadius = 10.0
        
        hisekiButton.layer.borderColor = UIColor.black.cgColor
        hisekiButton.layer.borderWidth = 1.0
        hisekiButton.layer.cornerRadius = 10.0
        
        leverButton.layer.borderColor = UIColor.black.cgColor
        leverButton.layer.borderWidth = 1.0
        leverButton.layer.cornerRadius = 10.0
        
        ghostButton.layer.borderColor = UIColor.black.cgColor
        ghostButton.layer.borderWidth = 1.0
        ghostButton.layer.cornerRadius = 10.0
        
        slotButton.layer.borderColor = UIColor.black.cgColor
        slotButton.layer.borderWidth = 1.0
        slotButton.layer.cornerRadius = 10.0
        
        blackholeButton.layer.borderColor = UIColor.black.cgColor
        blackholeButton.layer.borderWidth = 1.0
        blackholeButton.layer.cornerRadius = 10.0
        
        togeButton.layer.borderColor = UIColor.black.cgColor
        togeButton.layer.borderWidth = 1.0
        togeButton.layer.cornerRadius = 10.0
        
        bereButton.layer.borderColor = UIColor.black.cgColor
        bereButton.layer.borderWidth = 1.0
        bereButton.layer.cornerRadius = 10.0
        
        backButton.layer.borderColor = UIColor.black.cgColor
        backButton.layer.borderWidth = 1.0
        backButton.layer.cornerRadius = 10.0
    }//END viewDidLoad
    
    //メニュー表示
    @IBAction func didMenuButton(_ sender: Any) {
        performSegue(withIdentifier: "menu", sender: nil)
    }
    
    //時計
    @objc func timeCheck(){
        let date = Date()
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        let component = calender.dateComponents([
        .hour, .minute, .second], from: date as Date)
        
        let hour = String(format: "%02d", component.hour!)
        let minute = String(format: "%02d", component.minute!)
        let second = String(format: "%02d", component.second!)
        
        timeLabel.text = hour + ":" + minute + ":" + second
        
        lapTime += 1
    }//END timeCheck
    
    //スコア計算
    func scorePlus(mapName : String){
        if(mapName == "ベレ"){
            preScore = 1400
        }else{
            preScore = 100
        }
        //スコア加算
        score += preScore
        scoreLabel.text = String(score)
    }//END scorePlus
    
    //CT解除用
    func ctCancel(mapName : String){
        let date = Date()
        let calender = Calendar(identifier: Calendar.Identifier.gregorian)
        let component = calender.dateComponents([
            .hour, .minute, .second], from: date as Date)
        
        var hour = String(format: "%02d", component.hour!)
        var minute = String(format: "%02d", component.minute!)
        let second = String(format: "%02d", component.second!)
        
        var preIntMinute = Int(minute)! + 10
        //60分を超えたら
        if(preIntMinute >= 60){
            preIntMinute -= 60
            var preIntHour = Int(hour)! + 1
            //24時を超えたら
            if(preIntHour >= 24){
                preIntHour -= 24
            }
            hour = String(format: "%02d",preIntHour)
        }
        minute = String(format: "%02d", preIntMinute)
        //CT解除
        if(mapName == "ベレ"){
            bereTimeLabel.text = hour + ":" + minute + ":" + second
        }else if(mapName == "スロ"){
            slotTimeLabel.text = hour + ":" + minute + ":" + second
        }
    }//END ctCancel
    
    //テキストビューに追記
    func insertText(name : String, count : Int) -> Int{
        //Realmインスタンス生成
        let realm = try! Realm()
        //ラップタイム初期化
        if(mapCount == 0){
            lapTime = 0
        }
        //マップカウント＋１
        mapCount = mapCount + 1
        //マップ数ラベル記載
        mapCountLabel.text = String(mapCount)
        //加算スコア
        if(name == "ベレ"){
            preScore = 1400
        }else{
            preScore = 100
        }
        //日付の取得
        let nowDate = DateFormatter()
        nowDate.dateStyle = .medium
        nowDate.timeZone = .none
        nowDate.locale = Locale(identifier: "ja_JP")
        let now = Date()
        
        //テキストビューに追記
        if(mapCount == 1 || backFlag == true){
            backFlag = false
            backButton.isEnabled = true
            textView.insertText(mapCountLabel.text! + ". " + name + " " + timeLabel.text!)
        }else{
            //ラップだけアップデート
            let lapUpdate = realm.objects(DataBase.self).filter("date == %@ && count == %@",nowDate.string(from:now),mapCount - 1).first
            try! realm.write{
                lapUpdate?.lap = lapTime
            }
            textView.insertText(" (" + String(lapTime) + "秒)" + "\n" + mapCountLabel.text! + ". " + name + " " + timeLabel.text!)
            lapTime = 0
        }
        //スコアプラス
        scorePlus(mapName:name)
        //CT解除用
        if(name == "ベレ" || name == "スロ"){
            ctCancel(mapName:name)
        }
        //一番下にスクロール
        let range = NSMakeRange(textView.text.count - 1, 0)
        textView.scrollRangeToVisible(range)
        
        //データベースへ登録するデータの作成
        let db = DataBase()
        db.date = nowDate.string(from:now)
        db.time = timeLabel.text!
        db.count = mapCount
        db.map = name
        db.score = preScore
        db.lap = 10000
        //データベースへの書き込み(インサート)
        try! realm.write{
            realm.add(db)
        }
        
        return mapCount
    }//END insertText
    
    //ボタンアクション
    
    @IBAction func backButtonAction(_ sender: Any) {
        if(mapCount > 0){
            backFlag = true
            backButton.isEnabled = false
            //マップカウント−１
            mapCount = mapCount - 1
            //マップ数ラベル記載
            mapCountLabel.text = String(mapCount)
            //テキストビューを変数に格納
            let text = textView.text
            //text変数を改行で分割
            var textArray = text?.components(separatedBy: .newlines)
            //カーソルのある行のテキストの取得
            let allText = textView.text as NSString
            let currentLine = allText.substring(with: allText.lineRange(for: textView.selectedRange))
            //最終行の文字列によって処理変更
            if(currentLine.contains("ボス")){
                boss -= 1
                score -= 100
                bossButton.setTitle(mapName + "(" + String(boss) + ")", for: .normal)
            }else if(currentLine.contains("３方")){
                way3 -= 1
                score -= 100
                way3Button.setTitle(mapName + "(" + String(way3) + ")", for: .normal)
            }else if(currentLine.contains("３ボ")){
                boss3 -= 1
                score -= 100
                boss3Button.setTitle(mapName + "(" + String(boss3) + ")", for: .normal)
            }else if(currentLine.contains("４方")){
                way4 -= 1
                score -= 100
                way4Button.setTitle(mapName + "(" + String(way4) + ")", for: .normal)
            }else if(currentLine.contains("脱出")){
                escape -= 1
                score -= 100
                escapeButton.setTitle(mapName + "(" + String(escape) + ")", for: .normal)
            }else if(currentLine.contains("くる")){
                kuru -= 1
                score -= 100
                kuruButton.setTitle(mapName + "(" + String(kuru) + ")", for: .normal)
            }else if(currentLine.contains("碑石")){
                hiseki -= 1
                score -= 100
                hisekiButton.setTitle(mapName + "(" + String(hiseki) + ")", for: .normal)
            }else if(currentLine.contains("レバ")){
                lever -= 1
                score -= 100
                leverButton.setTitle(mapName + "(" + String(lever) + ")", for: .normal)
            }else if(currentLine.contains("幽霊")){
                ghost -= 1
                score -= 100
                ghostButton.setTitle(mapName + "(" + String(ghost) + ")", for: .normal)
            }else if(currentLine.contains("スロ")){
                slot -= 1
                score -= 100
                slotButton.setTitle(mapName + "(" + String(slot) + ")", for: .normal)
            }else if(currentLine.contains("ブラ")){
                blackhole -= 1
                score -= 100
                blackholeButton.setTitle(mapName + "(" + String(blackhole) + ")", for: .normal)
            }else if(currentLine.contains("トゲ")){
                toge -= 1
                score -= 100
                togeButton.setTitle(mapName + "(" + String(toge) + ")", for: .normal)
            }else if(currentLine.contains("ベレ")){
                bere -= 1
                score -= 1400
                bereButton.setTitle(mapName + "(" + String(bere) + ")", for: .normal)
            }
            
            //スコア減算
            scoreLabel.text = String(score)
            //最終行の改行を削除
            textArray?.removeLast()
            //改行で結合
            let newText = textArray?.joined(separator: "\n")
            //テキストビューに表示
            textView.text = newText
            //改行を追記
            textView.insertText("\n")
            
            //日付の取得
            let nowDate = DateFormatter()
            nowDate.dateStyle = .medium
            nowDate.timeZone = .none
            nowDate.locale = Locale(identifier: "ja_JP")
            let now = Date()
            
            //データベースから削除する
            let realm = try! Realm()
            let DBdelete = realm.objects(DataBase.self).filter("date == %@ && count == %@",nowDate.string(from:now),mapCount + 1)
            try! realm.write{
                realm.delete(DBdelete)
            }
        }
    }
    
    @IBAction func bossButtonAction(_ sender: Any) {
        mapName = "ボス"
        boss += 1
        bossButton.setTitle(mapName + "(" + String(boss) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    
    @IBAction func way3ButtonAction(_ sender: Any) {
        mapName = "３方"
        way3 += 1
        way3Button.setTitle(mapName + "(" + String(way3) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func boss3ButtonAction(_ sender: Any) {
        mapName = "３ボ"
        boss3 += 1
        boss3Button.setTitle(mapName + "(" + String(boss3) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func way4ButtonAction(_ sender: Any) {
        mapName = "４方"
        way4 += 1
        way4Button.setTitle(mapName + "(" + String(way4) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func escapeButtonAction(_ sender: Any) {
        mapName = "脱出"
        escape += 1
        escapeButton.setTitle(mapName + "(" + String(escape) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func kuruButtonAction(_ sender: Any) {
        mapName = "くる"
        kuru += 1
        kuruButton.setTitle(mapName + "(" + String(kuru) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func hisekiButtonAction(_ sender: Any) {
        mapName = "碑石"
        hiseki += 1
        hisekiButton.setTitle(mapName + "(" + String(hiseki) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func leverButtonAction(_ sender: Any) {
        mapName = "レバ"
        lever += 1
        leverButton.setTitle(mapName + "(" + String(lever) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func ghostButtonAction(_ sender: Any) {
        mapName = "幽霊"
        ghost += 1
        ghostButton.setTitle(mapName + "(" + String(ghost) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func slotButtonAction(_ sender: Any) {
        mapName = "スロ"
        slot += 1
        slotButton.setTitle(mapName + "(" + String(slot) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func blackholeButtonAction(_ sender: Any) {
        mapName = "ブラ"
        blackhole += 1
        blackholeButton.setTitle(mapName + "(" + String(blackhole) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func togeButtonAction(_ sender: Any) {
        mapName = "トゲ"
        toge += 1
        togeButton.setTitle(mapName + "(" + String(toge) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    @IBAction func bereButtonAction(_ sender: Any) {
        mapName = "ベレ"
        bere += 1
        bereButton.setTitle(mapName + "(" + String(bere) + ")", for: .normal)
        mapCount = insertText(name: mapName, count: mapCount)
    }
    
    
}//END class ViewController
