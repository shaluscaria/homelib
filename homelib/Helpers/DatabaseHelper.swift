//
//  DatabaseHelper.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-14.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import UIKit
import QuartzCore
import CoreData

class DatabaseHelper: NSObject {
    
    private static var instance = DatabaseHelper()
    class var shared: DatabaseHelper {
        get {
            return instance
        }
    }

   
    func saveBooks(dm_title : String,dm_image:String,dm_author:String,dm_isbn:String,
                   dm_status:String,dm_loanedto:String, dm_otherinfo : String){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Book",in: managedContext)!
        
        let entity_book = NSManagedObject(entity: entity,insertInto: managedContext)
        
        entity_book.setValue(dm_author, forKeyPath: "author")
        entity_book.setValue(dm_image, forKeyPath: "image")
        entity_book.setValue(dm_isbn, forKeyPath: "isbn")
        entity_book.setValue(dm_loanedto, forKeyPath: "loanedto")
        entity_book.setValue(dm_status, forKeyPath: "status")
        entity_book.setValue(dm_title, forKeyPath: "title")
        entity_book.setValue(dm_otherinfo, forKeyPath: "other_info")
        // 4
        do {
            try managedContext.save()
            print("no error")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        //
        
    }
    
    func displayAllBooks() -> [Books]{
        
        var bookToFetch = [NSManagedObject]()
        
        var arrBooks = [Books]()
        print("array of books count in displayAllBooks initial",arrBooks.count)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        do {
            bookToFetch = try managedContext.fetch(fetchRequest)
            
            for obj in  bookToFetch {
                debugPrint(obj)
                let objectBooks = Books()
                objectBooks.book_title = (obj as! Book).title!
                objectBooks.book_image = (obj as! Book).image!
                objectBooks.book_author = (obj as! Book).author!
                objectBooks.book_isbn = (obj as! Book).isbn!
                objectBooks.book_loanedto = (obj as! Book).loanedto!
                objectBooks.book_status = (obj as! Book).status!
                //objectBooks.other_informations = (obj as! Book).other_info!
                arrBooks.append(objectBooks)
                print("Object Books :",objectBooks.book_title)
            }
            
            
            print("array of books count in displayAllBooks",arrBooks.count)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        return arrBooks
        
    }
    
    func updateBooks(booktoUpdate : Books){
        var bookToFetch = [NSManagedObject]()
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Book")
        
        do {
            bookToFetch = try managedContext.fetch(fetchRequest)
            
            for obj in  bookToFetch {
                debugPrint(obj)
                
                if (obj as! Book).title == booktoUpdate.book_title{
                    obj.setValue(booktoUpdate.book_author, forKey: "author")
                    obj.setValue(booktoUpdate.book_title,forKey: "title")
                    obj.setValue(booktoUpdate.book_loanedto, forKey: "loanedto")
                    obj.setValue(booktoUpdate.book_status, forKey: "status")
                    obj.setValue(booktoUpdate.book_isbn, forKey: "isbn")
                    obj.setValue(booktoUpdate.book_image, forKey: "image")
                    obj.setValue(booktoUpdate.other_informations, forKey: "other_info")
                }
            }
            
            try managedContext.save()
        
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
}



