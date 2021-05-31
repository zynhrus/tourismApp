//
//  apiModel.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import Foundation

struct Initial: Codable {
    let error: Bool?
    let message: String?
    let count: Int?
    let places: [Place]?
}

struct Place: Codable {
    let id: Int?
    let name: String?
    let description: String?
    let address: String?
    let longitude: Float?
    let latitude: Float?
    let like: Int?
    let image: String?
}
