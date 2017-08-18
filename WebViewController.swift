//
//  WebViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 17/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    var selectedLanguageCode = "17"
    var englishTitle = ""
    var arabicTitle = ""
    var englishURLString = ""
    var arabicURLString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
                
        titleLbl.font = EAFonts.titleLblFont()
        
         NotificationCenter.default.addObserver(self, selector: #selector(self.languageChanged), name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
                titleLbl.text = englishTitle
                
                if let englishURL = URL(string: englishURLString) {
                    let request = URLRequest(url: englishURL)
                    webView.loadRequest(request)
                }
                
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
                titleLbl.text = arabicTitle
                
                if let arabicURL = URL(string: arabicURLString) {
                    let request = URLRequest(url: arabicURL)
                    webView.loadRequest(request)
                }
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    
    @IBAction func languageBtnTapped(_ sender: Any) {
        
        languageBtn.isUserInteractionEnabled = false
        
        changeCurrentLanguageAndNotify()
    }
    
    func changeCurrentLanguageAndNotify() {
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                UserDefaults.standard.set("arb", forKey: STORED_LANGUAGE)
                selectedLanguageCode = "4"
                titleLbl.text = arabicTitle
                
                if let arabicURL = URL(string: arabicURLString) {
                    let request = URLRequest(url: arabicURL)
                    webView.loadRequest(request)
                }
                
            }else {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                UserDefaults.standard.set("eng", forKey: STORED_LANGUAGE)
                selectedLanguageCode = "17"
                titleLbl.text = englishTitle
                
                if let englishURL = URL(string: englishURLString) {
                    let request = URLRequest(url: englishURL)
                    webView.loadRequest(request)
                }
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            selectedLanguageCode = "17"
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
    }

    func languageChanged() {
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
                
                titleLbl.text = englishTitle
                
                if let englishURL = URL(string: englishURLString) {
                    let request = URLRequest(url: englishURL)
                    webView.loadRequest(request)
                }
                
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
                
                titleLbl.text = arabicTitle
                
                if let arabicURL = URL(string: arabicURLString) {
                    let request = URLRequest(url: arabicURL)
                    webView.loadRequest(request)
                }
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }
        
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
