//
//  TokenService.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Alamofire
import SwiftyJSON
class TokenService: GeneralRequests<LoginViewModel, String> {
    override class var url: URL {
        return URL(string: "http://20.188.108.21/api/v1/token")!
    }
    
    override class func post(url: URL = url, headers: HTTPHeaders = headers, params: LoginViewModel?, completion: @escaping (String?, Error?) -> Void) {
        
        AF.request(url,
                   method: .post,
                   parameters: params)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    if let token = json["access_token"].string {
                        completion(token, nil)
                    } else {
                        completion(nil, nil)
                    }
                    
                case .failure(let err):
                    completion(nil, err)
                }
            }
    }
}
