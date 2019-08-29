//
//  MenuViewController.swift
//  Soudatsu
//
//  Created by USER on 2019/08/21.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController : UIViewController {
    
    @IBOutlet var menuCloseButton: UIButton!
    @IBOutlet var menuView: UIImageView!
    @IBOutlet var inputButton: UIButton!
    @IBOutlet var statisticsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ボタン
        menuCloseButton.layer.borderColor = UIColor.black.cgColor
        menuCloseButton.layer.borderWidth = 1.0
        menuCloseButton.layer.cornerRadius = 10.0
        menuCloseButton.layer.masksToBounds = true
        
        inputButton.layer.borderColor = UIColor.black.cgColor
        inputButton.layer.cornerRadius = 10.0
        
        statisticsButton.layer.borderColor = UIColor.black.cgColor
        statisticsButton.layer.cornerRadius = 10.0
        
        //メニュービュー
        menuView.layer.borderWidth = 1
        menuView.layer.cornerRadius = 10
        menuView.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //メニュー外をタップした場合、閉じる
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        for touch : UITouch in touches {
            let tag = touch.view!.tag
            if tag == 1 {
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    //メニューを閉じる
    @IBAction func didMenuClose(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
