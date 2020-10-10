//
//  ViewModel.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import Foundation

enum JSONSerializationError: Error {
    case jsonSerializationFail
}

protocol Parameter: Encodable {
    func valid() -> Bool
}

typealias Json = [String: Any]
extension Parameter {
    func json() -> Json? {
        if let jsonData = try? JSONEncoder().encode(self) {
            return try? JSONSerialization.jsonObject(with: jsonData, options: []) as? Json
        }
        return nil
    }    
}
