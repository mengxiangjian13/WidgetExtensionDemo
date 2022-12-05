//
//  LetvPoster.swift
//  LetvPoster
//
//  Created by mengxiangjian on 2022/12/5.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    var posters = [Poster]()
    
    func placeholder(in context: Context) -> SimpleEntry {
        // 第一次加载placeholder
        var _posters = [Poster]()
        for _ in 0 ..< 4 {
            _posters.append(Poster.placeholderPoster())
        }
        return SimpleEntry(date: Date(), posters: _posters)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        // 判断是否是选择添加widget时候的预览，如果是预览，则不需要真实数据，要及时给出预览版。
        let entry: SimpleEntry
        if posters.count > 0 && !context.isPreview {
            entry = SimpleEntry(date: Date(), posters: posters)
        } else {
            var _posters = [Poster]()
            for _ in 0 ..< 4 {
                _posters.append(Poster.placeholderPoster())
            }
            entry = SimpleEntry(date: Date(), posters: _posters)
        }
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        LetvPosterData.getTodayPoster {
            
            let currentDate = Date()
            let entry: SimpleEntry
            switch $0 {
            case .success(let posters):
                entry = SimpleEntry(date: currentDate,
                                    posters: posters)
            case .failure(_):
                var _posters = [Poster]()
                for _ in 0 ..< 4 {
                    _posters.append(Poster.placeholderPoster())
                }
                entry = SimpleEntry(date: Date(), posters: _posters)
            }
            
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

    var body: some View {
        Text(entry.date, style: .time)
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
