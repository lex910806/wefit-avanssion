//
//  UserViewModel.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation
typealias UserSearchResult = FriendListViewModel
struct FriendListViewModel: Codable {
    
    var id: Int
    var email: String
    var nickName: String
    var avatar_url: String?
}

struct PagedFriendListViewModel: Codable {
    var totalElements: Int
    var totalPages: Int
    var size: Int
    var page: Int
    var friends: [FriendListViewModel]
}
