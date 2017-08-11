//
//  HomeViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 11/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func log(_ sender: Any) {
        
        UserDefaults.standard.setValue(nil, forKey: STORED_USERID)
        UserDefaults.standard.setValue(nil, forKey: STORED_USERNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_FIRSTNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_LASTNAME)
        UserDefaults.standard.setValue(nil, forKey: STORED_EMAIL)
        UserDefaults.standard.setValue(nil, forKey: STORED_MOBILE)
        
        TransitionManager.shared.showLogin()
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
