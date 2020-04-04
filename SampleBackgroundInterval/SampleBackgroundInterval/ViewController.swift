//
//  ViewController.swift
//  SampleBackgroundInterval
//
//  Created by KENJI WADA on 2020/03/29.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var bd: Date!
    var fd: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillEnterForeground(
            notification:)), name:UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewDidEnterBackground(
            notification:)), name:UIApplication.didEnterBackgroundNotification, object: nil)
    }

    // AppDelegate -> applicationWillEnterForegroundの通知
    @objc func viewWillEnterForeground(notification: Notification) {
        fd = Date()
        
        // 何秒経過したかラベルに表示する
        let diff = fd.timeIntervalSince(bd)
        print("\(diff)秒")
        label.text = "\(diff)秒"
    }
    
    // AppDelegate -> applicationDidEnterBackgroundの通知
    @objc func viewDidEnterBackground(notification: Notification) {
        bd = Date()
    }
}
