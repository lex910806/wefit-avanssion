//
//  Record.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation

struct Record: Codable {
    var me: User
    var winner_id: Int
    var date: Date
    var value: Int
    private var kind: Int
    var opponent: Opponent
    var exercise: Exercise {
        return Exercise(rawValue: kind) ?? .pushup
    }
    
    var amIWin: Bool {
        return me.id == winner_id
    }
    struct Opponent: Codable {
        var id: Int
        var avatar_url: String
        var value: Int
        var avatarUrl: URL? {
            return URL(string: avatar_url)
        }
    }
    
    init(me: User, winnerId: Int, date: Date, value: Int, kind: Int, opponent: Opponent) {
        self.me = me
        self.winner_id = winnerId
        self.date = date
        self.value = value
        self.kind = kind
        self.opponent = opponent
        
    }
}
