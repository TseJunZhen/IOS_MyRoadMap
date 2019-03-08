//
//  TimelineCell.swift
//  MyRoadMap
//
//  Created by Tse Jun Zhen on 12/01/2019.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    
    @IBOutlet weak var textFieldYear: UITextField!
    @IBOutlet weak var skillButtonView: UIButton!
    
    func setSkill(skill: Skill) {
        
//        skillImageLine.image = skill.skillImage
        textFieldYear.text = skill.skillYear
        textFieldYear.backgroundColor = UIColor.white
        textFieldYear.borderStyle = UITextField.BorderStyle.none
        
        skillButtonView.setBackgroundImage(skill.skillImage, for: .normal)
//        skillButtonView.setTitle(skill.skillYear, for: .normal)
    }
    
}
