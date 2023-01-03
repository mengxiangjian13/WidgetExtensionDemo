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
        
//        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "10.2.3"
        let appVersion = "10.5.0"
        
        let url = URL(string: "http://api.mob.app.letv.com/wegit/card?num=4&pcode=010110000&version=\(appVersion)&lang=chs&region=CN")!
       
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error==nil else{
                completion(.failure(error!))
                return
            }
            let postModel = try? JSONDecoder().decode(PosterListModel.self, from: data!)
            if let postModel = postModel {
                let poster = posterFromDataModel(dataModel: postModel)
                completion(.success(poster))
            } else {
                completion(.success([]))
            }
        }
        
        task.resume()
    }
    
    static func posterFromDataModel(dataModel: PosterListModel) -> [Poster] {
        var posters = [Poster]()
        if let posterList = dataModel.list {
            for p in posterList {
                posters.append(Poster.posterWithDataModel(p))
            }
        }
        return posters
    }
}
