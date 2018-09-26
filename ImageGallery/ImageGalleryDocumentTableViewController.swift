//
//  ImageGalleryDocumentTableViewController.swift
//  ImageGallery
//
//  Created by Anna Garcia on 9/25/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController {
    
    // Assumes currentDocuments are at idx 0 and deletedDocuments are at the last idx
    var imageGalleryDocuments = [
        (title: "", items:["One", "Two", "Three"]),
        (title: "Recently Deleted", items: ["Test"]),
        ]
    var deletedSection: Int {
        return imageGalleryDocuments.count - 1
    }
    var currentSection: Int {
        return 0
    }
    
    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
        imageGalleryDocuments[currentSection].items += ["Untitled".madeUnique(withRespectTo: imageGalleryDocuments[currentSection].items)]
        tableView.reloadData()
    }
    
    // Allow to swipe (master) TableView out of (detail) Image Gallery's way
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .primaryOverlay {
            splitViewController?.preferredDisplayMode = .primaryOverlay
        }
    }
    
    // MARK: - Table view data source | UITableViewDataSource
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return imageGalleryDocuments[section].title
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return imageGalleryDocuments.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageGalleryDocuments[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = imageGalleryDocuments[indexPath.section].items[indexPath.row]
        
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        // Default is true so currently not necessary to implement
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Permanently Delete
            if indexPath.section == deletedSection {
                // Present dialog before permanently deleting
                let dialogMessage = UIAlertController(
                    title: "Confirm",
                    message: "Are you sure you want to permanently delete this gallery?",
                    preferredStyle: .alert)
                let ok = UIAlertAction(
                    title: "OK",
                    style: .default,
                    handler: {(_) in let _ = self.removeCell(at: indexPath) })
                let cancel = UIAlertAction(
                    title: "Cancel",
                    style: .cancel,
                    handler: nil)
                dialogMessage.addAction(ok)
                dialogMessage.addAction(cancel)
                // Present dialog message to user
                self.present(dialogMessage, animated: true, completion: nil)
                return
            }
            // Move To Recently Deleted
            tableView.performBatchUpdates({
                // remove cell
                let removed = removeCell(at: indexPath)
                // add cell to Recently Deleted
                add(cell: removed, to: deletedSection)
            })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            // no need since we implimented a navbar add button
        }    
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        if indexPath.section == deletedSection {
            // Swiping Delete Row Only
            let recoverAction = UIContextualAction(style: .destructive, title: "Recover") { (action, view, handler) in
                // Recover Document
                tableView.performBatchUpdates({
                    // remove cell
                    let removed = self.removeCell(at: indexPath)
                    // move cell to Current
                    self.add(cell: removed, to: self.currentSection)
                    // complete action
                    handler(true)
                })
            }
            recoverAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            let configuration = UISwipeActionsConfiguration(actions: [recoverAction])
            return configuration
        }else {
            return nil
        }
    }
    
    // Convenience func to sync model and tableView on deletion
    func removeCell(at indexPath: IndexPath) -> String {
        let removedCell = imageGalleryDocuments[indexPath.section].items.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        return removedCell
    }
    // Convenience func to sync model and tableView on addition
    func add(cell: String, to section: Int){
        imageGalleryDocuments[section].items += [cell]
        tableView.insertRows(
            at: [IndexPath(
                row: imageGalleryDocuments[section].items.count - 1,
                section: section)],
            with: .fade)
    }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        // Prevent Segue from Recently Deleted
        if let indexPath = tableView.indexPathForSelectedRow, indexPath.section == deletedSection {
            return false
        }
        return true
    }
    
    // Preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow,
            let vc = segue.destination as? ImageGalleryViewController {
            // pass images to view controller.
            let gallery = imageGalleryDocuments[indexPath.section].items[indexPath.row]
            vc.images = gallery
        }
    }
}
