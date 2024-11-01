import SwiftUI

struct FullScreenImageView: View {
    @Environment(\.dismiss) var dismiss
    public let images: [EventImage]
    @State public var selectedIndex: Int
    @State private var isVerticalDismiss: Bool = false

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
                        .verticalDismiss($isVerticalDismiss)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: isVerticalDismiss ?  .never : .automatic))
            .background(Color.black)
            .ignoresSafeArea(.all)
            .onTapGesture { dismiss() }
            .onAppear { selectedIndex = 0 }
        }
    }
}

extension View {
    
}
