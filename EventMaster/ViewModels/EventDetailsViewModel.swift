import SwiftUI
import EventKit

class EventDetailsViewModel: ObservableObject {
    private var event: Event?
    @Published public var eventId: String
    @Published public var eventName: String?
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
    
    @Published public var fetchStatus: FetchStatus = .isLoading

    /*init(event: Event) {
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
    }*/
    
    init(eventId: String) {
        self.eventId = eventId
    }
    
    func fetchEventDetails() async {
        do {
            let event = try await APIService.shared.fetchEventDetails(id: self.eventId)
            
            DispatchQueue.main.async {
                self.event = event
                self.eventName = event.name
                self.eventPerformer = self.fetchPerformer(from: event)
                self.eventDate = self.fetchEventDate(from: event)
                self.eventTime = self.fetchEventTime(from: event)
                self.eventCountry = self.fetchCountry(from: event)
                self.eventCity = self.fetchCity(from: event)
                self.eventVenue = self.fetchVenue(from: event)
                self.eventAddress = self.fetchAddress(from: event)
                self.eventGenre = self.fetchGenre(from: event)
                self.eventPriceRange = self.fetchPriceRange(from: event)
                self.eventImages = event.images
                self.eventSeatMap = self.fetchSeatMapURL(from: event)
                self.fetchStatus = .ready
            }
        } catch {
            print("Error fetching event details: \(error)")
            fetchStatus = .error
            //await self.dismiss()
        }
    }
    
    private func fetchPerformer(from event: Event) -> String? {
        return event._embedded.attractions?.first?.name
    }

    private func fetchEventDate(from event: Event) -> String? {
        return try? CustomDateFormatter.shared.formatFromISO(date: event.dates.start.localDate)
    }

    private func fetchEventTime(from event: Event) -> String? {
        guard let localTime = event.dates.start.localTime else { return nil }
        return CustomDateFormatter.shared.formatTime(time: localTime)
    }

    private func fetchCountry(from event: Event) -> String? {
        return event._embedded.venues?.first?.country?.name
    }

    private func fetchCity(from event: Event) -> String? {
        return event._embedded.venues?.first?.city?.name
    }

    private func fetchVenue(from event: Event) -> String? {
        return event._embedded.venues?.first?.name
    }

    private func fetchAddress(from event: Event) -> String? {
        return event._embedded.venues?.first?.address?.line1
    }

    private func fetchGenre(from event: Event) -> String? {
        return event._embedded.attractions?.first?.classifications?.first?.genre?.name
    }

    private func fetchPriceRange(from event: Event) -> String? {
        guard let priceRange = event.priceRanges?.first(where: { $0.type.contains("including fees") }) ?? event.priceRanges?.first else { return nil }
        let minPrice = Int(priceRange.min.rounded())
        let maxPrice = Int(priceRange.max.rounded())
        
        var priceRangeString = ""
        if priceRange.min == priceRange.max {
            priceRangeString = "\(minPrice) \(priceRange.currency)"
        } else {
            priceRangeString = "\(minPrice)-\(maxPrice) \(priceRange.currency)"
        }
        
        return priceRange.type.contains("including fees") ? priceRangeString + " (opłaty wliczone)" : priceRangeString
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
    
    func getEventDate() -> String? {
        if let eventDate = self.eventDate, let eventTime = self.eventTime { return "\(eventTime), \(eventDate)" }
        if let eventDate = self.eventDate { return "\(eventDate)" }
        return nil
    }
    
    
    func addEventToCalendar() {
        guard let eventDate = self.event?.dates.start.localDate else { return }
        
        let eventStore = EKEventStore()
        
        eventStore.requestAccess(to: .event) { granted, error in
            if granted {
                let calendarEvent = EKEvent(eventStore: eventStore)
                guard let startDate = try? CustomDateFormatter.shared.dateFromISO(date: eventDate) else { return }
                let endDate = startDate.addingTimeInterval(3600)
                
                calendarEvent.title = self.eventName
                calendarEvent.startDate = startDate
                calendarEvent.endDate = endDate
                calendarEvent.calendar = eventStore.defaultCalendarForNewEvents
                
                do { try eventStore.save(calendarEvent, span: .thisEvent) }
                catch { print("Error saving event to calendar: \(error)") }
            }
        }
    }
}

enum FetchStatus {
    case ready, isLoading, error
}
