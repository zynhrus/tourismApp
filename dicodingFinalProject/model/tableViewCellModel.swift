//
//  tableViewCellModel.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import Foundation

class TableViewCellModel {
    let id: Int
    let image: String?
    let name: String
    let address: String
    let description: String
    let likeCount: Int
    let latitude: Float
    let longitude: Float
    var imageData: Data?
    
    init(
        id:Int,
        image:String,
        name:String,
        address:String,
        description:String,
        likeCount:Int,
        latitude:Float,
        longitude:Float
    ) {
        self.id = likeCount
        self.image = image
        self.name = name
        self.address = address
        self.description = description
        self.likeCount = likeCount
        self.latitude = latitude
        self.longitude = longitude
    }
}
