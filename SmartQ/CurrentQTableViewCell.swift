//
//  CurrentQTableViewCell.swift
//  SmartQ
//
//  Created by Worayut Traiworadecha on 1/7/2558 BE.
//  Copyright (c) 2558 BlueSeed. All rights reserved.
//

import UIKit

class CurrentQTableViewCell: UITableViewCell {

    @IBOutlet weak var labelTableType: UILabel!
    @IBOutlet weak var labelCurrentQ: UILabel!
    @IBOutlet weak var labelNoOfWaiting: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
