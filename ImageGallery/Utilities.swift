//
//  Utilities.swift
//  ImageGallery
//
//  Created by Anna Garcia on 9/25/18.
//  Copyright © 2018 Juice Crawl. All rights reserved.
//

import Foundation

extension String {
    func madeUnique(withRespectTo otherStrings: [String]) -> String {
        var possiblyUnique = self
        var uniqueNumber = 1
        while otherStrings.contains(possiblyUnique) {
            possiblyUnique = self + " \(uniqueNumber)"
            uniqueNumber += 1
        }
        return possiblyUnique
    }
}
