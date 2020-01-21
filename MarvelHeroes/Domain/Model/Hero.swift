//
//  Hero.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

struct Hero: Decodable {
    let id: Int64
    let name: String
    let thumbnail: Thumbnail?
}
