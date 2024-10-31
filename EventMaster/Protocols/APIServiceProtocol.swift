protocol APIServiceProtocol {
    func fetchEvents(page: Int, sort: String) async throws -> [Event]
    func fetchEventDetails(id: String) async throws -> Event
}
