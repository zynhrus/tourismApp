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
    @IBOutlet weak var placeAddress: UILabel!
    @IBOutlet weak var likeBackground: UIView!
    @IBOutlet weak var likeCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeName.text = nil
        placeAddress.text = nil
        likeCount.text = nil
    }
    
    func configure(with viewModel: TableViewCellModel) {
        placeImage.heroID = "image\(String(viewModel.id))"
        placeName.heroID = "title\(String(viewModel.id))"
        placeAddress.heroID = "address\(String(viewModel.id))"
        placeName.text = viewModel.name
        placeAddress.text = viewModel.address
        likeCount.text = String(viewModel.likeCount)
        likeBackground.layer.cornerRadius = 12
        
        loadImage(with: viewModel)
    }
    
    func loadImage(with viewModel: TableViewCellModel){
        if let data = viewModel.imageData {
            placeImage.image = UIImage(data: data)
        }
        if let url = URL(string: viewModel.image!) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    viewModel.imageData = data
                    DispatchQueue.main.async {
                        self?.placeImage.image = UIImage(data: data)
                    }
                }
            }
            task.resume()
        }
    }
}
