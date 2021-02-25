//
//  LibraryTableVC.swift
//  Library
//
//  Created by Ivan Villanueva on 25/02/21.
//

import UIKit
import CoreData

class LibraryTableVC: UITableViewController, LibraryTableVCProtocol, NSFetchedResultsControllerDelegate {
    
    var books:[BookMO] = []
    var fetchResultController: NSFetchedResultsController<BookMO>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Fetch data from data store
        let fetchRequest: NSFetchRequest<BookMO> = BookMO.fetchRequest()
        let sortDecriptor = NSSortDescriptor(key: "bookTitle", ascending: true)
        
        fetchRequest.sortDescriptors = [sortDecriptor]
        
        if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
            let context = appDelegate.persistentContainer.viewContext
            
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
            
            do {
                try fetchResultController.performFetch()
                
                if let fetchedObjects = fetchResultController.fetchedObjects {
                    books = fetchedObjects
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    @IBAction func addBook(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "AddBookVC") as! AddBookVC
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableVCell

        // Configure the cell...
        cell.bookTitleLabel.text = books[indexPath.row].bookTitle
        cell.bookAuthorsLabel.text = books[indexPath.row].authors

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65.0
    }
    
    
    // MARK: UITableViewDelegate Protocol
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            
            // Delete row from the data source
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                let context = appDelegate.persistentContainer.viewContext
                let bookToDelete = self.fetchResultController.object(at: indexPath)
                
                context.delete(bookToDelete)
                
                appDelegate.saveContext()
            }
            
            
            completionHandler(true)
        }
        deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        
        let swipeconfiguration = UISwipeActionsConfiguration(actions: [deleteAction])
        
        return swipeconfiguration
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let fullInformation: String = "Título: \(books[indexPath.row].bookTitle ?? "Not available") \n Authors: \(books[indexPath.row].authors ?? "Not available") \n Year: \(books[indexPath.row].publicationYear ?? "Not available") \n ISBN: \(books[indexPath.row].isbn ?? "Not available")"
        
        let alert = UIAlertController(title: "Información completa", message: fullInformation, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(alertAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: Fetch requests methods
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }
        
        if let fetchedObjects = controller.fetchedObjects {
            books = fetchedObjects as! [BookMO]
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
}
