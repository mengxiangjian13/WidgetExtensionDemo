//
//  ViewController.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/5.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let appVersion = "10.5.0"
        
        let url = URL(string: "http://api.mob.app.letv.com/wegit/card?num=4&pcode=010110000&version=\(appVersion)&lang=chs&region=CN")!
       
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error==nil else{
//                completion(.failure(error!))
                return
            }
//            let poster=posterFromJson(fromData: data!)
//            completion(.success(poster))
        }
        task.resume()
    }


}

