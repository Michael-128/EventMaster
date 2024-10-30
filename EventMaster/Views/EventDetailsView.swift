import SwiftUI
import MapKit

struct EventDetailsView: View {
    @ObservedObject var viewModel: EventDetailsViewModel
    
    init(event: Event) {
        self.viewModel = .init(event: event)
    }
    
    var body: some View {
        List {
            Section(header: Text("Wydarzenie")) {
                Label(viewModel.eventName, systemImage: "party.popper")
                if let eventPerformer = viewModel.eventPerformer { Label(eventPerformer, systemImage: "person") }
                if let eventGenre = viewModel.eventGenre { Label(eventGenre, systemImage: "music.mic") }
                if let eventPriceRange = viewModel.eventPriceRange { Label(eventPriceRange, systemImage: "ticket") }
            }.navigationTitle("Szczegóły")
            
            Section(header: Text("Lokalizacja i czas")) {
                Label(viewModel.getFullLocation(), systemImage: "map")
                if let eventVenue = viewModel.eventVenue { Label(eventVenue, systemImage: "location") }
                if let eventDate = viewModel.eventDate, let eventTime = viewModel.eventTime { Label("\(eventTime), \(eventDate)", systemImage: "calendar") }
                else if let eventDate = viewModel.eventDate { Label("\(eventDate)", systemImage: "calendar") }
            }
            
            Section(header: Text("Galeria")) {
                ImageGalleryView(eventImages: viewModel.eventImages)
            }
            
            if let eventSeatMap = viewModel.eventSeatMap {
                Section(header: Text("Układ Sektorów")) {
                    AsyncImageView(url: eventSeatMap, background: .secondary).listRowInsets(EdgeInsets())
                }
            }
        }.listStyle(.insetGrouped)
    }
}
