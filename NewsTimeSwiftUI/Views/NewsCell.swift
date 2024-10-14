//
//  NewsCell.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 01.10.2024.
//

import SwiftUI
import Kingfisher

struct NewsCell: View {
    let mediaUrlString: String
    let titleText: String
    let descriptionText: String
    let creationText: String
    let byLineText: String

    let width: CGFloat

    var favoriteAction: () -> Void

    var body: some View {
        HStack {
            KFImage(URL(string: mediaUrlString))
                .placeholder { Image(uiImage: .init(named: "NoImage")!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width * 0.3) }
                .resizable()
                .frame(width: width * 0.3)
                .scaledToFit()

            VStack(alignment: .leading, spacing: 10.0) {
                Text(titleText).font(.system(size: 15))
                Text(descriptionText).font(.system(size: 10)).lineLimit(2)
                HStack {
                    Button(action: favoriteAction, label: {
                        Image(uiImage: UIImage(systemName: "star.fill")!)  .renderingMode(.template).colorMultiply(.blue)
                    }).buttonStyle(PlainButtonStyle())
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text(creationText).font(.system(size: 8))
                        Text(byLineText).font(.system(size: 8)).lineLimit(1)
                    }
                }
            }
        }
    }
}

#Preview {
    NewsCell(mediaUrlString: "https://fastly.picsum.photos/id/238/200/300",
             titleText: "The moment",
             descriptionText: "The moment",
             creationText: "The moment",
             byLineText: "The moment",
             width: 400, 
             favoriteAction: {})
}
