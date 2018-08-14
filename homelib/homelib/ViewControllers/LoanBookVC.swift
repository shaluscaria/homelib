//
//  LoanBookVCViewController.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import Contacts

class LoanBookVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var passedBook = Books()
    var contacts = [CNContact]()
    var contactNames = [String]()
    let cnStore = CNContactStore()
 
   
    
    @IBOutlet var eneteredLoanedTo: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestAccess { (true) in
            self.contacts = self.getContacts()
        }
        contactNames = getContactName(arrayContacts: self.contacts)
    }
    
    
    @IBAction func returnBook(_ sender: UIButton) {
        passedBook.book_loanedto = "None"
        self.performSegue(withIdentifier: "loanedtobookdetails", sender: LoanBookVC())
    }
    
    
    @IBAction func loanBook(_ sender: UIButton) {
        passedBook.book_loanedto = eneteredLoanedTo.text!
        self.performSegue(withIdentifier: "loanedtobookdetails", sender: LoanBookVC())
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactListTVC
        cell.contactLabel.text = contactNames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        passedBook.book_loanedto = contactNames[indexPath.row]
        self.performSegue(withIdentifier: "loanedtobookdetails", sender: LoanBookVC())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loanedtobookdetails"{
                let  bookdetailsVC = segue.destination as!  BookDetailsVC
                bookdetailsVC.selectedBook = passedBook
        }
    }

    
    
    func requestAccess(completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        switch CNContactStore.authorizationStatus(for: .contacts) {
        case .authorized:
            completionHandler(true)
        case .denied:
            showSettingsAlert(completionHandler)
        case .restricted, .notDetermined:
            //CNContactStore.requestAccess(CNContactStore)
            self.cnStore.requestAccess(for: .contacts) { granted, error in
                if granted {
                    completionHandler(true)
                } else {
                    DispatchQueue.main.async {
                        self.showSettingsAlert(completionHandler)
                    }
                }
            }
        }
    }
    
    
    private func showSettingsAlert(_ completionHandler: @escaping (_ accessGranted: Bool) -> Void) {
        let alert = UIAlertController(title: nil, message: "This app requires access to Contacts to proceed. Would you like to open settings and grant permission to contacts?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Settings", style: .default) { action in
            completionHandler(false)
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { action in
            completionHandler(false)
        })
        present(alert, animated: true)
    }
    
    func getContacts() -> [CNContact] {
        
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        let request = CNContactFetchRequest(keysToFetch: keys)
        
        do {
            try self.cnStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                contacts.append(contact)
            }
        }
        catch {
            print("unable to fetch contacts")
        }
        debugPrint(contacts)
        return contacts
    }
    
    func getContactName(arrayContacts: [CNContact]) -> [String]{
        var arrayOfNames = [String]()
        for contact in arrayContacts{
            let fullname = contact.givenName + contact.familyName
            arrayOfNames.append(fullname)
        }
        return arrayOfNames
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
