import SwiftUI

struct ImageIndex: Identifiable {
    let id = UUID()
    let value: Int
}

struct ImageGalleryView: View {
    @State public var eventImages: [EventImage]
    @State private var selectedImageIndex: ImageIndex?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 120))], content: {
            ForEach(eventImages.indices, id: \.hashValue) { index in
                let image = eventImages[index]
                if let url = URL(string: image.url) {
                    AsyncImage(url: url) { imageView in
                        imageView
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .onTapGesture {
                                selectedImageIndex = ImageIndex(value: index)
                            }
                    } placeholder: {
                        Image(systemName: "photo")
                            .background(.gray)
                            .frame(width: 100, height: 100)
                    }.cornerRadius(10)
                }
            }
        }).fullScreenCover(item: $selectedImageIndex) { index in
            FullScreenImageView(images: eventImages, selectedIndex: index.value)
        }
    }
}
