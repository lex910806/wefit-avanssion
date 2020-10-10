//
//  User.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation

typealias Friend = User

struct CodableUser: Codable {
    var id: Int
    var lastName: String
    var email: String
    var fisrtName: String
    var nickName: String
    var weight: Float
    var height: Float
    var age: Int
    var stats: Int
    var avatar: String
}

struct User: Codable {
    var id: Int
    var lastName: String
    var email: String
    var firstName: String
    var nickName: String
    var weight: Float
    var height: Float
    var age: Int
    var stats: Int
    var avatar: String
    
    var avatarUrl: URL? {
        URL(string: avatar)
    }
    
    init(usr: CodableUser) {
        self.id = usr.id
        self.lastName = usr.lastName
        self.email = usr.email
        self.firstName = usr.fisrtName
        self.nickName = usr.nickName
        self.weight = usr.weight
        self.height = usr.height
        self.age = usr.age
        self.stats = usr.stats
        self.avatar = usr.avatar
    }
//
//    init(id: Int, email: String, firstName: String, lastName: String, nickName: String, weight: Float, height: Float, age: Int, stats: Int, avatar: String) {
//        self.id = id
//        self.email = email
//        self.firstName = firstName
//        self.nickName = nickName
//        self.weight = weight
//        self.height = height
//        self.age = age
//        self.stats = stats
//        self.avatar = avatar
//        self.lastName = lastName
//    }
//
    init(_ dictionary: [String: Any]) {
        self.id = dictionary["id"] as? Int ?? -1
        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.nickName = dictionary["nickName"] as? String ?? ""
        self.weight = dictionary["weight"] as? Float ?? -1
        self.height = dictionary["height"] as? Float ?? -1
        self.age = dictionary["age"] as? Int ?? -1
        self.stats = dictionary["stats"] as? Int ?? -1
        self.avatar = dictionary["avatar"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
    }
}
