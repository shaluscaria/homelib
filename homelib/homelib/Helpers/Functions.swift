//
//  Functions.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-12.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation
import QuartzCore
import Alamofire
import SwiftyJSON


//Function to get the book details from isbn db
func getBookDetails(isbn : String , completion:@escaping (Books) -> Void ) {
    
    print("Obtained String", isbn)
    
    let objBooks = Books()
    var  bookDetails = [String : String]()
  
    
    let headers: HTTPHeaders = [
        "x-api-key": API_KEY,
        "accept": "application/json"
    ]
    let url = "https://api.isbndb.com/book/"
    
    
        Alamofire.request(url+isbn,headers:headers).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
               
                let swiftyJsonVar = JSON(responseData.result.value!)
                
                for (_,object) in  swiftyJsonVar{
                    print("object ::::::",object)
                    for (detail , value ) in object{
                        
                        bookDetails[detail] = value.stringValue
                        print(detail, "+" ,value.stringValue)
                        
                        switch (detail){
                        case "title" :
                            objBooks.book_title = bookDetails["title"]!
                        case "image" :
                            objBooks.book_image = bookDetails["image"]!
                        case "authors" :
                            objBooks.book_author = bookDetails["authors"]!
                        case "isbn13" :
                            objBooks.book_isbn = bookDetails["isbn13"]!
                        default :
                            let info = detail + ":" + value.stringValue + "\n"
                            objBooks.other_informations.append(info)
                            
                        }
                    }
                }
                
            }
            
        }
    
    DispatchQueue.main.async {
        print("Before returning")
        completion(objBooks)
    }
    
}
    
    func getImage(imageUrl : String , completion:@escaping (Data) -> Void ){
        
        let imageURL = URL(string: imageUrl)
        Alamofire.request(imageURL!).responseJSON {response in
            let imageData = response.data!
            
                DispatchQueue.main.async {
                    completion(imageData)
                }
        }
    
}

func sortByTitle(array_books : [Books])-> [Books]{
    var sortedArray = array_books
    sortedArray = sortedArray.sorted(by: { (first:Books,second : Books) -> Bool in
        first.book_title < second.book_title
    })
    return sortedArray
}

func sortByAuthor(array_books : [Books]) -> [Books]{
    var sortedArray = array_books
    sortedArray = sortedArray.sorted(by: { (first:Books,second : Books) -> Bool in
        first.book_author < second.book_author
    })
    return sortedArray
}







