//
//  ViewController.swift
//  homelib
//
//  Created by Shalu Scaria on 2017-08-29.
//  Copyright © 2017 Shalu Scaria. All rights reserved.
//

import UIKit
import QuartzCore

class MainVC: UIViewController {
   

    @IBOutlet var mainvc_btn_login: UIButton!
    
    @IBOutlet var mainvc_btn_signup: UIButton!
    
    //Function for SignUp button click
    @IBAction func onClickSignUp(_ sender: Any) {
        
        self.performSegue(withIdentifier: "main_to_createaccount", sender: MainVC())
    }
    
    
    //Function for Login button click
    @IBAction func onClickLogIn(_ sender: Any) {
        
        self.performSegue(withIdentifier: "main_to_login", sender: MainVC())
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        
        //Customizing the Buttons
        mainvc_btn_login.backgroundColor = UIColor.clear
        mainvc_btn_login.layer.borderWidth = 1.0
        mainvc_btn_login.layer.borderColor = UIColor.untSeaweed.cgColor
        mainvc_btn_login.layer.cornerRadius = 5.0
        mainvc_btn_signup.layer.cornerRadius = 5.0
    
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   


}

