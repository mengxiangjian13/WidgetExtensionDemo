//
//  LetvPoster.swift
//  LetvPoster
//
//  Created by mengxiangjian on 2022/12/5.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    /// 获取数据
    /// - Parameter completion: 回调block
    private func getData(completion: @escaping ([Poster]) -> ()) {
        LetvPosterData.getTodayPoster {
            switch $0 {
            case .success(let posters):
                completion(posters)
            case .failure(_):
                var _posters = [Poster]()
                for _ in 0 ..< 4 {
                    _posters.append(Poster.placeholderPoster())
                }
                completion(_posters)
            }
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        // 第一次加载placeholder
        var _posters = [Poster]()
        for _ in 0 ..< 4 {
            _posters.append(Poster.placeholderPoster())
        }
        return SimpleEntry(date: Date(), posters: _posters)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getData {
            let entry: SimpleEntry
            entry = SimpleEntry(date: Date(), posters: $0)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        getData {
            let currentDate = Date()
            let entry: SimpleEntry
            entry = SimpleEntry(date: currentDate,
                                posters: $0)
            
            let after = Calendar.current.date(byAdding: .hour,
                                              value: 1,
                                              to: currentDate)
            
            let timeline = Timeline(entries: [entry], policy: .after(after!))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let posters: [Poster]
}

struct LetvPosterEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            SmallWidgetView(poster: entry.posters.first ?? Poster.placeholderPoster())
        case .systemMedium:
            MediumWidgetView(posters: entry.posters)
        default:
             SmallWidgetView(poster: entry.posters.first ?? Poster.placeholderPoster())
        }
    }
}

struct LetvPoster: Widget {
    let kind: String = "LetvPoster"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            LetvPosterEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

struct LetvPoster_Previews: PreviewProvider {
    static var entry: SimpleEntry {
        var _posters = [Poster]()
        for _ in 0 ..< 4 {
            _posters.append(Poster.placeholderPoster())
        }
        return SimpleEntry(date: Date(), posters: _posters)
    }
    static var previews: some View {
        LetvPosterEntryView(entry: entry)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
