//
//  DownloadsViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 18/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class DownloadsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    
    var downloadsArray:[DownloadsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let cell = UINib(nibName: "DownloadsTableViewCell", bundle: nil)
        tblView.register(cell, forCellReuseIdentifier: "Cell")
        tblView.tableFooterView = UIView()
        tblView.estimatedRowHeight = 80
        tblView.rowHeight = UITableViewAutomaticDimension
        
        getDownloadsData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func getDownloadsData() {
        
        APIManager.shared.getDownloads(showLoader: true) { (errorMessage, modelArray) in
            
            if errorMessage != nil {
                
                CommonMethods.shared.showAlertWith(title: APPPLICATION_NAME, message: errorMessage!, sender: self, OKActionHandler: { 
                    self.dismiss(animated: true, completion: nil)
                })
                return
            }
            
            if modelArray != nil {
                self.downloadsArray = modelArray!
                self.tblView.reloadData()
            }
            
        }
        
    }
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        self.slideMenuController()?.openLeft()
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func downloadBtnTapped(sender:UIButton) {
        
        
        
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

extension DownloadsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloadsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblView.dequeueReusableCell(withIdentifier: "Cell") as! DownloadsTableViewCell
        
        cell.selectedBackgroundView = nil
        cell.formatLbl.layer.cornerRadius = 10
        cell.formatLbl.clipsToBounds = true
        
        cell.downloadBtn.tag = indexPath.row
        
        let model = downloadsArray[indexPath.row]
        
        cell.fileNameLbl.text = model.fileName
        
        cell.sizeLbl.text = model.fileSize
        
        if let fileSize = Int(model.fileSize){
            
            let sizeInKBs = fileSize/1000
            
            cell.sizeLbl.text = "\(sizeInKBs) KB"
            
        }
        
        cell.formatLbl.text = model.fileExtension
        
        cell.downloadBtn.addTarget(self, action: #selector(self.downloadBtnTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}
