//
//  Books.swift
//  homelib
//
//  Created by Shalu Scaria on 2018-02-08.
//  Copyright © 2018 Shalu Scaria. All rights reserved.
//

import Foundation

class  Books {

    var book_title : String
    var book_image : String
    var book_author : String
    var book_isbn : String
    var book_loanedto : String
    var book_status : String
    var other_informations : String
    
    
    init(){
        
         book_title = ""
         book_image = ""
         book_author = ""
         book_isbn = ""
         book_loanedto = ""
         book_status = ""
        other_informations = ""
    }
    
    
    init(book_title: String,book_image:String,book_author:String,book_isbn:String,book_loanedto : String,book_status : String,other_informations : String) {
        
        self.book_title = book_title
        self.book_image = book_image
        self.book_author = book_author
        self.book_isbn = book_isbn
        self.book_loanedto = book_loanedto
        self.book_status = book_status
        self.other_informations = other_informations
    }
}
