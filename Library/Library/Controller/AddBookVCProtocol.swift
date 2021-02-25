//
//  AddBookVCProtocol.swift
//  Library
//
//  Created by Ivan Villanueva on 25/02/21.
//

import Foundation
import UIKit

protocol AddBookVCProtocol {
    var bookTitleTextField: UITextField! {get set}
    var bookAuthorTextFiled: UITextField! {get set}
    var publicationYearTextField: UITextField! {get set}
    var isbnTextField: UITextField! {get}
    
    var book: BookMO! {get set}
    
    func addBook(_ sender: Any)
}
