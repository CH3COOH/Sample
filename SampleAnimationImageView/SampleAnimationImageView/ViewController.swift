//
//  ViewController.swift
//  SampleAnimationImageView
//
//  Created by KENJI WADA on 2020/03/29.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView1.isHidden = false
        imageView2.isHidden = false
        imageView1.transform = .identity
        imageView2.transform = .identity
    }

    @IBAction func buttonAction(_ sender: Any) {
        
        imageView1.isHidden = false
        imageView1.alpha = 1
        imageView1.transform = .identity
        
        let option1: UIView.AnimationOptions = .curveEaseIn
        UIView.animate(withDuration: 0.4, delay: 0, options: [ option1 ], animations: { [weak self] in
            self?.imageView1.alpha = 0
            self?.imageView1.transform = .init(translationX: 0, y: 200)
        }, completion: { [weak self] (_) in
            self?.imageView1.isHidden = true
        })
        
        imageView2.isHidden = false
        imageView2.alpha = 1
        imageView2.transform = .identity
        
        let option2: UIView.AnimationOptions = .curveEaseIn
        UIView.animate(withDuration: 0.4, delay: 0, options: [ option2 ], animations: { [weak self] in
            self?.imageView2.alpha = 0
            self?.imageView2.transform = .init(translationX: 0, y: -200)
        }, completion: { [weak self] (_) in
            self?.imageView2.isHidden = true
        })
    }
}
