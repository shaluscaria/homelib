//
//  LoanBookVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-01-29.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LoanedListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var arrayOfBooks = [Books()]
    var databaseHelper = DatabaseHelper()
    
    @IBOutlet var loanListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arrayOfBooks.removeAll()
        arrayOfBooks = self.loanedBookList(arrBooks: databaseHelper.displayAllBooks())
        self.loanListTableView.rowHeight = 180
        self.loanListTableView.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfBooks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "loanCell", for: indexPath) as! LoanBookTVC
        cell.loanAuthor.text = "by " + arrayOfBooks[indexPath.row].book_author
        cell.loanTitle.text = arrayOfBooks[indexPath.row].book_title
        
        if arrayOfBooks[indexPath.row].book_image == "imagenotavailable" || arrayOfBooks[indexPath.row].book_image == "" {
            cell.loanImage.image = #imageLiteral(resourceName: "imagenotavailable")
        }
            
        else {
            let imageURL = URL(string: arrayOfBooks[indexPath.row].book_image)
            Alamofire.request(imageURL!).responseJSON {response in
                let imageData = response.data!
                let downloadImage = UIImage(data: imageData)
                DispatchQueue.main.async {
                    cell.loanImage.image = downloadImage
                }
            }
        }
        return cell
    }
    
    
    func loanedBookList(arrBooks: [Books]) -> [Books]{
        var arrLoanedBook = [Books]()
        for obj in arrBooks{
            if obj.book_loanedto != "None" {
                arrLoanedBook.append(obj)
            }
        }
        return arrLoanedBook
    }


}
