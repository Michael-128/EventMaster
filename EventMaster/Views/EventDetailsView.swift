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
                Label(viewModel.eventPerformer ?? "no_performer", systemImage: "person")
                Label(viewModel.eventGenre ?? "no_genre", systemImage: "music.mic")
                Label(viewModel.eventPriceRange ?? "no_price_range", systemImage: "ticket")
            }
            
            Section(header: Text("Lokalizacja i czas")) {
                Label("\(viewModel.eventCountry ?? "no_country"), \(viewModel.eventCity ?? "no_city"), \(viewModel.eventAddress ?? "no_venue")", systemImage: "map")
                Label("\(viewModel.eventTime ?? "no_time"), \(viewModel.eventDate ?? "no_date")", systemImage: "calendar")
            }
            
            Section(header: Text("Galeria")) {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80, maximum: 120))], spacing: 10) {
                    ForEach(viewModel.eventImages, id: \.hashValue) { image in
                        AsyncImage(url: URL(string: image.url)) { phase in
                            switch phase {
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 80, height: 80)
                                    .clipped()
                            case .failure(_):
                                Image(systemName: "photo")
                                    .frame(width: 80, height: 80)
                            case .empty:
                                ProgressView()
                                    .frame(width: 80, height: 80)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    }
                }
            }
            
            Section(header: Text("Układ Sektorów")) {
                AsyncImage(url: viewModel.eventSeatMap) { imageView in
                    imageView
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 200)
                        .clipped()
                        .padding(0)
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
                }.listRowInsets(EdgeInsets())
                
            }
            
            .navigationTitle("Szczegóły")
        }.listStyle(.insetGrouped)
    }
}

