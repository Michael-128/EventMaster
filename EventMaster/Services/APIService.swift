import Foundation

// This service handles all Ticketmaster API requests
class APIService: APIServiceProtocol {
    public static let shared = APIService()
    
    private let baseURL = "https://app.ticketmaster.com"
    public var apiKey: String? = AppEnvironment.apiKey

    // Function that takes url path and queryItems then returns fetched data
    private func fetch(_ url: String, _ queryItems: [URLQueryItem] = []) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        // Merge query items that should always be included with additional query items
        components.queryItems = [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "locale", value: "pl,en")] + queryItems
        // Ensure the percent encoding is done properly
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }

    // This function uses the general fetch function then decodes and returns the fetched data (event list)
    func fetchEvents(page: Int = 0, sort: String = "relevance,desc") async throws -> [Event] {
        let data = try await fetch("\(baseURL)/discovery/v2/events.json", [URLQueryItem(name: "countryCode", value: "PL"), URLQueryItem(name: "page", value: "\(page)"), URLQueryItem(name: "sort", value: sort)])
        return try JSONDecoder().decode(EventsResponse.self, from: data).events
    }

    // This function uses the general fetch function then decodes and returns the fetched data (event details)
    func fetchEventDetails(id: String) async throws -> Event {
        let data = try await fetch("\(baseURL)/discovery/v2/events/\(id).json")
        return try JSONDecoder().decode(Event.self, from: data)
    }
}
