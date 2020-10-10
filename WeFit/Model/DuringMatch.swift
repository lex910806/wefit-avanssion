//
//  DuringMatch.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//

import Foundation

struct DuringMatch {
    var myId: String
    var opponentId: String
    
    var myValue: Int
    var opponentValue: Int
    
    var amIOnline: Bool
    var isOpponentOnline: Bool
    
    init(_ dictionary: [String: Any]) {
        self.myId = dictionary["myId"] as? String ?? ""
        self.opponentId = dictionary["opponentId"] as? String ?? ""
        
        self.myValue = dictionary["myValue"] as? Int ?? 0
        self.opponentValue = dictionary["opponentValue"] as? Int ?? 0
        
        self.amIOnline = dictionary["amIOnline"] as? Bool ?? false
        self.isOpponentOnline = dictionary["isOpponentOnline"] as? Bool ?? false
    }
}
