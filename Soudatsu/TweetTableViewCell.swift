//
//  TweetTableViewCell.swift
//  Soudatsu
//
//  Created by USER on 2019/08/29.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import Foundation
import UIKit

class TweetTableViewCell : UITableViewCell {
    
    //アイコンを表示するImage
    @IBOutlet var iconImageView: UIImageView!
    
    //名前を表示するLabel
    @IBOutlet var nameLabel: UILabel!
    
    //スクリーンネームを表示するLabel
    @IBOutlet var screenNameLabel: UILabel!
    
    //ツイート本文を表示するLabel
    @IBOutlet var textContentLabel: UILabel!
    
    func fill(tweet : Tweet) {
        //profileImageURLから画像をダウンロードしてくる処理
        let downloadTask = URLSession.shared.dataTask(with: URL(string: tweet.user.profileImageURL)!) {
            [weak self] data, response, error in
            if let error = error {
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                //iconImageViewにダウンロードしてきた画像に代入する処理
                self?.iconImageView.image = UIImage(data : data!)
            }
        }
        downloadTask.resume()
        
        //tweetから値を取り出して、UIにセットする
        nameLabel.text = tweet.user.name
        textContentLabel.text = tweet.text
        //screenNameには”＠”が含まれていないので、頭に”＠”を入れる必要がある
        screenNameLabel.text = "@" + tweet.user.screenName
        
    }//END func fill
}
