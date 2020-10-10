//
//  LoginViewModel.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation

struct LoginViewModel: Parameter {
    var email: String?
    var password: String?
    
    func valid() -> Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
}
