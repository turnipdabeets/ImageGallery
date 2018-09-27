//
//  ImageGallery.swift
//  ImageGallery
//
//  Created by Anna Garcia on 9/26/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import Foundation

// Model representing a gallery's image.
struct Image {
    var URL: URL?
    var aspectRatio: Double?
    var data: Data?
    init(URL: URL, aspectRatio:Double) {
        self.URL = URL
        self.aspectRatio = aspectRatio
//        self.data = data ?? nil
    }
}

// Model representing a gallery with images.
struct ImageGallery {
//    let identifier = UUID().uuidString
    var title: String
    var images: [Image]
}
