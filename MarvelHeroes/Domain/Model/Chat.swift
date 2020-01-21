//
//  Chat.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RealmSwift

class Chat: Object {
    @objc dynamic var name = "Chat"
    var messages = List<Message>()
}
