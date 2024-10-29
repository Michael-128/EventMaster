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
