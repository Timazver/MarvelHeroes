//
//  BaseData.swift
//  MarvelHeroes
//
//  Created by tima on 1/16/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

struct BaseData:Decodable {
    let results: [Hero]
}
