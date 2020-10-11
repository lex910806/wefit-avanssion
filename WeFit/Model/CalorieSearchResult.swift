//
//  CalorieSearchResult.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//


import Foundation

struct CalorieSearchResult: Decodable {
    let id: Int
    let ndb_no:Int
    let shrt_desc: String
    let water: Double
    let energ_kcal:Int
    let protein: Double
    let lipid_tot:Double
    let ash:Double
    let carbohydrt:Double
    let fiber_td:Double
    let sugar_tot:Double
    let calcium:Double
    let iron:Double
    let magnesium:Double
    let phosphorus:Double
    let potassium:Double
    let sodium:Double
    let zinc:Double
    let copper:Double
    let manganese:Double
    let selenium:Double
    let vit_c:Double
    let thiamin:Double
    let riboflavin:Double
    let niacin:Double
    let panto_acid:Double
    let vit_b6:Double
    let folate_tot:Double
    let folic_acid:Double
    let food_folate:Double
    let folate_dfe:Double
    let choline_tot:Double
    let vit_b12:Double
    let vit_a_iu:Double
    let vit_a_rae:Double
    let retinol:Double
    let alpha_carot:Double
    let beta_carot:Double
    let beta_crypt:Double
    let lycopene:Double
    let lutzea:Double
    let vit_e:Double
    let vit_d:Double
    let vit_d_iu:Double
    let vit_k:Double
    let fa_sat:Double
    let fa_mono:Double
    let fa_poly:Double
    let cholestrl:Double
    let gmwt_1:Double
    let gmwt_desc1: String
    let gmwt_2:Double
    let gmwt_desc2: String
    let refuse_pct:Double
}
