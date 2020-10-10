//
//  Message.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Firebase

struct Message {
    let text: String
    let toId: Int
    let fromId: Int
    var timestamp: Timestamp!
    var user: User?
    var messageType: MessageType
    var exercise: Exercise
    let isFromCurrentUser: Bool
    
    init(_ dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        let toIdStr = dictionary["toId"] as? String ?? "-1"
        let fromIdStr = dictionary["fromId"] as? String ?? "-1"
        self.toId = Int(toIdStr) ?? -1
        self.fromId = Int(fromIdStr) ?? -1
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        let type = dictionary["messageType"] as? Int ?? 0
        self.messageType = MessageType(rawValue: type) ?? .text
        let exercise = dictionary["exercise"] as? Int ?? 0
        self.exercise = Exercise(rawValue: exercise) ?? .pushup
        self.isFromCurrentUser = fromId != toId
    }
    
    enum MessageType: Int {
        case text
        case battle
    }
}

struct Conversation {
    let user: User
    let message: Message
}
