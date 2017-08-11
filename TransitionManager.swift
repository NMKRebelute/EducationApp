//
//  TransitionManager.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 11/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class TransitionManager {
    
    //MARK: Singleton
    
    static let shared:TransitionManager = {
        return TransitionManager()
    }()
    
    let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Show Login Screen
    
    func showLogin() {
        
        let loginVC = mainStoryBoard.instantiateViewController(withIdentifier: "LoginViewController")
        let navVC = UINavigationController(rootViewController: loginVC)
        
        appDelegate.window?.rootViewController = navVC
        appDelegate.window?.makeKeyAndVisible()
    }
    
    //MARK: Show Home screen
    func showHome() {
        
        let homeVC = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController")
        let navVC = UINavigationController(rootViewController: homeVC)
        
        appDelegate.window?.rootViewController = navVC
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    
}
