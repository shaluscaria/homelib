//
//  SignUpVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2017-08-29.
//  Copyright © 2017 Shalu Scaria. All rights reserved.
//

import UIKit
import CoreData
class LoginVC: UIViewController {
    
    
    //Referencing from the storyboard
    @IBOutlet var loginvc_btn_fblogin: UIButton!
    @IBOutlet var loginvc_btn_login: UIButton!
    @IBOutlet var loginvc_txt_username: UITextField!
    @IBOutlet var loginvc_txt_password: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.isNavigationBarHidden = false
        navigationController?.isNavigationBarHidden = false
        //customizing the buttons
        loginvc_btn_login.layer.cornerRadius = 5.0
        loginvc_btn_fblogin.layer.cornerRadius = 5.0
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Onclick action for Login
    @IBAction func onClickLogin(_ sender: Any) {
        
        let entered_username = loginvc_txt_username.text
        let entered_password = loginvc_txt_password.text
        var users : [NSManagedObject] = []
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "User")
        
        //3
        do {
             users = try managedContext.fetch(fetchRequest)
            
            for obj in  users {
                if ((obj as! User).user_name == entered_username && (obj as! User).password == entered_password){
                    
                    UserDefaults.standard.set((obj as! User).user_name , forKey:"userId");
                    UserDefaults.standard.synchronize();
                    
                    //print("Login successful \((obj as! User).user_name)")
                    
                    self.performSegue(withIdentifier: "LoginToMybooks", sender:LoginVC() )
                    
                }
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
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
