//
//  GeneralRequsts.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation
import Alamofire

protocol GeneralHttpRequest {
    static var url: URL { get }
}

class GeneralRequests<P: Encodable, T: Decodable>: GeneralHttpRequest {
    class var url: URL {
        fatalError("You must override url.")
    }
    class var headers: HTTPHeaders {
        HTTPHeaders()
    }
    
    class func post(url: URL = url, headers: HTTPHeaders = headers, params: P?, completion: @escaping (T?, Error?) -> Void) {
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .responseData(queue: DispatchQueue.global()) {
                responseHandler(response: $0, completion: completion)
            }
    }
    
    class func get(url: URL = url, headers: HTTPHeaders = headers, completion: @escaping (T?, Error?) -> Void) {
        AF.request(url,
                   headers: headers)
            .responseData(queue: DispatchQueue.global()) {
                responseHandler(response: $0, completion: completion)
            }
    }
    
    class func put(url: URL = url, headers: HTTPHeaders = headers, params: P?, completion: @escaping (Error?) -> Void) {
        AF.request(url,
                   method: .put,
                   parameters: params,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .responseData(queue: DispatchQueue.global()) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success:
                        completion(nil)
                    case .failure(let err):
                        completion(err)
                    }
                }
            }
    }
    
    class func delete(url: URL = url, headers: HTTPHeaders = headers, params: P?, completion: @escaping (Error?) -> Void) {
        AF.request(url,
                   method: .delete,
                   parameters: params,
                   encoder: JSONParameterEncoder.default,
                   headers: headers)
            .responseData(queue: DispatchQueue.global()) { response in
                DispatchQueue.main.async {
                    switch response.result {
                    case .success:
                        completion(nil)
                    case .failure(let err):
                        completion(err)
                    }
                }
            }
    }
    
    private static func responseHandler(response: AFDataResponse<Data>, completion: @escaping (T?, Error?) -> Void) {
        DispatchQueue.main.async {
            switch response.result {
            case .success(let data):
                let obj = try? JSONDecoder().decode(T.self, from: data)
                completion(obj, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
