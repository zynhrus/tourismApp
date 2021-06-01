//
//  ViewController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 26/05/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModels = [TableViewCellModel]()
    private let searchVC = UISearchController(searchResultsController: nil)
    let progressBar = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressBar.startAnimating()
        
        createProgressBar()
        
        title = "Traveling Places"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "tableCell")
        tableView.rowHeight = 190
        
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        UISearchBar.appearance().tintColor = UIColor.black
        
        createSearchBar()
        
        APICaller.shared.getAllData{ [weak self] result in
            switch result {
            case .success(let models):
                self!.viewModels = models.compactMap({
                    TableViewCellModel(
                        id: $0.id ?? 0,
                        image: $0.image ?? "",
                        name: $0.name ?? "M/A",
                        address: $0.address ?? "",
                        description: $0.description ?? "",
                        likeCount: $0.like ?? 0,
                        latitude: $0.latitude ?? 0,
                        longitude: $0.longitude ?? 0
                    )
                })
                
                DispatchQueue.main.async {
                    self!.progressBar.stopAnimating()
                    
                    self!.tableView.reloadData()
                }
            case .failure(let error):
                print("Error ::::::: \(error)")
            }
        }
    }
    
    func createProgressBar() {
        view.addSubview(progressBar)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.hidesWhenStopped = true
        progressBar.color = UIColor.black
        progressBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? TableViewCell {
            
            cell.configure(with: viewModels[indexPath.row])
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = DetailPageController()
        
        detail.place = viewModels[indexPath.row]
        
        detail.placeImage?.heroID = String(viewModels[indexPath.row].id)
        
        detail.placeName?.heroID = "title\(String(viewModels[indexPath.row].id))"
        
        self.showHero(detail)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        progressBar.startAnimating()
        
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        APICaller.shared.getAllData{ [weak self] result in
            switch result {
            case .success(let models):
                self!.viewModels = models.compactMap({
                    TableViewCellModel(
                        id: $0.id ?? 0,
                        image: $0.image ?? "",
                        name: $0.name ?? "M/A",
                        address: $0.address ?? "",
                        description: $0.description ?? "",
                        likeCount: $0.like ?? 0,
                        latitude: $0.latitude ?? 0,
                        longitude: $0.longitude ?? 0
                    )
                }).filter({$0.name.localizedCaseInsensitiveContains(text)})
                
                DispatchQueue.main.async {
                    self!.progressBar.stopAnimating()
                    self!.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print("Error ::::::: \(error)")
            }
        }
        
        print(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        progressBar.startAnimating()
        
        APICaller.shared.getAllData{ [weak self] result in
            switch result {
            case .success(let models):
                self!.viewModels = models.compactMap({
                    TableViewCellModel(
                        id: $0.id ?? 0,
                        image: $0.image ?? "",
                        name: $0.name ?? "M/A",
                        address: $0.address ?? "",
                        description: $0.description ?? "",
                        likeCount: $0.like ?? 0,
                        latitude: $0.latitude ?? 0,
                        longitude: $0.longitude ?? 0
                    )
                })
                
                DispatchQueue.main.async {
                    self!.progressBar.stopAnimating()
                    self!.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print("Error ::::::: \(error)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disableHero()
    }
}
