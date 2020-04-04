//
//  ViewController.swift
//  SampleOpenCVHistgram
//
//  Created by KENJI WADA on 2020/04/03.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let iamge = UIImage(named: "dummy_green")!
        OpenCVWrapper.makeHistgram(from: iamge)
    }
}

