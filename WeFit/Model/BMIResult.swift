//
//  BMIResult.swift
//  WeFit
//
//  Created by Florian LUDOT on 10/11/20.
//

import Foundation

struct BMIResult: Decodable {
    let bmi: Double
    let health: String
    let range: String

    enum CodingKeys: String, CodingKey {
        case bmi
        case health
        case range = "healthy_bmi_range"
    }
}
