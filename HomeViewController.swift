//
//  HomeViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 11/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var contentScrlVw: UIScrollView!
    @IBOutlet weak var clctnVw: UICollectionView!
    @IBOutlet weak var webVw: UIWebView!
    
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    var selectedLanguageCode = "17"
    var bannersArray:[[String:AnyObject]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLbl.font = EAFonts.titleLblFont()
        
        let cell = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        clctnVw.register(cell, forCellWithReuseIdentifier: "Cell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.languageChanged), name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
//        let url = URL(string: "http://emirate.rebelutedigital.com/html/1502464856403480033.html")
//        let request = URLRequest(url: url!)
//        webVw.loadRequest(request)
        
    }
    
    func languageChanged() {
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }
        
        getHomeScreenData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }
        
        getHomeScreenData()
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
            }else {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                UserDefaults.standard.set("eng", forKey: STORED_LANGUAGE)
                selectedLanguageCode = "17"
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            selectedLanguageCode = "17"
        }
        
        //        getHomeScreenData()
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
    }
    
    func getHomeScreenData() {
        
        let params:[String:Any] = ["lang_id":selectedLanguageCode]
        
        APIManager.shared.getHomeScreenDataWith(parameters: params, showLoader: true) { (errorMessage, responseDict) in
            
             self.languageBtn.isUserInteractionEnabled = true
            
            if errorMessage != nil {
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                
               
                self.changeCurrentLanguageAndNotify()
                
                return
            }
            
            if responseDict != nil {
                
                if let dataDict = responseDict?[API_DATA] as? [String:AnyObject] {
                    
                    if let dataDict1 = dataDict[API_DATA] as? [String:AnyObject] {
                        
                        if let URLString = dataDict1["file_name"] as? String {
                            
                            if let url = URL(string: URLString) {
                                
                                if let pageName = dataDict1["page_name"] as? String {
                                    self.titleLbl.text = pageName
                                }
                                
                                let request = URLRequest(url: url)
                                self.webVw.loadRequest(request)
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
                
                if let arr = responseDict?["banner_images"] as? [[String:AnyObject]] {
                    
                    self.bannersArray = arr
                    self.clctnVw.reloadData()
                    
                }
                
                
            }
            
        }
        
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

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = clctnVw.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! HomeCollectionViewCell
        
        cell.transParentView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        cell.pageControl.numberOfPages = bannersArray.count
        cell.pageControl.currentPage = indexPath.row
        
        let dict = bannersArray[indexPath.row]
        
        if let imgStr = dict["image"] as? String {
            
            let imgURLString = IMAGE_SERVICE_URL + imgStr
            
            CommonMethods.shared.setImageTo(imgView: cell.bgImgView, with: imgURLString, placeHolderImg: DEFAULT_BG_IMAGE!)
            
        }
        
        if let imgTitle = dict["image_title"] as? String {
            cell.headingLbl.text = imgTitle
        }
        
        if let descriptionStr = dict["description"] as? String {
            cell.contentLbl.text = descriptionStr
        }
        
        return cell
        
    }
    
}


extension HomeViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        CommonMethods.shared.showLoaderWith(title: "Please wait")
    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        CommonMethods.shared.hideLoader()
        
        var frame = webView.frame
        frame.size.height = 1
        
        webVw.frame = frame
        
        let fittingSize = webVw.sizeThatFits(CGSize(width: 0, height: 0))
        frame.size = fittingSize
        
        webVw.frame = frame
        
        contentViewHeight.constant = clctnVw.frame.size.height + webVw.frame.size.height + 20
        
    }
    
}

