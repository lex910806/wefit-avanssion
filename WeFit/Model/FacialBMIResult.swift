//
//  FacialBMIResult.swift
//  WeFit
//
//  Created by JiHoon Lee on 2020/10/11.
//
import Foundation

// MARK: - Welcome
struct FacialBMIResult: Codable {
    let calculatedFaceBmi: [CalculatedFaceBmi]
    let knownFaces: KnownFaces
    let usedEngines: [String]
    let gender: String
    let returnCassifiersRawResults: Bool
    let url: String
    let imageVariations, dark: Int
}

// MARK: - CalculatedFaceBmi
struct CalculatedFaceBmi: Codable {
    let classifiersBmiResults: KnownFaces
    let bmiResult: BmiResult
}

// MARK: - BmiResult
struct BmiResult: Codable {
    let regressionStandardDeviation: String
    let regressionScore: [[Double]]
    let bmiEntries: [BmiEntry]
    let prediction: KnownFaces
    let featureVersion, featureName, modelName: String
}

// MARK: - BmiEntry
struct BmiEntry: Codable {
    let lowerBound: Double
    let upperBound, confidence: Double
}

// MARK: - KnownFaces
struct KnownFaces: Codable {
}
