//
//  ChatManager.swift
//  MarvelHeroes
//
//  Created by tima on 1/17/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RealmSwift

class ChatManager: ChatRepository {
    
    var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getChatByName(name: String) -> Chat {
        let chatObject = realm?.objects(Chat.self).filter( { chat in
            if chat.name == name {
                return true
            }
            return false
        })
        guard let chat = chatObject?.last else { return Chat() }
        return chat
    }
    
    func getAllChats() -> [Chat] {
        return []
    }
    
    func saveChat(chat: Chat) {
        guard let realm = realm else { return }
        try? realm.write {
            realm.add(chat)
        }
    }
    
    
}
