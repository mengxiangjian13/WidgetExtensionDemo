//
//  PosterMode.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/5.
//

import Foundation
import UIKit

struct PosterModel: Decodable {
    var title: String?
    var vid: String?
    let at: String?
    var pic34: String?
    var pic43: String?
    
    static func placeholderPoster() -> PosterModel {
        PosterModel(title: "ok", vid: "", at: "1",
               pic34: "",
               pic43: "")
    }
}

struct PosterListModel: Decodable {
    
    var list: Array<PosterModel>?
    
    enum FirstCodingKeys: String, CodingKey {
        case body
    }
    
    enum SecondCodingKeys: String, CodingKey {
        case wegitCardList
    }
    
    enum ThirdCodingKeys: String, CodingKey {
        case list
    }
    
    init(from decoder: Decoder) throws {
        // json：body->wegitCardList->list->各个海报数据
        let container = try decoder.container(keyedBy: FirstCodingKeys.self)
        let cWidgetList = try container.nestedContainer(keyedBy: SecondCodingKeys.self, forKey: .body)
        let cList = try cWidgetList.nestedContainer(keyedBy: ThirdCodingKeys.self, forKey: .wegitCardList)
        list = try cList.decode(Array<PosterModel>.self, forKey: .list)
    }
}

struct Poster: Hashable {
    let title: String
    let vid: String
    let at: String
    var pic34: UIImage? = UIImage(named: "snapback")
    var pic43: UIImage? = UIImage(named: "snapback")
    
    static func posterWithDataModel(_ dataModel: PosterModel) -> Poster {
        let title = dataModel.title ?? ""
        let vid = dataModel.vid ?? ""
        let at = dataModel.at ?? "1"
        var poster = Poster(title: title,
                            vid: vid,
                            at: at)
        if let pic = dataModel.pic34,
            let url = URL(string: pic),
            let data = try? Data(contentsOf: url) {
            poster.pic34 = UIImage(data: data)
        }
        if let pic = dataModel.pic43,
            let url = URL(string: pic),
            let data = try? Data(contentsOf: url) {
            poster.pic43 = UIImage(data: data)
        }
        return poster
    }
    
    static func placeholderPoster() -> Poster {
        posterWithDataModel(PosterModel.placeholderPoster())
    }
}
