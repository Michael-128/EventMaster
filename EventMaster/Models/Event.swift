struct Event: Decodable {
    let id: String
    let name: String
    let dates: Dates
    let images: [EventImage]
    let priceRanges: [PriceRange]?
    let seatmap: Seatmap?
    let _embedded: Embedded

    struct Dates: Decodable {
        let start: Start

        struct Start: Decodable {
            let localDate: String
            let localTime: String?
        }
    }

    struct PriceRange: Decodable {
        let type: String
        let currency: String
        let min: Double
        let max: Double
    }

    struct Seatmap: Decodable {
        let staticUrl: String?
    }

    struct Embedded: Decodable {
        let venues: [Venue]?
        let attractions: [Attraction]?

        struct Venue: Decodable {
            let name: String
            let city: City?
            let country: Country?
            let address: Address?
            let location: Location?
            
            struct City: Decodable {
                let name: String
            }

            struct Country: Decodable {
                let name: String
            }

            struct Address: Decodable {
                let line1: String?
            }
            
            struct Location: Decodable {
                let latitude: String?
                let longitude: String?
            }
        }

        struct Attraction: Decodable {
            let name: String
            let classifications: [Classification]?

            struct Classification: Decodable {
                let genre: Genre?

                struct Genre: Decodable {
                    let name: String
                }   
            }
        }
    }
}
