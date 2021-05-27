//
//  tableViewCellModel.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import Foundation

class TableViewCellModel {
    let image: String?
    let name: String
    let address: String
    let likeCount: Int
    var imageData: Data?
    
    init(
        image:String,
        name:String,
        address:String,
        likeCount:Int
    ) {
        self.image = image
        self.name = name
        self.address = address
        self.likeCount = likeCount
    }
}
