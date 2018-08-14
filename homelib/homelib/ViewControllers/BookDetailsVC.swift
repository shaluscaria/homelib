//
//  BookDetailsVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-13.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class BookDetailsVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
   
    @IBOutlet var booktableView: UITableView!
    
    
    var selectedBook = Books()
    var databaseHelper = DatabaseHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationItem.hidesBackButton = false
        print("received book title" , selectedBook.book_title)
        print("received book image " , selectedBook.book_image)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        print("received book status" , selectedBook.book_status)
        print("received book image " , selectedBook.book_image)
        //navigationItem.accessibilityElementsHidden = false
        navigationController?.navigationItem.hidesBackButton = false
        
        booktableView.reloadData()
    }
    
    
    @IBAction func saveEditedBookDetails(_ sender: UIBarButtonItem) {
        databaseHelper.updateBooks(booktoUpdate: selectedBook)
    }
    
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
             return 1
        }
        else if section == 1 {
             return 5
        }
        else  {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell.init()
        
        if indexPath.section == 0{
            tableView.rowHeight = 150
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! BookTitleTableViewCell
            cell.detailTitle.text = selectedBook.book_title
            
            if selectedBook.book_image == "imagenotavaialble" {
                cell.detailImage.image = #imageLiteral(resourceName: "imagenotavailable")
            }else{
                getImage(imageUrl: selectedBook.book_image, completion: { (imageData) in
                    let downloadImage = UIImage(data: imageData)
                    cell.detailImage.image = downloadImage
                })
            }
          return cell
        }
        
        else if indexPath.section == 1 {
            switch indexPath.row {
            
            case 0 :
                tableView.rowHeight = 80
                let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextTableViewCell
                cell.detailLabel.text = "Author"
                cell.detailTextField.text = selectedBook.book_author
                return cell
            case 1 :
                tableView.rowHeight = 80
                let cell = tableView.dequeueReusableCell(withIdentifier: "textFieldCell", for: indexPath) as! TextTableViewCell
                cell.detailLabel.text = "ISBN"
                cell.detailTextField.text = selectedBook.book_isbn
                return cell
                
            case 2 :
                tableView.rowHeight = 160
                let cell = tableView.dequeueReusableCell(withIdentifier: "textViewCell", for: indexPath) as! NotesTableViewCell
                cell.detailLabelLarge.text = "Other Info"
                cell.detailTextView.text = selectedBook.other_informations
                return cell
                
            case 3 :
                tableView.rowHeight = 80
                let cell = tableView.dequeueReusableCell(withIdentifier: "readingStatusCell", for: indexPath) as! ReadingStatusTVC
                cell.detailReadingLabel.text = "Loaned To"
                cell.detailReadingStatus.text = selectedBook.book_loanedto
                return cell
            case 4  :
                tableView.rowHeight = 80
                let cell = tableView.dequeueReusableCell(withIdentifier: "readingStatusCell", for: indexPath) as! ReadingStatusTVC
                cell.detailReadingLabel.text = "Reading Status"
                cell.detailReadingStatus.text = selectedBook.book_status
                return cell
                
            default :
                print("exiting in section 2")
                
            }
        }
        
        else {
            tableView.rowHeight = 60
            let cell = tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell
            
            switch indexPath.row{
            case 0 :
                cell.detailButton.text = "Loan Book"
                return cell
            case 1:
                cell.detailButton.text = "Change Reading Status"
                return cell
            default:
                print("exiting in section 3")
                
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 2 && indexPath.row == 0{
            self.performSegue(withIdentifier: "bookdetailstoloaned", sender: BookDetailsVC())
        }
        else if indexPath.section == 2 && indexPath.row == 1{
            self.performSegue(withIdentifier: "bookdetailtostatuschange", sender: BookDetailsVC())
        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "bookdetailtostatuschange" {
            let statusChangeVC = segue.destination as! StatusChangeVC
            statusChangeVC.selectedBook = selectedBook
        }
        if segue.identifier == "bookdetailstoloaned" {
            let loanBookVC = segue.destination as! LoanBookVC
            loanBookVC.passedBook = selectedBook
        }
    }
    

}
