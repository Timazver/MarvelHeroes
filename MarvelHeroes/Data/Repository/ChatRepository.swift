//
//  CharRepository.swift
//  MarvelHeroes
//
//  Created by tima on 1/14/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

protocol ChatRepository {
    func getChatByName(name: String) -> Chat
    func getAllChats() -> [Chat]
    func saveChat(chat: Chat)
}
