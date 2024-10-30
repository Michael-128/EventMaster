import Foundation

class EventListViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published public var events: [Event] = []
    
    init() {
        Task {
            await self.refreshEvents()
        }
    }
    
    func refreshEvents() async {
        do {
            let fetchedEvents = try await self.apiService.fetchEvents()

            await MainActor.run {
                self.events = fetchedEvents
            }
        } catch {
            print("Error fetching events: \(error)")
        }
    }
}
