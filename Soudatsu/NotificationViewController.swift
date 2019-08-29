//
//  NotificationViewController.swift
//  Soudatsu
//
//  Created by USER on 2019/08/28.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

extension NotificationViewController : UITableViewDelegate {
    //cellがタップされたのを検知した時に実行する処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("タップ")
    }
    //セルの見積もりの高さを指定する処理
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    //セルの高さ指定をする処理
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NotificationViewController : UITableViewDataSource {
    //何個のcellを生成するかを設定する関数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    //描画するcellを設定する関数
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell") as! TweetTableViewCell
        cell.fill(tweet: tweets[indexPath.row])
        
        return cell
    }
}

class NotificationViewController : UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet var tableView: UITableView!
    
    //テーブル表示用のデータソース
    var tweets : [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ダミーデータの生成
        let user = User(id:"1", screenName: "chimiko", name: "ちみこ", profileImageURL: "https://pbs.twimg.com/profile_images/1092072777710940160/_sJgXoFc_400x400.jpg")
        let tweet = Tweet(id : "01", text:  "Twetterクライアント作成テスト", user: user)
        
        let tweets = [tweet]
        self.tweets = tweets
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //tableView.reloadData()
    }
    
    
    
    
    //プッシュ通知
    
    //通知を作成
    @IBAction func setNotification(_ sender : UIButton) {
        //タイトル、本文、サウンド設定の保持
        let content = UNMutableNotificationContent()
        content.title = "時間です"
        content.subtitle = "10秒経過しました"
        content.body = "タップしてアプリを開いてください"
        content.sound = UNNotificationSound.default
        
        //second後に起動するタイマーを保持
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        //識別子とともに通知の表示内容とトリガーをrequestに内包する
        let request = UNNotificationRequest(identifier: "Timer", content: content, trigger: trigger)
        //(identifier: "Timer", content: content, trigger: trigger)
        
        //UNUserNotificationCenterにrequestを加える
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.add(request) {
            (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }//END func setNotification
    
    func userNotificationCenter(_ center : UNUserNotificationCenter, willPresent willPresentnotification : UNNotification, withCompletionHandler completionHandler : @escaping(UNNotificationPresentationOptions) -> Void){
        completionHandler([.alert, .badge, .sound])
    }
}//END class NotificationViewController
