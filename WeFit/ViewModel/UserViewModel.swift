//
//  SignupViewModel.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

typealias SignupViewModel = UserViewModel
struct UserViewModel: Parameter {
    var email: String
    var password: String
    var avatar: Data
    var firstName: String
    var lastName: String
    var nickName: String
    var birth: Int
    var height: Float
    var weight: Float
    var sex: Int
    var imageName: String
    
    init(email: String, password: String, avatar: UIImage, firstName: String, lastName: String, nickName: String, birth:Int, height: Float, weight: Float, sex: Sex, imageName: String) {
        self.email = email
        self.password = password
        self.avatar = avatar.jpegData(compressionQuality: 0.5) ?? Data()
        self.firstName = firstName
        self.lastName = lastName
        self.nickName = nickName
        self.birth = birth
        self.height = height
        self.weight = weight
        self.sex = sex.rawValue
        self.imageName = imageName
    }
    
    func valid() -> Bool {
        return true
    }
    
    enum Sex: Int {
        case male
        case female
    }
}
