//
//  RegisterViewModel.swift
//  WeFit
//
//  Created by sangwon on 2020/10/09.
//

import Foundation

struct RegisterViewModel: Parameter{
    var email: String?
    var password: String?
    var fullname: String?
    var username: String? 
    
    
    func valid() -> Bool {
        return email?.isEmpty == false
                && password?.isEmpty == false
                && fullname?.isEmpty == false
                && username?.isEmpty == false
    }
    
}
