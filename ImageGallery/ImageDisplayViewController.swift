//
//  ImageDisplayViewController.swift
//  ImageGallery
//
//  Created by Anna Garcia on 10/1/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController, UIScrollViewDelegate {
    
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
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1
            scrollView.addSubview(imageView)
            scrollView.delegate = self
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = imageUrl {
            fetchImage(with: url)
        }else {
            // didn't get image url... how to handle?
        }
    }
    
    private func fetchImage(with imageURL: URL) {
        let urlContents = try? Data(contentsOf: imageURL)
        if let imageData = urlContents {
            image = UIImage(data: imageData)
        }
    }
    
}
