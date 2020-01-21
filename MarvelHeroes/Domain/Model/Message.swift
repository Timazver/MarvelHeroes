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
    @objc dynamic var author:String = ""
    @objc dynamic var text: String = ""
    @objc dynamic var isIncoming: Bool = false
    
}
