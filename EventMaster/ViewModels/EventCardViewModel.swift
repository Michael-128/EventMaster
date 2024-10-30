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
        do {
            self.eventId = event.id
            self.eventName = event.name
            self.eventDate = try CustomDateFormatter.shared.formatFromISO(date: event.dates.start.localDate)
            if let eventVenue = event._embedded.venues.first {
                self.eventCity = eventVenue.city.name
                self.eventVenue = eventVenue.name
            }
            if let eventPreviewImage = event.images.first {
                self.eventPreviewImageURL = URL(string: eventPreviewImage.url)
            }
        } catch {
            print("Error: \(error)")
        }
    }
}

