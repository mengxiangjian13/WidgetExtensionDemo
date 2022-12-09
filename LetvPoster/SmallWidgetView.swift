//
//  SmallWidgetView.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/7.
//

import SwiftUI
import WidgetKit

struct SmallWidgetView: View {
    
    let image: UIImage
    let title: String
    let url: String
    
    var body: some View {
        VStack(alignment: .center) {
            HStack() {
                Image("wlogo")
                Spacer()
            }
            Spacer()
            ZStack(alignment: Alignment.bottom) {
                Image(uiImage: image)
                    .resizable()
                    .cornerRadius(4)
                    .scaledToFit()
                Image("bigmask")
                    .resizable()
                    .frame(height: 30)
                Text(title)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 6, trailing: 10))
            }
            .widgetURL(URL(string: "smallCard,\(url)"))
        }
        .padding(12)
        .background(Color.white)
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SmallWidgetView(
                image: UIImage(named: "test")!,
                title: "okok",
            url: "https://baidu.com")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            SmallWidgetView(
                image: UIImage(named: "snapback")!,
                title: "okok",
                url: "https://baidu.com")
            .previewContext(WidgetPreviewContext(family: .systemSmall))
        }
        
    }
}
