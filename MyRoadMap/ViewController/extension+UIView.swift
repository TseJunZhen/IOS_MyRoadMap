//
//  extension+UIView.swift
//  MyRoadMap
//
//  Created by 洪立德 on 2019/1/15.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit

extension UIView {
    
    func getCorner(cornerItem: UIView, myCorner: CGFloat, cornerBG: UIColor){
        
        cornerItem.layer.cornerRadius = myCorner
        cornerItem.clipsToBounds = true
        cornerItem.backgroundColor = cornerBG
    }
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func flash(sender: UILabel, repeatIs: Float) {
        
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.5
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = repeatIs  // 2
        
        sender.layer.add(flash, forKey: "opacity")
        //        layer.add(flash, forKey: nil)
    }
    
    
    
}
