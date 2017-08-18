//
//  Constants.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 10/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit


//MARK: App Name

let APPPLICATION_NAME = "EducationApp"


//MARK: Networking API'S


let SERVICE_URL = "http://emirate.rebelutedigital.com/"

//API'S

let IMAGE_SERVICE_URL = SERVICE_URL + "uploads/cms/"
let Get_Splash_Screen_API = SERVICE_URL + "ws-get-splashscreen-page"
let Login_User_API = SERVICE_URL + "ws-user-login"
let Register_User_API = SERVICE_URL + "ws-user-register"
let Social_Login_API = SERVICE_URL + "ws-social-registration"
let Get_HomeScreen_API = SERVICE_URL + "ws-get-home-page"
let Get_Menu_API = SERVICE_URL + "ws-get-menu-list"
let Get_Gallery_API = SERVICE_URL + "ws-get-gallery-page"
let Get_Downloads_API = SERVICE_URL + "ws-all-upload-file"
let Forget_Password_API = SERVICE_URL + "ws-forgot-password"


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

let STORED_LANGUAGE = "language"


//MARK: Default Images

let DEFAULT_BG_IMAGE = UIImage(named: "bgImg")
let DEFAULT_MENU_IMAGE = UIImage(named: "default_menu_img")


//MARK: Notification Names

let LANGUAGE_CHANGE_NOTIFICATION_NAME = "languageChangeNotification"

