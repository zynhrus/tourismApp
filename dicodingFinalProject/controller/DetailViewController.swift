//
//  DetailViewController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 27/05/21.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var placeDescription: UITextView!
    
    var place: TableViewCellModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let result = place {
            name.text = result.name
            address.text = result.address
            placeDescription.text = result.description
            placeDescription.isEditable = false
            
            loadImage(with: result)
        }
    }
    
    func loadImage(with viewModel: TableViewCellModel){
        if let data = viewModel.imageData {
            image.image = UIImage(data: data)
        }
        if let url = URL(string: viewModel.image!) {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data {
                    viewModel.imageData = data
                    DispatchQueue.main.async {
                        self?.image.image = UIImage(data: data)
                    }
                }
            }
            
            task.resume()
        }
    }
}
