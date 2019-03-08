//
//  TimeDetailCell.swift
//  MyRoadMap
//
//  Created by 洪立德 on 2019/1/15.
//  Copyright © 2019 洪立德. All rights reserved.
//

import UIKit

class TimeDetailCell: UITableViewCell {

    @IBOutlet weak var monthLb: UILabel!
    @IBOutlet weak var abilityLb: UILabel!
    @IBOutlet var abilityImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
