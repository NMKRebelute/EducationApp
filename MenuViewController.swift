//
//  MenuViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 14/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit
import ExpyTableView
import SlideMenuControllerSwift

class MenuViewController: UIViewController {

    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var fullNameLbl: UILabel!
    @IBOutlet weak var tblView: ExpyTableView!
    
    var menuArray:[MenuModel] = []
    var selectedLanguageCode = "17"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cell = UINib(nibName: "MenuTableViewCell", bundle: nil)
        tblView.register(cell, forCellReuseIdentifier: "Cell")
        
        if let emailID = UserDefaults.standard.value(forKey: STORED_EMAIL) as? String {
            emailLbl.text = emailID
        }
        
        var fullName = ""
        
        if let firstName = UserDefaults.standard.value(forKey: STORED_FIRSTNAME) as? String {
            fullName = fullName + firstName
        }
        
        if let lastName = UserDefaults.standard.value(forKey: STORED_LASTNAME) as? String {
            fullName = fullName + " " + lastName
        }
        
        fullNameLbl.text = fullName
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.languageChanged), name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
        getMenuData()
    }
    
    func languageChanged() {
        
//        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
//            
//            if lang == "eng" {
//                selectedLanguageCode = "17"
//            }else {
//                selectedLanguageCode = "4"
//            }
//            
//        }
//        
//        tblView.reloadData()
        
        getMenuData()
    }
    
    func getMenuData()  {
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                selectedLanguageCode = "17"
            }else {
                selectedLanguageCode = "4"
            }
            
        }
        
        let params:[String:Any] = ["lang_id":selectedLanguageCode]
        
        APIManager.shared.getMenuDataWith(parameters: params, showLoader: true) { (errorMessage, modelArray) in
            
            if errorMessage != nil {
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            if modelArray != nil {
                self.menuArray = modelArray!
                self.addAdditionalMenudata()
//                self.tblView.reloadData()
            }
            
        }
    }
    
    func addAdditionalMenudata() {
        
        let calendarDict:[String:AnyObject] = ["isStatic":true as AnyObject, "englishName":"Calendar" as AnyObject, "arabicName":"التقويم" as AnyObject, "icon":"calendar" as AnyObject]
        
        let calendarModel = MenuModel(dict: calendarDict)
        
        menuArray.append(calendarModel)
        
        let notificationDict:[String:AnyObject] = ["isStatic":true as AnyObject, "englishName":"Notification" as AnyObject, "arabicName":"إعلام" as AnyObject, "icon":"notification" as AnyObject]
        
        let notificationModel = MenuModel(dict: notificationDict)
        
        menuArray.append(notificationModel)
        
        let downloadDict:[String:AnyObject] = ["isStatic":true as AnyObject, "englishName":"Download" as AnyObject, "arabicName":"تحميل" as AnyObject, "icon":"download" as AnyObject]
        
        let downloadModel = MenuModel(dict: downloadDict)
        
        menuArray.append(downloadModel)
        
        let logOutDict:[String:AnyObject] = ["isStatic":true as AnyObject, "englishName":"LogOut" as AnyObject, "arabicName":"الخروج" as AnyObject, "icon":"logOut" as AnyObject]
        
        let logOutModel = MenuModel(dict: logOutDict)
        
        menuArray.append(logOutModel)
        
        self.tblView.reloadData()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension MenuViewController: ExpyTableViewDataSource, ExpyTableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = menuArray[section]
        if model.isStatic == true {
            return 1
        }
        return model.submenu.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func expandableCell(forSection section: Int, inTableView tableView: ExpyTableView) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTableViewCell
        
        let model = menuArray[section]
        
        cell.menuLbl.font = EAFonts.menuLblFont()
        
        
        
        if model.isStatic == true {
            
            cell.menuImgView.image = UIImage(named: model.iconImage)
            
            if selectedLanguageCode == "17" {
                cell.menuLbl.text = model.englishName
            }else {
                cell.menuLbl.text = model.arabicName
            }
            
        }else {
            
            CommonMethods.shared.setImageTo(imgView: cell.menuImgView, with: model.icon, placeHolderImg: DEFAULT_MENU_IMAGE!)
            
            if model.menuName == "Other" || model.menuName == "آخر" {
                cell.menuLbl.text = model.pageName
            }else {
                cell.menuLbl.text = model.menuName
            }
        }
        
//        cell.menuLbl.text = model.pageNameEnglish
//        
//        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
//            
//            if lang == "arb" {
//                cell.menuLbl.text = model.pageNameArabic
//            }
//            
//        }
        
        if model.submenu.count > 0 {
            cell.subMenuBtn.isHidden = false
        }else {
            cell.subMenuBtn.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = menuArray[indexPath.section]
        
        let dict = model.submenu[indexPath.row - 1]
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "SubCell")
        
        if let name = dict[model.kPageName] as? String {
            cell.textLabel?.text = name
        }
        
        return cell
        
    }
    
    func canExpand(section: Int, inTableView tableView: ExpyTableView) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        
        let model = menuArray[indexPath.section]
        
        if model.isStatic == true {
            
            // STatic Menu which added by us additionaly
            
            switch model.englishName {
                
            case "Calendar":
                
                //Show Calendar
                print("Calendar")
                
            case "Notification":
                
                //Show Notifications
                print("Notification")
                
            case "Download":

                //Show Downloads
                
                let downloadVC = mainStoryBoard.instantiateViewController(withIdentifier: "DownloadsViewController") as! DownloadsViewController
                let navVC = UINavigationController(rootViewController: downloadVC)
                
                let menuVC = mainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController")
                
                let slideMenuVC = SlideMenuController(mainViewController: navVC, leftMenuViewController: menuVC)
                
                appDelegate.window?.rootViewController = slideMenuVC
                appDelegate.window?.makeKeyAndVisible()
                
            case "LogOut":
                
                //LogOut the User
                
                CommonMethods.shared.logOutTheUser()
            
            default:
                break
            }
            return
            
        }else {
            
            
            //Dynamic menu which is coming from server
            
            if model.submenu.count > 0 {
                
                //Expandable Menu
                print("expandable")
                
                //Check the selected cell is the cell to be expand or cell from expanded menu
                if indexPath.row > 0 {
                    
                    //Cell from expanded menu selected
                    // Show the respective link in WebViewController
                    
                    let subMenuArray = model.submenu
                    
                    if let dict = subMenuArray[indexPath.row - 1] as? [String:AnyObject] {
                        
                        let model = MenuModel(dict: dict)
                        
                        let pageTitleEnglish = model.pageNameEnglish
                        let pageTitleArabic = model.pageNameArabic
                        let fileURLEnglish = model.fileNameEnglish
                        let fileURLArabic = model.fileNameArabic
                        
                        let webVC = mainStoryBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                        
                        webVC.englishTitle = pageTitleEnglish
                        webVC.arabicTitle = pageTitleArabic
                        webVC.englishURLString = fileURLEnglish
                        webVC.arabicURLString = fileURLArabic
                        
                        let navVC = UINavigationController(rootViewController: webVC)
                        
                        let menuVC = mainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController")
                        
                        let slideMenuVC = SlideMenuController(mainViewController: navVC, leftMenuViewController: menuVC)
                        
                        appDelegate.window?.rootViewController = slideMenuVC
                        appDelegate.window?.makeKeyAndVisible()
                    }
                    
                }
                
                return
            }
            
            let pageTitleEnglish = model.pageNameEnglish
            let pageTitleArabic = model.pageNameArabic
            let fileURLEnglish = model.fileNameEnglish
            let fileURLArabic = model.fileNameArabic
            
            // Check For Home menu
            if model.pageType == "2" {
                
                TransitionManager.shared.showHome()
                return
            }
            
            //Check for Gallery Menu
            if model.pageType == "4" {
                
                let galleryVC = mainStoryBoard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
                
                galleryVC.englishTitle = pageTitleEnglish
                galleryVC.arabicTitle = pageTitleArabic
                
                let navVC = UINavigationController(rootViewController: galleryVC)
                
                let menuVC = mainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController")
                
                let slideMenuVC = SlideMenuController(mainViewController: navVC, leftMenuViewController: menuVC)
                
                appDelegate.window?.rootViewController = slideMenuVC
                appDelegate.window?.makeKeyAndVisible()
                
                return
            }
            
            // Show remaining dynamic menu in WebViewController
            
            let webVC = mainStoryBoard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
            
            webVC.englishTitle = pageTitleEnglish
            webVC.arabicTitle = pageTitleArabic
            webVC.englishURLString = fileURLEnglish
            webVC.arabicURLString = fileURLArabic
            
            let navVC = UINavigationController(rootViewController: webVC)
            
            let menuVC = mainStoryBoard.instantiateViewController(withIdentifier: "MenuViewController")
            
            let slideMenuVC = SlideMenuController(mainViewController: navVC, leftMenuViewController: menuVC)
            
            appDelegate.window?.rootViewController = slideMenuVC
            appDelegate.window?.makeKeyAndVisible()
        }
        
//        TransitionManager.shared.showHome()
        
    }
    
}


