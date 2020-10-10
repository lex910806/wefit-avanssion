//
//  Token.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation
import Firebase


class Token: NSObject, NSCoding {
    var update_date: Date
    var accessToken: String
    
    init(_ date: Date, _ accessToken: String) {
        self.update_date = date
        self.accessToken = accessToken
    }
    public func encode(with coder: NSCoder) {
        coder.encode(update_date, forKey: "date")
        coder.encode(accessToken, forKey: "access_token")
    }
    
    public required convenience init?(coder: NSCoder) {
        guard let date = coder.decodeObject(forKey: "date") as? Date,
              let accessToken = coder.decodeObject(forKey: "access_token") as? String else { return nil }
        self.init(date, accessToken)
    }
}
