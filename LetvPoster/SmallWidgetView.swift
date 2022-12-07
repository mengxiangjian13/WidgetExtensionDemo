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
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 6, trailing: 10))
            }
        }
        .padding(12)
        .background(Color.white)
    }
}

struct SmallWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        SmallWidgetView(
            image: UIImage(named: "snapback")!,
            title: "okok")
        .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
