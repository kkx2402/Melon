//
//  Albums.swift
//  Melon
//
//  Created by kibam kang on 12/4/23.
//

import UIKit

class Albums {
    var rating: Int
    var Album: String
    var Artist: String
    var hasRated: Bool
    
    init() {
        self.rating = 0
        self.Album = ""
        self.Artist = ""
        self.hasRated = false
    }
}
