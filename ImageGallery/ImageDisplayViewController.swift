//
//  ImageDisplayViewController.swift
//  ImageGallery
//
//  Created by Anna Garcia on 10/1/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController {
    
    var imageView = UIImageView()
    var imageUrl: URL?
    var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView.contentSize = imageView.frame.size
        }
    }

    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(imageView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = imageUrl {
            fetchImage(with: url)
        }else {
            // didn't get image url... how to handle?
        }
        print("imageUrl", imageUrl)
    }
    
    private func fetchImage(with imageURL: URL) {
        let urlContents = try? Data(contentsOf: imageURL)
        if let imageData = urlContents {
            image = UIImage(data: imageData)
        }
    }
    
}
