//
//  ViewController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 26/05/21.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Traveling"
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        self.tableView.rowHeight = 130
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell {
            
            cell.placeImage.image = myProfile.photo
            cell.placeName.text = myProfile.name
            cell.placeLocation.text = myProfile.job
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
