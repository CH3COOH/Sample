//
//  ViewController.swift
//  SampleBlurEffect
//
//  Created by KENJI WADA on 2020/03/29.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private let imgOverlay: UIVisualEffectView = {
        let blur = UIBlurEffect(style: UIBlurEffect.Style.extraLight)
        let blurView = UIVisualEffectView(effect: blur)
        return blurView
    }()
    
    private let imageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 先にImageViewを配置する
        imageView.image = UIImage(named: "dummy_green")
        imageView.frame = CGRect(origin: CGPoint(x: 100, y: 100), size: CGSize(width: 200, height: 200))
        view.addSubview(imageView)
        
        // ImageViewに重なるようにEffectViewを配置する
        imgOverlay.frame = CGRect(origin: .zero, size: CGSize(width: 200, height: 200))
        view.addSubview(imgOverlay)
    }
}
