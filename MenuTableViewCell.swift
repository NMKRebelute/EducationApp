//
//  MenuTableViewCell.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 14/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit
import ExpyTableView

class MenuTableViewCell: UITableViewCell, ExpyTableViewHeaderCell {

    @IBOutlet weak var menuImgView: UIImageView!
    @IBOutlet weak var menuLbl: UILabel!
    @IBOutlet weak var subMenuBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func changeState(_ state: ExpyState, cellReuseStatus cellReuse: Bool) {
        
        switch state {
        case .willExpand:
            print("WILL EXPAND")
            hideSeparator()
            arrowDown(animated: !cellReuse)
            
        case .willCollapse:
            print("WILL COLLAPSE")
            arrowRight(animated: !cellReuse)
            
        case .didExpand:
            print("DID EXPAND")
            
        case .didCollapse:
            showSeparator()
            print("DID COLLAPSE")
        }
    }

    private func arrowDown(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) { [weak self] _ in
            self?.subMenuBtn.transform = CGAffineTransform(rotationAngle: (CGFloat.pi / 2))
        }
    }
    
    private func arrowRight(animated: Bool) {
        UIView.animate(withDuration: (animated ? 0.3 : 0)) { [weak self] _ in
            self?.subMenuBtn.transform = CGAffineTransform(rotationAngle: 0)
        }
    }
    
    func showSeparator() {
        DispatchQueue.main.async { [weak self] _ in
            self?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }

    func hideSeparator() {
        DispatchQueue.main.async { [weak self] in
            self?.separatorInset = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.size.width, bottom: 0, right: 0)
        }
    }
    
}
