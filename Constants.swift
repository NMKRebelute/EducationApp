//
//  Constants.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

//MARK: Networking API'S


let SERVICE_URL = "http://emirate.rebelutedigital.com/"

//API'S

let IMAGE_SERVICE_URL = SERVICE_URL + "uploads/cms/"
let Get_Splash_Screen_API = SERVICE_URL + "ws-get-splashscreen-page"
let Login_User_API = SERVICE_URL + "ws-user-login"
let Register_User_API = SERVICE_URL + "ws-user-register"


//MARK: Data Constants

let API_STATUS = "status"
let API_ERROR_MESSAGE = "msg"
let API_DATA = "data"

let PAGE_NAME = "page_name"
let DESCRIPTION = "description"
let BG_IMAGE = "background_image"
let LOGO_IMAGE = "image"

let USER_DETAILS = "user_details"

//MARK:Storage Constants

let STORED_LANGUAGE_ID = "storedLanguage"
let STORED_BG_IMAGE = "storedBgImg"
let STORED_LOGO_IMAGE = "storedLogoImg"

let STORED_USERID = "userID"
let STORED_FIRSTNAME = "firstName"
let STORED_LASTNAME = "lastName"
let STORED_USERNAME = "userName"
let STORED_EMAIL = "emailID"
let STORED_MOBILE = "mobile"


//MARK: Default Images

let DEFAULT_BG_IMAGE = UIImage(named: "bgImg")
