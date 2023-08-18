
import UIKit
import PDFKit
import SwiftUI
import SwiftSoup
import WebKit
import Combine

struct CustomTabBar: View {
    @Binding var selectedTab: String
    @State var tabPoints: [CGFloat] = []
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(spacing: 0) {
                TabBarButton(image: "magazine", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    // Handle magazine icon tap
                    selectedTab = "magazine"
                }
                TabBarButton(image: "paperplane", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    // Handle paperplane icon tap
                    selectedTab = "paperplane"
                }
                TabBarButton(image: "graduationcap", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    selectedTab = "graduationcap"
                }
                TabBarButton(image: "person", selectedTab: $selectedTab, tabPoints: $tabPoints) {
                    // Handle person icon tap
                    selectedTab = "person"
                }
            }
            .padding(.horizontal)
            .background(Color("Color 6"))
            .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
            .overlay(
                Circle()
                    .fill(Color("Color 4"))
                    .frame(width: 10, height: 10)
                    .offset(x: getCurvePoint() - 20),
                alignment: .bottomLeading
            )
            .cornerRadius(30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(getSelectedScreen())
    }
    
    func getCurvePoint() -> CGFloat {
        if tabPoints.isEmpty {
            return 10
        } else {
            switch selectedTab {
            case "magazine":
                return tabPoints[0]
            case "paperplane":
                return tabPoints[1]
            case "graduationcap":
                return tabPoints[2]
            default:
                return tabPoints[3]
            }
        }
    }
    
    @ViewBuilder
    func getSelectedScreen() -> some View {
        if selectedTab == "magazine" {
            MagazineView()
        } else if selectedTab == "paperplane" {
            PaperPlaneView()
        } else if selectedTab == "graduationcap" {
            GraduationCapView()
        } else {
            EmptyView()
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant("magazine"))
    }
}


struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    var action: () -> Void
    
    var body: some View {
        GeometryReader { reader -> AnyView in
            let midX = reader.frame(in: .global).midX
            DispatchQueue.main.async {
                if tabPoints.count <= 4 {
                    tabPoints.append(midX)
                }
            }
            return AnyView(
                Button(action: {
                    selectedTab = image
                    action() // Perform the custom action
                }) {
                    Image(systemName: image + ".fill")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("Color 4"))
                        .offset(y: selectedTab == image ? -8 : 0)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 70)
    }
}

   


struct PaperPlaneView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("TelegramView ")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                
               
            }
            .navigationBarTitle("paperplane", displayMode: .large)
        }
    }
}


struct GraduationCapView: View {
    var body: some View {
        NavigationView {
            NewsListView()
                .navigationBarTitle("BBC News", displayMode: .large)
        }
    }
}

struct NewsItem: Identifiable {
    let id = UUID()
    let title: String
    let link: URL
    let imageUrl: URL?
    let fullArticleLink: URL // Add this property
}

struct NewsListView: View {
    @State private var newsItems: [NewsItem] = []
    @State private var searchText: String = ""
    
    var filteredNewsItems: [NewsItem] {
        if searchText.isEmpty {
            return newsItems
        } else {
            return newsItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search News")
                .padding(.horizontal)
            
            List(filteredNewsItems) { newsItem in
                Link(destination: newsItem.link, label: {
                    HStack(spacing: 12) {
                        if let imageUrl = newsItem.imageUrl {
                            RemoteImage(url: imageUrl)
                                .frame(width: 80, height: 80)
                                .aspectRatio(contentMode: .fill)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        } else {
                            Color.gray // Placeholder for missing image
                                .frame(width: 80, height: 80)
                                .cornerRadius(10)
                                .shadow(radius: 4)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(newsItem.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            Text("Read more")
                                .font(.subheadline)
                                .foregroundColor(Color("Color 4"))
                        }
                        .padding(.trailing, 8)
                    }
                    .frame(height: 100) // Set static height for the news blocks
                    .padding(10)
                    .background(Color("background")) // Set background color
                    .cornerRadius(10)
                    .shadow(radius: 5)
                })
                .buttonStyle(PlainButtonStyle()) // Remove button highlight
            }
            .onAppear(perform: fetchNews)
            .navigationTitle("BBC News")
        }
    }

    func fetchNews() {
        guard let url = URL(string: "https://www.bbc.com/news") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let html = String(data: data, encoding: .utf8) {
                    do {
                        try parseHTML(html)
                    } catch {
                        print("Error parsing HTML: \(error)")
                    }
                }
            }
        }.resume()
    }

    func parseHTML(_ html: String) throws {
        let doc = try SwiftSoup.parse(html)
        let promoBlocks = try doc.select(".gs-c-promo")
        
        newsItems = try promoBlocks.map { block in
            let title = try block.select(".gs-c-promo-heading").text()
            let linkString = try block.select("a").attr("href")
            let imageUrlString = try block.select("img").attr("src")
            let fullArticleLinkString = try block.select("a").attr("href") // Assuming this is the link to the full article
            
            let link = URL(string: linkString)!
            let imageUrl = URL(string: imageUrlString)
            let fullArticleLink = URL(string: fullArticleLinkString)!
            
            return NewsItem(title: title, link: link, imageUrl: imageUrl, fullArticleLink: fullArticleLink)
        }
    }
    
    struct SearchBar: View {
        @Binding var text: String
        var placeholder: String

        var body: some View {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField(placeholder, text: $text)
            }
            .padding(8)
            .background(Color(.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct WebView: View {
    let url: URL

    var body: some View {
        WebViewWrapper(url: url)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitle(url.host ?? "")
    }
}

struct WebViewWrapper: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}

struct RemoteImage: View {
    @StateObject private var imageLoader: ImageLoader
    private let placeholderImage = Image(systemName: "photo")
    
    init(url: URL) {
        _imageLoader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                placeholderImage
            }
        }
    }
}

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        load(url)
    }
    
    private func load(_ url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .compactMap { UIImage(data: $0) }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] image in
                self?.image = image
            })
    }
}
