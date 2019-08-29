//
//  Popup.swift
//  
//
//  Created by USER on 2019/08/26.
//

import Foundation
import UIKit
import RealmSwift

class PopupViewController : UIViewController {
    
    @IBOutlet var okButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var popupview: UIImageView!
    
    var sendText : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        okButton.layer.borderColor = UIColor.black.cgColor
        okButton.layer.cornerRadius = 10.0
        cancelButton.layer.borderColor = UIColor.black.cgColor
        cancelButton.layer.cornerRadius = 10.0
        
        //ポップアップビュー
        popupview.layer.borderWidth = 1
        popupview.layer.cornerRadius = 10
        popupview.layer.masksToBounds = true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //okボタンアクション
    @IBAction func okButtonAction(_ sender: Any) {
         //realmファイルのパス
         let Path = NSHomeDirectory() + "/Documents"
         let filePath = NSURL(fileURLWithPath: Path + "/default.realm")
         //Realmインスタンス生成
         let realm = try! Realm(fileURL: filePath as URL)
         //日付で抽出
         let dayArray = realm.objects(DataBase.self).filter("date == %@ ", sendText)
         //デリート分
         try! realm.write{
            realm.delete(dayArray)
         }
    }
    
    //ポップアップ外をタップした場合、閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch : UITouch in touches {
            let tag = touch.view!.tag
            if tag == 1 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    //キャンセルボタン
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
