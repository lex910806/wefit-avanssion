//
//  UserService.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Alamofire
import Firebase
import SwiftyJSON

struct RegistrationCredentials {
    let id: Int
    let email: String
    let name: String
    let nickName: String
    let avatar: String
}

class UserService: GeneralRequests<UserViewModel, User> {
    
    override class var url: URL {
        return URL(string: "http://20.188.108.21/api/v1/user")!
    }
    
    override class var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    static func upload(params: UserViewModel, completion: @escaping ((Int?, String?), Error?) -> Void) {
       
        AF.upload(multipartFormData: { formData in
            formData.append(params.email.data()!, withName: "email")
            formData.append(params.password.data()!, withName: "password")
            formData.append(params.firstName.data()!, withName: "firstName")
            formData.append(params.lastName.data()!, withName: "lastName")
            formData.append(params.nickName.data()!, withName: "nickName")
            formData.append(params.birth.data()!, withName: "birth")
            formData.append(params.height.data()!, withName: "height")
            formData.append(params.weight.data()!, withName: "weight")
            formData.append(params.sex.data()!, withName: "sex")
            formData.append("100".data(using: .utf8)!, withName: "stats")
            formData.append(params.avatar, withName: "avatar", fileName: params.imageName, mimeType: "image/jpeg")
        },
        to: URL(string: "http://20.188.108.21/api/v1/user")!,
        method: .post)
        .responseJSON(completionHandler: { response in
            switch response.result {
            case .success:
                let id = JSON(response.value)["id"].intValue
                let avatar = JSON(response.value)["avatar"].string
                completion((id, avatar), nil)
            case .failure(let error):
                completion((nil, nil), error)
            }
        })
    }
    
    //MARK: for firebase
    static func createUser(credentials: RegistrationCredentials, completion: ((Error?) -> Void)?) {
//        guard let imageData = credentials.profileImage.jpegData(compressionQuality: 0.3) else { return }
        
//        let filename = NSUUID().uuidString
//        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        let data = ["email": credentials.email,
                    "name": credentials.name,
                    "nickName": credentials.nickName,
                    "id": credentials.id,
                    "avatar": credentials.avatar] as [String : Any]
        
        COLLECTION_USERS.document(String(credentials.id)).setData(data, completion: completion)
    }
}
