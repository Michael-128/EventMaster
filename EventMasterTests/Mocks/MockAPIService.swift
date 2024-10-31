@testable import EventMaster
import Foundation

class MockAPIService: APIServiceProtocol {
    private let mockEvents: [Event] = [
        Event(
            id: "mock1",
            name: "Mock Concert",
            dates: Event.Dates(
                start: Event.Dates.Start(
                    localDate: "2024-04-15",
                    localTime: "20:00:00"
                )
            ),
            images: [
                EventImage(
                    ratio: "16_9",
                    url: "https://example.com/image1.jpg",
                    width: 1024,
                    height: 576,
                    fallback: false
                )
            ],
            priceRanges: [
                Event.PriceRange(
                    type: "standard",
                    currency: "USD",
                    min: 50.0,
                    max: 150.0
                )
            ],
            seatmap: Event.Seatmap(
                staticUrl: "https://example.com/seatmap1.jpg"
            ),
            _embedded: Event.Embedded(
                venues: [
                    Event.Embedded.Venue(
                        name: "Mock Venue",
                        city: Event.Embedded.Venue.City(name: "New York"),
                        country: Event.Embedded.Venue.Country(name: "United States"),
                        address: Event.Embedded.Venue.Address(line1: "123 Mock Street")
                    )
                ],
                attractions: [
                    Event.Embedded.Attraction(
                        name: "Mock Artist",
                        classifications: [
                            Event.Embedded.Attraction.Classification(
                                genre: Event.Embedded.Attraction.Classification.Genre(name: "Rock")
                            )
                        ]
                    )
                ]
            )
        ),
        Event(
            id: "mock2",
            name: "Basketball Championship",
            dates: Event.Dates(
                start: Event.Dates.Start(
                    localDate: "2024-05-20",
                    localTime: "19:30:00"
                )
            ),
            images: [
                EventImage(
                    ratio: "3_2",
                    url: "https://example.com/basketball.jpg",
                    width: 1200,
                    height: 800,
                    fallback: false
                )
            ],
            priceRanges: [
                Event.PriceRange(
                    type: "standard including fees",
                    currency: "USD",
                    min: 75.0,
                    max: 250.0
                ),
                Event.PriceRange(
                    type: "standard",
                    currency: "USD",
                    min: 50.0,
                    max: 200.0
                )
            ],
            seatmap: Event.Seatmap(
                staticUrl: "https://example.com/arena-seatmap.jpg"
            ),
            _embedded: Event.Embedded(
                venues: [
                    Event.Embedded.Venue(
                        name: "City Arena",
                        city: Event.Embedded.Venue.City(name: "Los Angeles"),
                        country: Event.Embedded.Venue.Country(name: "United States"),
                        address: Event.Embedded.Venue.Address(line1: "456 Sports Boulevard")
                    )
                ],
                attractions: [
                    Event.Embedded.Attraction(
                        name: "LA vs NY Championship Game",
                        classifications: [
                            Event.Embedded.Attraction.Classification(
                                genre: Event.Embedded.Attraction.Classification.Genre(name: "Sports")
                            )
                        ]
                    )
                ]
            )
        )
    ]
    
    func fetchEvents(page: Int) async throws -> [Event] {
        let eventsPerPage = 1
        let startIndex = (page - 1) * eventsPerPage
        let endIndex = min(startIndex + eventsPerPage, mockEvents.count)
        
        guard startIndex < mockEvents.count else {
            return []
        }
        
        return Array(mockEvents[startIndex..<endIndex])
    }
    
    func fetchEventDetails(id: String) async throws -> Event {
        guard let event = mockEvents.first(where: { $0.id == id }) else {
            throw NSError(domain: "MockAPIService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Event not found"])
        }
        return event
    }
}

