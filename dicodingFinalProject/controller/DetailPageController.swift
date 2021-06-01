//
//  DetailPageController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 28/05/21.
//

import UIKit
import MapKit

class DetailPageController: UIViewController, UIScrollViewDelegate {
    var place: TableViewCellModel?
    
    var scrollView: UIScrollView!
    var placeDescription: UILabel!
    var placeName: UILabel!
    var placeAddress: UILabel!
    var test: UILabel!
    var headerContainerView: UIView!
    var placeImage: UIImageView!
    let mapView = MKMapView()
    let annotation = MKPointAnnotation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create View
        createViews()
        
        // Set Constraints
        setViewConstraints()
        
        // Set Hero Id
        setHeroId()
        
        // ScrollView
        scrollView.backgroundColor = UIColor.white
        
        // Description
        placeDescription.text = place?.description
        
        // Name
        placeName.text = place?.name
        
        // Address
        placeAddress.text = place?.address
        
        loadImage(with: place!)
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
    
    func createViews() {
        // ScrollView
        scrollView = UIScrollView()
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        
        // Description
        placeDescription = UILabel()
        placeDescription.numberOfLines = 0
        self.scrollView.addSubview(placeDescription)
        
        // Name
        placeName = UILabel()
        placeName.font = UIFont.boldSystemFont(ofSize: 20)
        placeName.numberOfLines = 0
        self.scrollView.addSubview(placeName)
        
        // Address
        placeAddress = UILabel()
        placeAddress.numberOfLines = 0
        placeAddress.textColor = UIColor.gray
        self.scrollView.addSubview(placeAddress)
        
        // Header Container
        headerContainerView = UIView()
        headerContainerView.backgroundColor = .gray
        self.scrollView.addSubview(headerContainerView)
        
        // ImageView for background
        placeImage = UIImageView()
        placeImage.clipsToBounds = true
        placeImage.contentMode = .scaleAspectFill
        self.headerContainerView.addSubview(placeImage)
        
        // Map
        self.scrollView.addSubview(mapView)
        
        // Annotation
        annotation.title = place?.name
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(place!.latitude), longitude: CLLocationDegrees(place!.longitude))
        self.mapView.addAnnotation(annotation)
        
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 100000, longitudinalMeters: 100000)
        mapView.setRegion(region, animated: true)
    }
    
    func setHeroId() {
        placeImage?.heroID = "image\(String(place!.id))"
        
        placeName?.heroID = "title\(String(place!.id))"
        
        placeAddress?.heroID = "address\(String(place!.id))"
    }
    
    func setViewConstraints() {
        let screenSize = UIScreen.main.bounds
        
        // ScrollView Constraints
        self.scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        // Place Description Constraints
        self.placeDescription.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeDescription.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.placeDescription.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.placeDescription.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -200),
            self.placeDescription.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: screenSize.height / 4 )
        ])
        
        //Place Name Constraints
        self.placeName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeName.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.placeName.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.placeName.bottomAnchor.constraint(equalTo: self.placeDescription.topAnchor, constant: -25),
        ])
        
        //Place Address Constraints
        self.placeAddress.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeAddress.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.placeAddress.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.placeAddress.bottomAnchor.constraint(equalTo: self.placeDescription.topAnchor, constant: -5),
        ])
        
        //Map View Constraints
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
            self.mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            self.mapView.topAnchor.constraint(equalTo: self.placeDescription.bottomAnchor, constant: 20),
            self.mapView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor, constant: -20),
        ])
        
        // Header Container Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        
        self.headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.headerContainerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        headerContainerViewBottom = self.headerContainerView.bottomAnchor.constraint(equalTo: self.placeDescription.topAnchor, constant: -60)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        // ImageView Constraints
        let imageViewTopConstraint: NSLayoutConstraint!
        placeImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.placeImage.leadingAnchor.constraint(equalTo: self.headerContainerView.leadingAnchor),
            self.placeImage.trailingAnchor.constraint(equalTo: self.headerContainerView.trailingAnchor),
            self.placeImage.bottomAnchor.constraint(equalTo: self.headerContainerView.bottomAnchor)
        ])
        
        imageViewTopConstraint = self.placeImage.topAnchor.constraint(equalTo: self.view.topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enableHero()
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        disableHero()
    }
}
