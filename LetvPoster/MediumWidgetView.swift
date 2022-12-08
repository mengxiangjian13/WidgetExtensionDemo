//
//  MediumWidgetView.swift
//  WidgetExtensionDemo
//
//  Created by mengxiangjian on 2022/12/8.
//

import SwiftUI
import WidgetKit

struct MediumWidgetView: View {
    
    let posters: [Poster]
    
    var body: some View {
        VStack {
            HStack {
                Image("wlogo")
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 11))
                
                Button {
                    print("okokok")
                } label: {
                    HStack {
                        Spacer()
                        Image("sousuo1")
                        Text("搜索")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundColor(Color(white: 0, opacity: 0.33))
                        Spacer()
                    }
                }
                .frame(height: 24)
                .background(Color(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 242.0 / 255.0))
                .cornerRadius(12)
            }
            Spacer()
            HStack(spacing: 6) {
                ForEach(posters, id: \.self) { poster in
                    ZStack(alignment: .bottom) {
                        Image(uiImage: poster.pic34 ?? UIImage(named: "snapback")!)
                            .resizable()
                            .aspectRatio(0.75,contentMode: .fit)
                            .cornerRadius(4)
                        Image("bigmask")
                            .resizable()
                            .frame(height: 30)
                        Text(poster.title)
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .lineLimit(1)
                            .padding(5)
                    }
                }
            }
        }
        .padding(11)
        .background(Color.white)
    }
}

struct MediumWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        MediumWidgetView(posters: [Poster.placeholderPoster(),Poster.placeholderPoster(),Poster.placeholderPoster(),Poster.placeholderPoster()])
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
