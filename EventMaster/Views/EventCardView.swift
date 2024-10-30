import SwiftUI

struct EventCardView: View {
    @ObservedObject var viewModel: EventCardViewModel
    
    init(event: Event) {
        self.viewModel = EventCardViewModel(event: event)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let eventPreviewImageURL = viewModel.eventPreviewImageURL {
                AsyncImageView(url: eventPreviewImageURL, background: viewModel.imageBackground)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.eventName)
                    .font(.headline)
                
                Group {
                    if let eventDate = viewModel.eventDate { Label(eventDate, systemImage: "calendar") }
                    if let eventCity = viewModel.eventCity { Label(eventCity, systemImage: "building.2") }
                    if let eventVenue = viewModel.eventVenue { Label(eventVenue, systemImage: "mappin.and.ellipse") }
                    
                }
                    .font(.caption)
                    .foregroundStyle(viewModel.textColor)
            }
            .padding(12)
        }
        .background(viewModel.textBackground)
        .cornerRadius(10)
    }
}