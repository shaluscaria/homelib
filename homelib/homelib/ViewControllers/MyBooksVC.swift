//
//  MyBooksVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-01-29.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import QuartzCore
import Alamofire
import SwiftyJSON
import CoreData


class MyBooksVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var enteredISBN : String = ""
    var objBooks = Books()
    var bookDetails = [String : String]()
    var bookToFetch : [NSManagedObject] = []
    var arrayOfBooks = [Books()]
    var databaseHelper = DatabaseHelper()
    var search_active = false
    var filteredArray = [Books]()
    
    @IBOutlet var mybooksTableView: UITableView!
    
    
    @IBAction func addBooks(_ sender: Any) {
        showActionSheet()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.hidesBackButton = true
        arrayOfBooks.removeAll()
        arrayOfBooks = self.sortBooks(arr_books: databaseHelper.displayAllBooks())
        self.mybooksTableView.rowHeight = 180
        self.mybooksTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search_active {
            return self.filteredArray.count
        }
        else{
            return self.arrayOfBooks.count
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if search_active {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookDisplayCustomCell
            cell.bookDetails_title.text = filteredArray[indexPath.row].book_title
            cell.bookDetails_author.text = "by " + filteredArray[indexPath.row].book_author
            
            if filteredArray[indexPath.row].book_image == "imagenotavailable" || filteredArray[indexPath.row].book_image == "" {
                cell.bookDetails_image.image = #imageLiteral(resourceName: "imagenotavailable")
            }
                
            else {
                let imageURL = URL(string: filteredArray[indexPath.row].book_image)
                Alamofire.request(imageURL!).responseJSON {response in
                    let imageData = response.data!
                    let downloadImage = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.bookDetails_image.image = downloadImage
                    }
                }
            }
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as! BookDisplayCustomCell
            cell.bookDetails_title.text = arrayOfBooks[indexPath.row].book_title
            cell.bookDetails_author.text = "by " + arrayOfBooks[indexPath.row].book_author
            
            if arrayOfBooks[indexPath.row].book_image == "imagenotavailable" || arrayOfBooks[indexPath.row].book_image == "" {
                cell.bookDetails_image.image = #imageLiteral(resourceName: "imagenotavailable")
            }
                
            else {
                let imageURL = URL(string: arrayOfBooks[indexPath.row].book_image)
                Alamofire.request(imageURL!).responseJSON {response in
                    let imageData = response.data!
                    let downloadImage = UIImage(data: imageData)
                    DispatchQueue.main.async {
                        cell.bookDetails_image.image = downloadImage
                    }
                }
            }
            return cell
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            let managedContext = appDelegate.persistentContainer.viewContext
                
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
                
            do {
                bookToFetch =  try managedContext.fetch(fetchRequest)
                    
                for obj in  bookToFetch {
                    
                    if arrayOfBooks[indexPath.row].book_title == (obj as! Book).title{
                        arrayOfBooks.remove(at: indexPath.row)
                        managedContext.delete(obj)
                        break
                    }
                }
            try managedContext.save()
            mybooksTableView.reloadData()
            }
            catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
        }
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if search_active{
            objBooks = filteredArray[indexPath.row]
        }
        else{
             objBooks = arrayOfBooks[indexPath.row]
        }
       
        self.performSegue(withIdentifier: "mybooktobookdetails", sender: MyBooksVC())
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text!.isEmpty {
            search_active = false
            
        }
        else {
            
            search_active = true
            filteredArray.removeAll()
            
            
            for val in arrayOfBooks {
                
                let book_title_lowercase = val.book_title.lowercased()
                if (book_title_lowercase.range(of: searchText.lowercased()) != nil){
                    filteredArray.append(val)
                }
                
                let book_author_lowercase = val.book_author.lowercased()
                if (book_author_lowercase.range(of: searchText.lowercased()) != nil){
                    filteredArray.append(val)
                }
            }
        }
        
        mybooksTableView.reloadData()
    }
    
    
    //displaying action sheet with multiple options to add book
    func showActionSheet(){
        let actionSheet = UIAlertController(title: "Add Book", message: nil, preferredStyle: .actionSheet)
        let scanISBN = UIAlertAction(title: "Scan ISBN", style: .default) { action in
            self.performSegue(withIdentifier: "mybooktoscanisbn", sender: MyBooksVC())
        }
        let addManually = UIAlertAction(title: "Add Manually", style: .default) { action in
            self.addISBNManually()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(scanISBN)
        actionSheet.addAction(addManually)
        actionSheet.addAction(cancel)
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    
    //function to obtain isbn from user
    func addISBNManually(){
        let alertAddISBN = UIAlertController(title:"Enter the books ISBN:", message: nil, preferredStyle: .alert)

        alertAddISBN.addTextField { (textField) in
            textField.placeholder = "ISBN"
            textField.keyboardType = UIKeyboardType.numbersAndPunctuation
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style:.cancel, handler:nil)
        
        let actionOk = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
             self.enteredISBN = alertAddISBN.textFields![0].text!
            let isbn = (self.enteredISBN as NSString).integerValue
            
            if isbn.digitCount == 13 {
                print("enetered isbn:" , self.enteredISBN)
                //calling function to obtain book details to obtain book details from isbndb
                getBookDetails(isbn: self.enteredISBN, completion: { (returnedBook) in
                    self.objBooks =  returnedBook
                })
                
                //delaying the main thread until async api call is returned
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                    
                    //validating entered isbn and taking appropriate actions
                    if (self.objBooks.book_isbn.isEmpty){
                        self.isbnNotRegistered()
                    }
                    else{
                        self.performSegue(withIdentifier: "mybookToaddbook", sender: MyBooksVC())
                    }
                })
            }
                
            else{
                
                 self.validISBNCheck(passedISBN: self.enteredISBN)
            }
            
        }
        
        alertAddISBN.addAction(actionCancel)
        alertAddISBN.addAction(actionOk)
        self.present(alertAddISBN, animated: true, completion: nil)
    }

    //func to raise an alert until valid isbn is entered
    func validISBNCheck(passedISBN : String){
        print("call to validISBNcheck")
        let passedISBNCheck = (passedISBN as NSString).integerValue
        
        print("passed value \(passedISBNCheck)")
        if passedISBNCheck.digitCount == 13 {
            
            //calling function to obtain book details from isbndb
            getBookDetails(isbn: passedISBN, completion: { (returnedBook) in
                self.objBooks =  returnedBook
            })
            
            //delaying the main thread until async api call is returned
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                
                //validating entered isbn and taking appropriate actions
                if (self.objBooks.book_isbn.isEmpty){
                    self.isbnNotRegistered()
                }
                else{
                     self.performSegue(withIdentifier: "mybookToaddbook", sender: MyBooksVC())
                }
               
            })
            
        }
        else{
            let alertAddISBN = UIAlertController(title:"Error", message: "This is an invalid ISBN. Please enter a valid ISBN.", preferredStyle: .alert)
            
            alertAddISBN.addTextField { (textField) in
                textField.placeholder = "ISBN"
            }
            
            let actionCancel = UIAlertAction(title: "Cancel", style:.cancel, handler:nil)
            let actionOk = UIAlertAction(title: "OK", style: .default) { (UIAlertAction) in
                self.enteredISBN = alertAddISBN.textFields![0].text!
                self.validISBNCheck(passedISBN: self.enteredISBN)
            }
            
            alertAddISBN.addAction(actionCancel)
            alertAddISBN.addAction(actionOk)
            self.present(alertAddISBN, animated: true, completion:nil)
        }
        
    }
    
    //func to raise an alert if there are no books
    func isbnNotRegistered(){
        let actionSheet = UIAlertController(title: "Error", message: "ISBN entered doesn't exist", preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style:.default, handler: nil)
        actionSheet.addAction(okButton)
        present(actionSheet, animated: true, completion: nil)
        
    }
    
    
    func sortBooks(arr_books : [Books]) -> [Books]{
        var sortedArray = arr_books
        if SortBy.shared.sortField == "Title"{
            sortedArray = sortByTitle(array_books: sortedArray)
        }
        else if SortBy.shared.sortField == "Author"{
            sortedArray = sortByAuthor(array_books: sortedArray)
        }
        return sortedArray
    }
    
    //Preparing for push segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mybookToaddbook" {
            
            let addbookvc = segue.destination as! AddBookVC
            addbookvc.passedBooks = objBooks
            
        }
        
        if segue.identifier == "mybooktobookdetails"{
            let bookDetailVC = segue.destination as! BookDetailsVC
            bookDetailVC.selectedBook = objBooks
        }
    } 
    

}
