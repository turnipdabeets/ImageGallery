//
//  ImageGalleryCollectionViewController.swift
//  ImageGallery
//
//  Created by Anna Garcia on 9/26/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

private let reuseIdentifier = "ImageCell"

class ImageGalleryCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var images: String?
    
    private var imageWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return (collectionView.frame.size.width / 2) - 5
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("images", images ?? "Nothing selected")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // TODO
        return 7
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        // Configure the cell
        cell.backgroundColor = #colorLiteral(red: 0.9117823243, green: 0.9118037224, blue: 0.9117922187, alpha: 1)
        if let imageCell = cell as? ImageCollectionViewCell {
            imageCell.imageView.image = #imageLiteral(resourceName: "cat.png")
        }
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image = #imageLiteral(resourceName: "cat.png")
        let aspectRatio = image.size.width / image.size.height
        let imageHeight = imageWidth / aspectRatio
        return CGSize(width: imageWidth, height: imageHeight)
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
