//
//  DownloadsTableViewCell.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 18/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class DownloadsTableViewCell: UITableViewCell {

    @IBOutlet weak var formatLbl: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    @IBOutlet weak var fileNameLbl: UILabel!
    @IBOutlet weak var sizeLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
