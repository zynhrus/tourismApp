//
//  profile.swift
//  dicodingFinalProject
//
//  Created by Albert . on 26/05/21.
//

import UIKit

struct Profile {
    let photo: UIImage
    let name: String
    let job: String
    let description: String
    let sosmed: [String]
}

var myProfile : Profile = Profile(
    photo: UIImage(named: "profile")!,
    name: "Albert",
    job: "Mobile Developer",
    description: "Hello, my name's Albert I'm 19 years old. I just graduated from high school last year. I am really interested in mobile development. I already learn Flutter for 3 years and also have worked as Flutter Developer. Now I really interested in iOS Development, I want to learn more about Swift and iOS Development",
    sosmed: ["https://github.com/zynhrus","https://www.linkedin.com/in/albertonly/","https://www.facebook.com/albert.dayak"]
)
