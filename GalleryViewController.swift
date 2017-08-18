//
//  GalleryViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 17/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var languageBtn: UIButton!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    
    var englishTitle = ""
    var arabicTitle = ""
    var selectedLanguageCode = "17"
    var headerHeading = "My Gallery"
    var headerDescription = "Our school events"
    var imagesArray:[GalleryModel] = []
    
    var selectedImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLbl.font = EAFonts.titleLblFont()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.languageChanged), name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
        let cell = UINib(nibName: "GalleryCollectionViewCell", bundle: nil)
        galleryCollectionView.register(cell, forCellWithReuseIdentifier: "Cell")
        
        let header = UINib(nibName: "GalleryTopView", bundle: nil)
        galleryCollectionView.register(header, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header")
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
                titleLbl.text = englishTitle
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
                titleLbl.text = arabicTitle
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }

        getGallerydata()
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
            }else {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                UserDefaults.standard.set("eng", forKey: STORED_LANGUAGE)
                selectedLanguageCode = "17"
                titleLbl.text = englishTitle
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            selectedLanguageCode = "17"
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: LANGUAGE_CHANGE_NOTIFICATION_NAME), object: nil)
        
        view.bringSubview(toFront: languageBtn)
    }
    
    func languageChanged() {
        
        if let lang = UserDefaults.standard.value(forKey: STORED_LANGUAGE) as? String {
            
            if lang == "eng" {
                languageBtn.setImage(UIImage(named:"eng"), for: .normal)
                selectedLanguageCode = "17"
                titleLbl.text = englishTitle
            }else {
                languageBtn.setImage(UIImage(named:"arb"), for: .normal)
                selectedLanguageCode = "4"
                titleLbl.text = arabicTitle
            }
            
        }else {
            
            languageBtn.setImage(UIImage(named:"eng"), for: .normal)
            UserDefaults.standard.setValue("eng", forKey: STORED_LANGUAGE)
        }
        
        getGallerydata()
        
    }
    
    func getGallerydata() {
        
        galleryCollectionView.isHidden = true
        
        let params:[String:Any] = ["lang_id":selectedLanguageCode]
        
        APIManager.shared.getGalleryDataWith(parameters: params, showLoader: true) { (errorMessage, dataDict, modelArray) in
            
            if errorMessage != nil {
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            
            
            if dataDict != nil {
                
                if let pageName = dataDict?["page_name"] as? String {
                    self.headerHeading = pageName
                }
                
                if let description = dataDict?["description"] as? String {
                    
                    self.headerDescription = CommonMethods.shared.convertHTMLToText(text: description)
                }
                
            }
            
            if modelArray != nil {
                
                self.arrangeData(modelArray: modelArray!)
                self.galleryCollectionView.reloadData()
                self.galleryCollectionView.isHidden = false
                
            }
            
        }
        
    }
    
    
    func arrangeData(modelArray:[GalleryModel]) {
        
        var copyarray = modelArray
        var finalArray:[GalleryModel] = []
        
        for index in 0...copyarray.count - 1 {
            
            let model = copyarray[index]
            
            if model.isMain == "1" {
                finalArray.append(model)
                copyarray.remove(at: index)
            }
            
        }
        
        imagesArray = finalArray + copyarray
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "fullImg" {
            
            let destVC = segue.destination as! DetailImgViewController
            destVC.image = selectedImage
            
        }
    }
   

}

extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            
            let width = collectionView.frame.size.width
            let height = width * 0.75
            
            return CGSize(width: width, height: height)
            
        }else {
            
            let width = collectionView.frame.size.width/2
            
            return CGSize(width: width - 5, height: width * 1.2)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GalleryCollectionViewCell
        
        let model = imagesArray[indexPath.row]
        
        let imgURLPart = model.imageURLPart
        let totalImgURL = IMAGE_SERVICE_URL + imgURLPart
        
        CommonMethods.shared.setImageTo(imgView: cell.imgView, with: totalImgURL, placeHolderImg: DEFAULT_BG_IMAGE!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width, height: 135)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionHeader {
            
            let headerView = galleryCollectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath) as! GalleryTopView
            
            headerView.headingLbl.text = headerHeading
            headerView.descriptionLbl.text = headerDescription
            
            return headerView
        }
        
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = galleryCollectionView.cellForItem(at: indexPath) as! GalleryCollectionViewCell
        
        selectedImage = cell.imgView.image
        
        performSegue(withIdentifier: "fullImg", sender: self)
    }
    
}
