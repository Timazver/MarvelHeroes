//
//  thumbnail.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String?
    let `extension`: String?
    
    var fileUrl: String {
        get {
            return "\(path ?? "").\(`extension` ?? ""))"
        }
    }
}

