//
//  ViewController.swift
//  SampleTouchEventCancel
//
//  Created by KENJI WADA on 2020/03/29.
//  Copyright © 2020 ch3cooh.jp. All rights reserved.
//

import UIKit

final class View: UIView {
    
    var touched: Bool = false
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        touched = true
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard touched else { return }

        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let previousLocation = touch.previousLocation(in: self)
        let draggedDistanceX = location.x - previousLocation.x
        let draggedDistanceY = location.y - previousLocation.y
        var newFrame = frame
        newFrame.origin.x += draggedDistanceX
        newFrame.origin.y += draggedDistanceY
        frame = newFrame
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        touched = false
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        touched = false
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var touchView: View!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 5秒後にタッチをドラッグを強制的にキャンセルする
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) { [weak self] in
            self?.hoge()
        }
    }
    
    private func hoge() {
        label.text = "called hoge."
        
        resignFirstResponder()
        touchView.touchesEnded([UITouch()], with: UIEvent())
    }
}
