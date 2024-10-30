import Foundation

class APIService {
    public static let shared = APIService()
    
    private let baseURL = "https://app.ticketmaster.com"
    private let apiKey = AppEnvironment.apiKey

    private func fetch(_ url: String, _ queryItems: [URLQueryItem] = []) async throws -> Data {
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }

        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }

        components.queryItems = [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "locale", value: "pl,en")] + queryItems
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: url)

        return data
    }

    func fetchEvents() async throws -> [Event] {
        let data = try await fetch("\(baseURL)/discovery/v2/events.json", [URLQueryItem(name: "countryCode", value: "PL")])
        return try JSONDecoder().decode(EventsResponse.self, from: data).events
    }

    func fetchEventDetails(id: String) async throws -> Event {
        let data = try await fetch("\(baseURL)/discovery/v2/events/\(id).json")
        return try JSONDecoder().decode(Event.self, from: data)
    }
}
