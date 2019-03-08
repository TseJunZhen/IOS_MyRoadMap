//
//  TabBarController.swift
//  MyRoadMap
//
//  Created by Tse Jun Zhen on 17/01/2019.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard(name: "Main", bundle: nil);
        let viewController: HomeTableViewController = storyboard.instantiateViewController(withIdentifier: "HomeTableViewController") as! HomeTableViewController;
        present(viewController, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
