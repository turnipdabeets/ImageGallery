//
//  ImageGalleryDocumentTableViewController.swift
//  ImageGallery
//
//  Created by Anna Garcia on 9/25/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ImageGalleryDocumentTableViewController: UITableViewController {
    
    // This VC assumes currentDocuments are at idx 0 and deletedDocuments are at the last idx
    var imageGalleryDocuments = [
        (title: "", items:["One", "Two", "Three"]),
        (title: "Deleted", items: ["Test"]),
        ]
    
    @IBAction func newImageGallery(_ sender: UIBarButtonItem) {
        imageGalleryDocuments[0].items += ["Untitled".madeUnique(withRespectTo: imageGalleryDocuments[0].items)]
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
            // Keep model and tableview in sync
            tableView.performBatchUpdates({
                // Move in model
                let removeDocument = imageGalleryDocuments[indexPath.section].items.remove(at: indexPath.row)
                let lastIndex = imageGalleryDocuments.count - 1
                imageGalleryDocuments[lastIndex].items += [removeDocument]
                // Delete the row from the data source
                tableView.deleteRows(at: [indexPath], with: .fade)
                let idxPath = IndexPath(row: imageGalleryDocuments[1].items.count - 1, section: 1)
                tableView.insertRows(at: [idxPath], with: .fade)
            })
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            // no need since we implimented a navbar add button
        }    
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
