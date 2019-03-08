//
//  FirstToHomeSegue.swift
//  MyRoadMap
//
//  Created by 洪立德 on 2019/1/12.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit

class FirstToHomeSegue: UIStoryboardSegue {
    
    
    override func perform() {
        
        // 指定來源與目標視圖給區域變數
        var firstVCView = self.source.view as UIView!
        var secondVCView = self.destination.view as UIView!
        
        //  取得畫面寬度與高度 Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView!.frame = CGRect(x: 0.0, y: screenHeight, width: screenWidth, height: screenHeight)
        
        // 上 Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        
        // Animate the transition.
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            firstVCView!.frame = (firstVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeight))!
            secondVCView!.frame = (secondVCView?.frame.offsetBy(dx: 0.0, dy: -screenHeight))!
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,
                                animated: false,
                                completion: nil)
        }
        
    }

    

}
