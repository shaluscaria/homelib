//
//  FeedbackVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-15.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackVC: UIViewController,MFMailComposeViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendEmail() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["shalu.scaria3@gmail.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            //self.mailNotSent()
            print("can't send mail")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    
    func mailNotSent(){
        let actionSheet = UIAlertController(title: "Mail cannot be send", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default, handler: nil)
        actionSheet.addAction(okButton)
        present(actionSheet, animated: true, completion: nil)
        
    }

}
