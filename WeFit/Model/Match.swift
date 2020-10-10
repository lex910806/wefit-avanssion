//
//  Match.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation
import Firebase

struct Match {
    var toId: Int
    var fromId: Int
    var fromName: String
    var exercise: Exercise
    var timestamp: Timestamp!
    var matchId: String
    
    init(_ dictionary: [String: Any]) {
        
        let toIdStr = dictionary["toId"] as? String ?? "-1"
        let fromIdStr = dictionary["fromId"] as? String ?? "-1"
        self.toId = Int(toIdStr) ?? -1
        self.fromId = Int(fromIdStr) ?? -1
        self.fromName = dictionary["fromName"] as? String ?? ""
        
        let exercise = dictionary["exercise"] as? Int ?? 0
        
        self.exercise = Exercise(rawValue: exercise) ?? .pushup
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.matchId = dictionary["matchId"] as? String ?? UUID().uuidString
    }
}

struct Battle {
    var user: User
    var match: Match
}
