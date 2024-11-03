import SwiftUI

// This view creates an AsyncImage() and defines a placeholder for when the image is loading
struct AsyncImageView: View {
    @State public var url: URL
    @State public var background: Color
    
    var body: some View {
        AsyncImage(url: self.url) { imageView in
            imageView
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipped()
                .background(background)
        } placeholder: { asyncImagePlaceholder(background) }
    }
    
    func asyncImagePlaceholder(_ background: Color) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            Spacer()
        }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .frame(height: 200)
            .background(background)
    }
}
