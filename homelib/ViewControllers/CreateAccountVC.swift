//
//  CreateAccountVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2017-08-29.
//  Copyright © 2017 Shalu Scaria. All rights reserved.
//

import UIKit
import CoreData

class CreateAccountVC: UIViewController {
    
   // var users :[NSManagedObject] = []

    @IBOutlet var txt_name: UITextField!
    
    @IBOutlet var txt_password: UITextField!
    @IBOutlet var txt_username: UITextField!
    @IBOutlet var createvc_btn_signupfb: UIButton!
    
    @IBOutlet var createvc_btn_createaccount: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customizing buttons in the view
        createvc_btn_signupfb.layer.cornerRadius = 5.0
        createvc_btn_createaccount.layer.cornerRadius = 5.0
        //navigationController?.isNavigationBarHidden = false
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    //on click action on CREATE ACCOUNT button
    @IBAction func accountCreate(_ sender: UIButton) {
        
        let nameToSave = txt_name.text!
        let usernameToSave = txt_username.text!
        let passwordToSave = txt_password.text!
        
        self.save(dm_name:nameToSave,dm_username : usernameToSave, dm_password : passwordToSave )
        
        self.performSegue(withIdentifier: "createaccounttologin", sender: CreateAccountVC())
        
        
    }
    
    
    @IBAction func fbSignIn(_ sender: UIButton) {
    }
    
    
    
    
    
    func save(dm_name:String,dm_username:String,dm_password:String){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "User",
                                       in: managedContext)!
        
        let users = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        users.setValue(dm_name, forKeyPath: "name")
        users.setValue(dm_username, forKeyPath: "user_name")
        users.setValue(dm_password, forKeyPath: "password")
        
        // 4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    
        
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
