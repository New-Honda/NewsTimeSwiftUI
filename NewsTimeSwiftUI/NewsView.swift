//
//  NewsView.swift
//  NewsTimeSwiftUI
//
//  Created by Developer on 09.10.2024.
//

import SwiftUI
import SafariServices

protocol NewsViewModelProtocol: ObservableObject {
    var items: [ArticleModel] { get }
    func getAllItems()
    func favoriteAction(article: ArticleModel)
}

struct NewsView<ViewModel: NewsViewModelProtocol>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                List {
                    ForEach(viewModel.items) { item in
                        ZStack {
                            NewsCell(mediaUrlString: item.media.first?.medias.first?.url ?? "",
                                     titleText: item.title,
                                     descriptionText: item.abstract,
                                     creationText: item.publishedDate,
                                     byLineText: item.byLine,
                                     width: proxy.size.width, 
                                     favoriteAction: {
                                viewModel.favoriteAction(article: item)
                            })
                            NavigationLink(destination: {
                                if let url = URL(string: item.url) {
                                    SafariWebView(url: url)
                                }
                            }) {
                                EmptyView()
                            }.opacity(.zero)
                        }.listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 10))
                    }
                }
            }
        }.onAppear(perform: viewModel.getAllItems)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

#Preview {
    NewsView(viewModel: NewsViewModel.init(viewContext: PersistenceController.preview.container.viewContext))
}

struct SafariWebView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
}
