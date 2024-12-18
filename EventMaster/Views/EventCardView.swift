import SwiftUI

struct EventCardView: View {
    @ObservedObject var viewModel: EventCardViewModel
    
    init(event: Event) {
        self.viewModel = EventCardViewModel(event: event)
    }
    
    // This view is a card including event info such as: preview image, title, date, venue name, city
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if let eventPreviewImageURL = viewModel.eventPreviewImageURL {
                AsyncImageView(url: eventPreviewImageURL, background: viewModel.imageBackground)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.eventName).font(.headline).foregroundStyle(.primary)
                
                Group {
                    if let eventDate = viewModel.eventDate { customLabel(eventDate, systemImage: "calendar").accessibilityIdentifier("date") }
                    if let eventCity = viewModel.eventCity { customLabel(eventCity, systemImage: "building.2").accessibilityIdentifier("city") }
                    if let eventVenue = viewModel.eventVenue { customLabel(eventVenue, systemImage: "mappin.and.ellipse").accessibilityIdentifier("venue") }
                    
                }.foregroundStyle(viewModel.textColor)
            }.padding(12)
        }.background(viewModel.textBackground)
        .cornerRadius(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.background)
                .shadow(color: .black.opacity(0.1), radius: 3) 
        )
    }
    
    // Customs label created so that the icon can be displayed with accent color
    func customLabel(_ text: String, systemImage: String) -> some View {
        HStack {
            Image(systemName: systemImage).foregroundStyle(.accent)
            Text(text)
        }
    }
}
