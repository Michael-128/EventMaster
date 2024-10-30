import SwiftUI

struct FullScreenImageView: View {
    public let images: [EventImage]
    @State public var selectedIndex: Int

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)

            TabView(selection: $selectedIndex) {
                ForEach(images.indices, id: \.self) { index in
                    if let imageURL = URL(string: images[index].url) {
                        AsyncImage(url: imageURL) { imageView in
                            imageView
                                .resizable()
                                .ignoresSafeArea(.all)
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
            .background(Color.black)
            .ignoresSafeArea(.all)
            .onTapGesture {
                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            }
        }
    }
}
