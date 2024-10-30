struct Event: Decodable {
    let id: String
    let name: String
    let dates: Dates
    let images: [Image]
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

    struct Image: Decodable {
        let ratio: String?
        let url: String
        let width: Int?
        let height: Int?
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
        let venues: [Venue]
        let attractions: [Attraction]

        struct Venue: Decodable {
            let name: String
            let city: City
            let country: Country
            let address: Address
            
            struct City: Decodable {
                let name: String
            }

            struct Country: Decodable {
                let name: String
            }

            struct Address: Decodable {
                let line1: String
            }
        }

        struct Attraction: Decodable {
            let name: String
            let classifications: [Classification]

            struct Classification: Decodable {
                let genre: Genre

                struct Genre: Decodable {
                    let name: String
                }   
            }
        }
    }
}
