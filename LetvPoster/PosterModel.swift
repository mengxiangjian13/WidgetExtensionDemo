//
//  PosterMode.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/5.
//

import Foundation
import UIKit

struct Poster {
    let title: String
    let vid: String
    let at: String
    var pic34: UIImage? = UIImage(named: "snapback")
    var pic43: UIImage? = UIImage(named: "snapback")
    
    static func placeholderPoster() -> Poster {
        Poster(title: "ok", vid: "", at: "1",
               pic34: UIImage(named: "snapback"),
               pic43: UIImage(named: "snapback"))
    }
}
