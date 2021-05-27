//
//  ViewController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 26/05/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModels = [TableViewCellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Traveling Places"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        self.tableView.rowHeight = 190
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        
        APICaller.shared.getAllData{ result in
            switch result {
            case .success(let models):
                self.viewModels = models.compactMap({
                    TableViewCellModel(
                        image: $0.image ?? "",
                        name: $0.name ?? "M/A",
                        address: $0.address ?? "",
                        description: $0.description ?? "",
                        likeCount: $0.like ?? 0
                    )
                })
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error ::::::: \(error)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell {
            
            cell.placeImage.loadImageUrl(url: URL(string: viewModels[indexPath.row].image!)!)
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            // Memanggil View Controller dengan berkas NIB/XIB di dalamnya
            let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
            
            // Mengirim data hero
            detail.place = viewModels[indexPath.row]
            
            // Push/mendorong view controller lain
            self.navigationController?.pushViewController(detail, animated: true)
        }
}

extension UIImageView {
    func loadImageUrl(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
