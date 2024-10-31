import SwiftUI

class EventCardViewModel: ObservableObject {
    @Environment(\.colorScheme) var colorScheme
    
    private var colorCache: [String: Color] = [:]
    
    @Published public var eventId: String
    @Published public var eventName: String
    @Published public var eventDate: String?
    @Published public var eventCity: String?
    @Published public var eventVenue: String?
    @Published public var eventPreviewImageURL: URL?
    
    @Published public var imageBackground: Color = .primary.opacity(0.2)
    @Published public var textBackground: Color = .primary.opacity(0.1)
    @Published public var textColor: Color = .primary.opacity(0.85)
    
    init(event: Event) {
        self.eventId = event.id
        self.eventName = event.name
        self.eventDate = fetchEventDate(from: event)
        self.eventCity = fetchEventCity(from: event)
        self.eventVenue = fetchEventVenue(from: event)
        self.eventPreviewImageURL = fetchPreviewImageURL(from: event)
    }
    
    private func fetchEventDate(from event: Event) -> String? {
        return try? CustomDateFormatter.shared.formatFromISO(date: event.dates.start.localDate)
    }

    private func fetchEventCity(from event: Event) -> String? {
        return event._embedded.venues?.first?.city?.name
    }

    private func fetchEventVenue(from event: Event) -> String? {
        return event._embedded.venues?.first?.name
    }

    private func fetchPreviewImageURL(from event: Event) -> URL? {
        let sortedImages = event.images.sorted(by: { ($0.width ?? 0) > ($1.width ?? 0) })
        
        if let preferredImage = sortedImages.first(where: { $0.ratio == "16_9" && !$0.fallback }) {
            return URL(string: preferredImage.url)
        } else if let fallbackImage = sortedImages.first {
            return URL(string: fallbackImage.url)
        }
        return nil
    }
}
