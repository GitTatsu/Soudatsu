//
//  StartViewController.swift
//  Soudatsu
//
//  Created by USER on 2019/08/27.
//  Copyright © 2019 SwiftProject. All rights reserved.
//

import Foundation
import UIKit

class StartViewController : UIViewController {
    
    @IBOutlet var startButton: UIButton!
    
    var timer : Timer = Timer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    
    
    //点滅アニメーション
    func startAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: [.allowUserInteraction, .repeat, .autoreverse], animations: {
            
            self.startButton.alpha = 0.02
            
        }, completion: nil)
    }
    
    //スタートボタン
    @IBAction func startButtonAction(_ sender: Any) {
        startAnimation()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(changeView), userInfo: nil, repeats: false)
    }
    
    //画面遷移
    @objc func changeView() {
        performSegue(withIdentifier: "tapStart", sender: nil)
    }
}//END class StartViewController
