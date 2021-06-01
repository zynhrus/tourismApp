//
//  ProfilePageController.swift
//  dicodingFinalProject
//
//  Created by Albert . on 26/05/21.
//

import Foundation
import UIKit

class ProfillePageController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var job: UILabel!
    @IBOutlet weak var circleBackground: UIView!
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var linkedInButton: UIButton!
    @IBOutlet weak var githubButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var myBio: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.image = myProfile.photo
        profileImage.layer.cornerRadius = profileImage.frame.height/2
        profileImage.clipsToBounds = true
        
        name.text = myProfile.name
        
        job.text = myProfile.job
        
        myBio.text = myProfile.description
        myBio.numberOfLines = 0
        
        circleBackground.layer.borderWidth = 1
        circleBackground.layer.masksToBounds = false
        circleBackground.layer.borderColor = UIColor.white.cgColor
        circleBackground.layer.cornerRadius = circleBackground.frame.height/2
        circleBackground.clipsToBounds = true
        
        githubButton.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        githubButton.tag = 1
        
        linkedInButton.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        linkedInButton.tag = 2
        
        facebookButton.addTarget(self, action: #selector(goToLink), for: .touchUpInside)
        facebookButton.tag = 3
        
        background.transform = CGAffineTransform(rotationAngle: CGFloat(170 * Double.pi/180))
    }
    
    @objc func goToLink(sender: UIButton!) {
        if sender.tag == 1{
            UIApplication.shared.open(NSURL(string: myProfile.sosmed[0])! as URL)
        } else if sender.tag == 2{
            UIApplication.shared.open(NSURL(string: myProfile.sosmed[1])! as URL)
        } else if sender.tag == 3{
            UIApplication.shared.open(NSURL(string: myProfile.sosmed[2])! as URL)
        }
    }
}


