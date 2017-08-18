//
//  DownloadsModel.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 18/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


class DownloadsModel: NSObject {
    
    
    //Model Constants
    
    let kFileName = "title"
    let kFileID = "id"
    let kFileDescription = "description"
    let kFileSize = "file_size"
    let kFilePath = "file_path"
    let kFileExtension = "extension"
    
    //Model Objects
    
    var fileName = ""
    var fileID =  ""
    var fileDescription = ""
    var fileSize = ""
    var filePath = ""
    var fileExtension = ""
    
    //MARK: Initialisation
    
    
    
    override init() {
        
        
        
    }
    
    
    init(dict:[String:AnyObject]) {
        
        if dict[kFileName] != nil {
            fileName = "\(dict[kFileName]!)"
        }
        
        if dict[kFileID] != nil {
            fileID = "\(dict[kFileID]!)"
        }
        
        if dict[kFileDescription] != nil {
            fileDescription = "\(dict[kFileDescription]!)"
        }
        
        if dict[kFileSize] != nil {
            fileSize = "\(dict[kFileSize]!)"
        }
        
        if dict[kFilePath] != nil {
            filePath = "\(dict[kFilePath]!)"
        }
        
        if dict[kFileExtension] != nil {
            fileExtension = "\(dict[kFileExtension]!)"
        }
        
    }
    
    
}
