//
//  ChatViewModel.swift
//  MarvelHeroes
//
//  Created by tima on 1/20/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation
import RxSwift

class ChatViewModel {

    var currentChat = PublishSubject<Chat>()
    var chatManager = ChatManager()
    var message = PublishSubject<Message>()
    
    func saveChat(chat: Chat) {
        chatManager.saveChat(chat: chat)
    }
    
    func getChat(name: String) {
        let chat = chatManager.getChatByName(name: name)
        currentChat.onNext(chat)
    }
}
