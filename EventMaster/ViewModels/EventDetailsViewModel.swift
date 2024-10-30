import SwiftUI

class EventDetailsViewModel: ObservableObject {
    @Published public var eventId: String
    @Published public var eventName: String
    @Published public var eventPerformer: String?
    @Published public var eventDate: String?
    @Published public var eventTime: String?
    @Published public var eventCountry: String?
    @Published public var eventCity: String?
    @Published public var eventVenue: String?
    @Published public var eventAddress: String?
    @Published public var eventGenre: String?
    @Published public var eventPriceRange: String?
    @Published public var eventImages: [EventImage] = []
    @Published public var eventSeatMap: URL?
    
    init(event: Event) {
        do {
            self.eventId = event.id
            self.eventName = event.name
            if let attraction = event._embedded.attractions.first {
                self.eventPerformer = attraction.name
            }
            self.eventDate = try CustomDateFormatter.shared.formatFromISO(date: event.dates.start.localDate)
            self.eventTime = event.dates.start.localTime
            if let eventVenue = event._embedded.venues.first {
                self.eventCountry = eventVenue.country.name
                self.eventCity = eventVenue.city.name
                self.eventVenue = eventVenue.name
                self.eventAddress = eventVenue.address.line1
            }
            if let attraction = event._embedded.attractions.first, let classification = attraction.classifications.first {
                self.eventGenre = classification.genre.name
            }
            if let priceRanges = event.priceRanges, let priceRange = priceRanges.first {
                self.eventPriceRange = "\(priceRange.min)-\(priceRange.max) \(priceRange.currency)"
            }
            self.eventImages = event.images
            if let seatMap = event.seatmap, let seatMapURL = seatMap.staticUrl {
                self.eventSeatMap = URL(string: seatMapURL)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

