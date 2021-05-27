//
//  TableViewCell.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeName: UILabel!
    @IBOutlet weak var placeLocation: UILabel!
    @IBOutlet weak var likeBackground: UIView!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
