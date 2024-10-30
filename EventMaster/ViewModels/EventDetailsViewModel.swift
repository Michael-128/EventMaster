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
        self.eventId = event.id
        self.eventName = event.name
        self.eventPerformer = fetchPerformer(from: event)
        self.eventDate = fetchEventDate(from: event)
        self.eventTime = fetchEventTime(from: event)
        self.eventCountry = fetchCountry(from: event)
        self.eventCity = fetchCity(from: event)
        self.eventVenue = fetchVenue(from: event)
        self.eventAddress = fetchAddress(from: event)
        self.eventGenre = fetchGenre(from: event)
        self.eventPriceRange = fetchPriceRange(from: event)
        self.eventImages = event.images
        self.eventSeatMap = fetchSeatMapURL(from: event)
    }
    
    private func fetchPerformer(from event: Event) -> String? {
        return event._embedded.attractions.first?.name
    }

    private func fetchEventDate(from event: Event) -> String? {
        return try? CustomDateFormatter.shared.formatFromISO(date: event.dates.start.localDate)
    }

    private func fetchEventTime(from event: Event) -> String? {
        guard let localTime = event.dates.start.localTime else { return nil }
        return CustomDateFormatter.shared.formatTime(time: localTime)
    }

    private func fetchCountry(from event: Event) -> String? {
        return event._embedded.venues.first?.country.name
    }

    private func fetchCity(from event: Event) -> String? {
        return event._embedded.venues.first?.city.name
    }

    private func fetchVenue(from event: Event) -> String? {
        return event._embedded.venues.first?.name
    }

    private func fetchAddress(from event: Event) -> String? {
        return event._embedded.venues.first?.address.line1
    }

    private func fetchGenre(from event: Event) -> String? {
        return event._embedded.attractions.first?.classifications.first?.genre.name
    }

    private func fetchPriceRange(from event: Event) -> String? {
        guard let priceRange = event.priceRanges?.first else { return nil }
        let minPrice = Int(priceRange.min.rounded())
        let maxPrice = Int(priceRange.max.rounded())
        
        if priceRange.min == priceRange.max {
            return "\(minPrice) \(priceRange.currency)"
        } else {
            return "Od \(minPrice) \(priceRange.currency) do \(maxPrice) \(priceRange.currency)"
        }
    }

    private func fetchSeatMapURL(from event: Event) -> URL? {
        guard let seatMapURL = event.seatmap?.staticUrl else { return nil }
        return URL(string: seatMapURL)
    }
    
    func getFullLocation() -> String {
        var location: [String] = []
        if let eventCountry = eventCountry { location.append(eventCountry.trimmingCharacters(in: .whitespacesAndNewlines)) }
        if let eventCity = eventCity { location.append(eventCity.trimmingCharacters(in: .whitespacesAndNewlines)) }
        if let eventAddress = eventAddress { location.append(eventAddress.trimmingCharacters(in: .whitespacesAndNewlines)) }
        return location.joined(separator: ", ")
    }
}