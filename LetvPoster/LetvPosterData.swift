//
//  LetvPosterData.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/5.
//

import Foundation
import UIKit

struct LetvPosterData {
    static func getTodayPoster(completion: @escaping (Result<[Poster], Error>) -> Void) {
        
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "10.2.3"
        
        let url = URL(string: "http://api.mob.app.letv.com/wegit/card?num=4&pcode=010110000&version=\(appVersion)&lang=chs&region=CN")!
       
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error==nil else{
                completion(.failure(error!))
                return
            }
            let poster=posterFromJson(fromData: data!)
            completion(.success(poster))
        }
        
        task.resume()
    }
    
    static func posterFromJson(fromData data:Data) -> [Poster] {
        var PosterArr:[Poster]!
        PosterArr = Array()
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        let result = json["body"] as! [String: Any]
        let wegitCardList = result["wegitCardList"] as! [String: Any]
        let list = wegitCardList["list"] as! Array<[String: Any]>
        for elc in list {
            let title = elc["title"] as! String
            let vid = elc["vid"] as! String
            let at = elc["at"] as! String
            let pic34 = elc["pic34"] as! String
            let pic43 = elc["pic43"] as! String
            //图片同步请求
            var image: UIImage? = nil
            if let imageData = try? Data(contentsOf: URL(string: pic34)!) {
                image = UIImage(data: imageData)
            }
            var images: UIImage? = nil
            if let imageData1 = try? Data(contentsOf: URL(string: pic43)!) {
                images = UIImage(data: imageData1)
            }
    
            PosterArr.append(Poster(title: title, vid: vid, at: at, pic34: image ?? UIImage(named: "snapback"),pic43: images ?? UIImage(named: "snapback")))
        }
        
  
        return PosterArr
    }
}
