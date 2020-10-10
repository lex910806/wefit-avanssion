//
//  SearchUser.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/10.
//

import Alamofire
import SwiftyJSON
class SearchUser {
    class func find(query: String, completion: @escaping (PagedFriendListViewModel?, Error?) -> Void) {
        if let url = URL(string: "http://20.188.108.21/api/v1/find/friend?name=\(query)") {
            AF.request(url)
                .responseJSON(completionHandler: { (res) in
                    let res = JSON(res.data)
                    
                    print(res)
                })
                .responseData { (res) in
                    switch res.result {
                    case .success(let data):
                        do {
                            let friends = try JSONDecoder().decode(PagedFriendListViewModel.self, from: data)
                            completion(friends, nil)
                        } catch {
                            print(error)
                        }
                        
                    case .failure(let err):
                        completion(nil, err)
                    }
                }
        } else {
            completion(nil, nil)
        }
        
    }
}
