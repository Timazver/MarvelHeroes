//
//  MessageAnswer.swift
//  MarvelHeroes
//
//  Created by tima on 1/21/20.
//  Copyright © 2020 MarvelHeroes. All rights reserved.
//

import Foundation

class MessageAnswer {
    static let answers = ["Hello, my name is Siri", "Can I help you?", "Oh, so sad, you must be carefull", "I am so glad to see you"]
    
    static func randomMessageAnswer(author: String) -> Message {
        let index = Int.random(in: 0...3)
        let message = Message()
        message.author = author
        message.isIncoming = true
        message.text = answers[index]
        return message
    }
}
