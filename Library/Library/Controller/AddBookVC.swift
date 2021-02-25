//
//  AddBookVC.swift
//  Library
//
//  Created by Ivan Villanueva on 25/02/21.
//

import UIKit

class AddBookVC: UIViewController, AddBookVCProtocol {
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextFiled: UITextField!
    @IBOutlet weak var publicationYearTextField: UITextField!
    @IBOutlet weak var isbnTextField: UITextField!
    
    var book: BookMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func addBook(_ sender: Any) {
        if bookTitleTextField.text == "" || bookAuthorTextFiled.text == "" || publicationYearTextField.text == "" || isbnTextField.text == "" {
            
            let alert = UIAlertController(title: "Acción Invalida", message: "Verificar que todos los campos estén llenos", preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alert.addAction(alertAction)
            
            present(alert, animated: true, completion: nil)
            
            return
        }
        
        // Save the data to the context before dissmising the the view
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            book = BookMO(context: appDelegate.persistentContainer.viewContext)
            
            // Saving the information from the text fileds to the context
            book.bookTitle = bookTitleTextField.text
            book.authors = bookAuthorTextFiled.text
            book.publicationYear = publicationYearTextField.text
            book.isbn = isbnTextField.text
            
            print("Saving data to context...")
            appDelegate.saveContext()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
