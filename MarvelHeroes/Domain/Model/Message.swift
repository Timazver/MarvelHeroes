//
//  Message.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RealmSwift

class Message: Object {
    
    dynamic var author:String = ""
    dynamic var text: String = ""
    dynamic var isIncoming: Bool = false
    
}
