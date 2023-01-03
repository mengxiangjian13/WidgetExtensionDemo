//
//  SmallWidgetView.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/7.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    
    let poster: Poster
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                Image("wlogo")
                Spacer()
            }
            Spacer()
            ZStack(alignment: Alignment.bottom) {
                Image(uiImage: poster.pic43 ?? UIImage(named: "snapback")!)
                    .resizable()
                    .cornerRadius(4)
                    .scaledToFit()
                Image("bigmask")
                    .resizable()
                    .frame(height: 30)
                Text(poster.title)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 6, trailing: 10))
            }
            .widgetURL(URL(string: "smallCard,\(poster.vid)"))
        }
        .padding(12)
        .background(Color.white)
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallWidgetView(poster: Poster.placeholderPoster())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            SmallWidgetView(poster: Poster.placeholderPoster())
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
    }
}
