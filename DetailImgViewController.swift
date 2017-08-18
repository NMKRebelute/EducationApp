//
//  DetailImgViewController.swift
//  EducationApp
//
//  Created by Paritosh Sharma on 17/08/17.
//  Copyright © 2017 Rebelute. All rights reserved.
//

import UIKit

class DetailImgViewController: UIViewController {

    
    @IBOutlet weak var fullImgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image:UIImage?
    
    var initialFrame = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let img = image {
            fullImgView.image = img
        }
        
        initialFrame = fullImgView.frame
        
        scrollView.isHidden = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.zoomImage))
        tap.numberOfTapsRequired = 2
        
        fullImgView.isUserInteractionEnabled = true
//        fullImgView.addGestureRecognizer(tap)
    }
    
    func zoomImage() {
        
        if scrollView.isHidden == true {
            
            fullImgView.frame = CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            
            scrollView.isHidden = false
            scrollView.addSubview(fullImgView)
            
        }else {
            
            fullImgView.removeFromSuperview()
            scrollView.isHidden = true
            
            fullImgView.frame = initialFrame
            fullImgView.image = image!
            view.addSubview(fullImgView)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    @IBAction func backBtnTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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


extension DetailImgViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return fullImgView
    }
    
}

