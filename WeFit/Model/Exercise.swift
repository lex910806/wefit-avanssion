//
//  Exercise.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/09.
//

import UIKit

enum Exercise: Int {
    case pushup
    case squat
    case lunge
    case crunch
    
    func color() -> UIColor {
        switch self {
        case .pushup:
            return .init(23, 193, 96)
        case .squat:
            return .init(246, 126, 16)
        case .lunge:
            return .init(132, 25, 216)
        case .crunch:
            return .init(23, 193, 96)
        }
    }
    func name() -> String {
        switch self {
        case .pushup:
            return "Push Up"
        case .squat:
            return "Squat"
        case .lunge:
            return "Lunge"
        case .crunch:
            return "Crunch"
        }
    }
    
    func smallImage() -> UIImage? {
        switch self {
        case .pushup:
            return UIImage(named: "pushup_small")
        case .squat:
            return UIImage(named: "squat_small")
        case .lunge:
            return UIImage(named: "lunge_small")
        case .crunch:
            return UIImage(named: "crunch_small")
        }
    }
}
