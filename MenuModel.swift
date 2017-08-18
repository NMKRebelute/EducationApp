//
//  MenuModel.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 14/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


class MenuModel: NSObject {
    
    
    // Model constants
    
    let kPageType = "page_type"
    let kPageName = "page_name"
    let kIcon = "icon"
    let kMenuName = "menu_name"
    let kFileNameEnglish = "file_name_english"
    let kFileNameArabic = "file_name_arabic"
    let kPageNameEnglish = "page_name_english"
    let kPageNameArabic = "page_name_arabic"
    let kSubMenu = "submenu"
    
    
    let kIsStatic = "isStatic"
    let kEnglishName = "englishName"
    let kArabicName = "arabicName"
    let kIconImage = "icon"
    
    // Model Objects
    
    var pageType = ""
    var pageName = ""
    var icon = ""
    var menuName = ""
    var fileNameEnglish = ""
    var fileNameArabic = ""
    var pageNameEnglish = ""
    var pageNameArabic = ""
    var submenu:[[String:AnyObject]] = []
    
    
    var isStatic = false
    var englishName = ""
    var arabicName = ""
    var iconImage = ""
    
    
    //MARK:  Initialisation
    
    
    override init() {
        
        
    }
    
    
    init(dict:[String:AnyObject]) {
       
        if let status = dict[kIsStatic] as? Bool {
            
            if status == true {
                
                isStatic = true
                
                if dict[kEnglishName] != nil {
                    englishName = "\(dict[kEnglishName]!)"
                }
                
                if dict[kArabicName] != nil {
                    arabicName = "\(dict[kArabicName]!)"
                }
                
                if dict[kIconImage] != nil {
                    iconImage = "\(dict[kIconImage]!)"
                }
                
                return
                
            }
        }
        
            
            isStatic = false
            
            if dict[kPageType] != nil {
                pageType = "\(dict[kPageType]!)"
            }
            
            if dict[kPageName] != nil {
                pageName = "\(dict[kPageName]!)"
            }
            
            if dict[kIcon] != nil {
                icon = "\(dict[kIcon]!)"
            }
            
            if dict[kMenuName] != nil {
                menuName = "\(dict[kMenuName]!)"
            }
            
            if dict[kFileNameEnglish] != nil {
                fileNameEnglish = "\(dict[kFileNameEnglish]!)"
            }
            
            if dict[kFileNameArabic] != nil {
                fileNameArabic = "\(dict[kFileNameArabic]!)"
            }
            
            if dict[kPageNameEnglish] != nil {
                pageNameEnglish = "\(dict[kPageNameEnglish]!)"
            }
            
            if dict[kPageNameArabic] != nil {
                pageNameArabic = "\(dict[kPageNameArabic]!)"
            }
            
            if let arr = dict[kSubMenu] as? [[String:AnyObject]] {
                submenu = arr
            }
            
        
       
    }
    
}
