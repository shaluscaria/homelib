//
//  AddBookVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-02.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class AddBookVC: UIViewController {
    
    var passedBooks = Books()
    //var arrBook = [[String:AnyObject]]()
    //var bookDetails = [String : AnyObject]()
    var image_url = ""
    var bookToFetch : [NSManagedObject] = []
    var databaseHelper = DatabaseHelper()
   
   
    @IBOutlet var book_image: UIImageView!
    @IBOutlet var book_author: UITextField!
    @IBOutlet var book_title: UITextView!
    @IBOutlet var book_isbn: UITextField!
    @IBOutlet var view_addbook: UIView!
    @IBOutlet var otherinfo_text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        view.preservesSuperviewLayoutMargins = false
        self.showBookDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func onClickSave(_ sender: UIBarButtonItem) {
        
        if self.isBookAddedAlready(arr_books: databaseHelper.displayAllBooks(),isbnToAdd: book_isbn.text!){
            self.bookAlreadyAddedAlert()
        }
        else{
            
            let titleToSave = book_title.text!
            let imageToSave = image_url
            let authorToSave = book_author.text!
            let isbnToSave = book_isbn.text!
            let statusToSave = "Unread"
            let loanedtoSave = "None"
            let otherInfoToSave = otherinfo_text.text!
            
            databaseHelper.saveBooks(dm_title: titleToSave, dm_image: imageToSave, dm_author: authorToSave, dm_isbn: isbnToSave, dm_status: statusToSave, dm_loanedto: loanedtoSave,dm_otherinfo: otherInfoToSave)
            
            self.bookAddedAlert()
        }
        
    }
    
    
    
    
    
    func isBookAddedAlready(arr_books : [Books],isbnToAdd : String) -> Bool{
        
        for book in arr_books{
            if book.book_isbn == isbnToAdd {
                return true
            }
        }
        return false
    }
   
    
    
    //func raises alert when the book has been added successfully to MyBooks
    func bookAddedAlert(){
        let actionSheet = UIAlertController(title: "Book has been added Successfully", message: nil, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default, handler: nil)
        actionSheet.addAction(okButton)
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    //func Raises an alert if the book has already been added to MyBooks
    func bookAlreadyAddedAlert(){
        let actionSheet = UIAlertController(title: "Error", message: "You already have this item in My Books catalog", preferredStyle: .alert)
        
        let okButton = UIAlertAction(title: "Ok", style:.default, handler: nil)
        actionSheet.addAction(okButton)
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    func showBookDetails(){
        
        book_title.text = passedBooks.book_title
        book_author.text = passedBooks.book_author
        book_isbn.text = passedBooks.book_isbn
        otherinfo_text.text = passedBooks.other_informations
        //book_binding.text = passedBooks.book_binding
        
        let imageURL = URL(string: passedBooks.book_image)
        Alamofire.request(imageURL!).responseJSON {response in
            let imageData = response.data!
            let downloadImage = UIImage(data: imageData)
            if downloadImage == nil {
                 self.book_image.image = #imageLiteral(resourceName: "imagenotavailable")
                 self.image_url = "imagenotavailable"
            }
            else{
                DispatchQueue.main.async {
                    self.book_image.image = downloadImage
                    self.image_url = self.passedBooks.book_image
                }
            }
        }
        
    }

    

}
