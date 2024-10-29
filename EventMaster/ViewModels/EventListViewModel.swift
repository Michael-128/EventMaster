import Foundation

class EventListViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published public var events: [Event] = []
    
    init() {
        self.refreshEvents()
    }
    
    func refreshEvents() {
        DispatchQueue.main.async {
            Task {
                do {
                    self.events = try await self.apiService.fetchEvents()
                } catch {
                    print(error)
                }
            }
        }
    }
}
