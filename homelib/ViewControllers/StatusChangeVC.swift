//
//  StatusChangeVC.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-14.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit

class StatusChangeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var selectedBook = Books()
    let arrayStatus = ["Unread","Being read" , "Read"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = 60
        let cell = tableView.dequeueReusableCell(withIdentifier: "statusCell", for: indexPath) as! ChangeReadingStatusTVC
        cell.statusImage.image = UIImage(named: arrayStatus[indexPath.row])
        cell.statusLabel.text = arrayStatus[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
         selectedBook.book_status = arrayStatus[indexPath.row]
        self.performSegue(withIdentifier: "readstatustobookdetails", sender: StatusChangeVC())
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Change Reading Status"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "readstatustobookdetails" {
            let  bookdetailsVC = segue.destination as!  BookDetailsVC
            bookdetailsVC.selectedBook = selectedBook
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
