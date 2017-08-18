//
//  HomeCollectionViewCell.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 14/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bgImgView: UIImageView!
    @IBOutlet weak var transParentView: UIView!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var headingLbl: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
