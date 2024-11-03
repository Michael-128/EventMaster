@testable import EventMaster

public let mockEvents: [Event] = [
    Event(
        id: "mock1",
        name: "Koncert",
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
                currency: "PLN",
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
                    name: "Przykładowa Lokalizacja",
                    city: Event.Embedded.Venue.City(name: "Warszawa"),
                    country: Event.Embedded.Venue.Country(name: "Polska"),
                    address: Event.Embedded.Venue.Address(line1: "123 Przykładowa Ulica")
                )
            ],
            attractions: [
                Event.Embedded.Attraction(
                    name: "Przykładowy Artysta",
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
        name: "Mecz",
        dates: Event.Dates(
            start: Event.Dates.Start(
                localDate: "2024-05-20",
                localTime: nil
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
                type: "standard",
                currency: "PLN",
                min: 50.0,
                max: 200.0
            ),
            Event.PriceRange(
                type: "standard including fees",
                currency: "PLN",
                min: 75.0,
                max: 250.0
            )
        ],
        seatmap: Event.Seatmap(
            staticUrl: "https://example.com/arena-seatmap.jpg"
        ),
        _embedded: Event.Embedded(
            venues: [
                Event.Embedded.Venue(
                    name: "Przykładowe Boisko",
                    city: Event.Embedded.Venue.City(name: "Kraków"),
                    country: Event.Embedded.Venue.Country(name: "Polska"),
                    address: Event.Embedded.Venue.Address(line1: "456 Ulica")
                )
            ],
            attractions: [
                Event.Embedded.Attraction(
                    name: "Drużyna1 vs Drużyna2",
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

