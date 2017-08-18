//
//  EAFonts.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 16/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


class EAFonts: UIFont {
    
    
    
    static func menuLblFont() -> UIFont {
        
        let screenBounds = UIScreen.main.bounds
        
        switch screenBounds.size.width {
        case 320:
            return UIFont.systemFont(ofSize: 15.0)
        case 375:
            return UIFont.systemFont(ofSize: 16.0)
        case 414:
            return UIFont.systemFont(ofSize: 17.0)
        default:
            return UIFont.systemFont(ofSize: 18.0)
        }
        
    }
    
    static func titleLblFont() -> UIFont {
        
        let screenBounds = UIScreen.main.bounds
        
        switch screenBounds.size.width {
        case 320:
            return UIFont.boldSystemFont(ofSize: 16.0)
        case 375:
            return UIFont.boldSystemFont(ofSize: 17.0)
        case 414:
            return UIFont.boldSystemFont(ofSize: 18.0)
        default:
            return UIFont.boldSystemFont(ofSize: 18.0)
        }
        
    }
    
}
