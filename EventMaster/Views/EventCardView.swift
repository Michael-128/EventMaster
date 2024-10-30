import SwiftUI

struct EventCardView: View {
    @ObservedObject var viewModel: EventCardViewModel
    
    init(event: Event) {
        self.viewModel = EventCardViewModel(event: event)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: viewModel.eventPreviewImageURL) { imageView in
                imageView
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 200)
                    .clipped()
                    .background(viewModel.imageBackground)
            } placeholder: {
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
                    .background(viewModel.imageBackground)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.eventName)
                    .font(.headline)
                
                Group {
                    Label(viewModel.eventDate ?? "no_date", systemImage: "calendar")
                    Label(viewModel.eventCity ?? "no_city", systemImage: "building.2")
                    Label(viewModel.eventVenue ?? "no_venue", systemImage: "mappin.and.ellipse")
                }
                    .font(.caption)
                    .foregroundStyle(viewModel.textColor)
            }
            .padding(12)
        }
        .background(viewModel.textBackground)
        .cornerRadius(10)
        //.shadow(radius: 2)
    }
} 
