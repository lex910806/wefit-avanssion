//
//  FriendService.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import Alamofire
import SwiftyJSON

class FriendService {
    
    class func queryMyFriends(token: String, completion: @escaping (PagedFriendListViewModel?, Error?) -> Void) {
        let url = URL(string: "http://20.188.108.21/api/v1/friends")!
        AF.request(url,
                   headers: HTTPHeaders([HTTPHeader.init(name: "access-token", value: token)]))
            .responseJSON(completionHandler: { (res) in
                print(JSON(res.data))
            })
            .responseData { (res) in
                switch res.result {
                case .success(let data):
                    let friends = try? JSONDecoder().decode(PagedFriendListViewModel.self, from: data)
                    completion(friends, nil)
                case .failure(let err):
                    completion(nil, err)
                }
            }
    }
    
    class func queryMyFriend(token: String, id: String, completion: @escaping (CodableUser?, Error?) -> Void) {
        if let url = URL(string: "http://20.188.108.21/api/v1/friend/\(id)") {
            AF.request(url,
                       headers: HTTPHeaders([HTTPHeader.init(name: "access-token", value: token)]))
                .responseJSON(completionHandler: { (res) in
                    print(JSON(res.data))
                })
                .responseData { (res) in
                    switch res.result {
                    case .success(let data):
                        do {
                            let friends = try JSONDecoder().decode(CodableUser.self, from: data)
                            completion(friends, nil)
                        }catch {
                            print(error)
                        }
                        
                        
                    case .failure(let err):
                        completion(nil, err)
                    }
                }
        }
        
    }
    
    
    class func insertFriend(token: String, id: String, completion: @escaping (User?, Error?) -> Void) {
        let url = URL(string: "http://20.188.108.21/api/v1/friend")!
        AF.request(url,
                   method: .post,
                   parameters: ["id": id],
                   headers: HTTPHeaders([HTTPHeader.init(name: "access-token", value: token)]))
            .responseData { (res) in
                switch res.result {
                case .success(let data):
                    let user = try? JSONDecoder().decode(User.self, from: data)
                    completion(user, nil)
                case .failure(let err):
                    completion(nil, err)
                }
            }
    }
}
