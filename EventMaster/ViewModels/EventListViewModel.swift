import Foundation

class EventListViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published public var events: [Event] = []
    @Published public var paginationStatus: PaginationStatus = .ready
    private var nextPage = 0
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents() {
        guard paginationStatus == .ready || paginationStatus == .noMoreData else { return }
        
        paginationStatus = .isLoading
        loadEvents()
    }
    
    private func loadEvents() {
        Task {
            do {
                let newEvents = try await apiService.fetchEvents(page: nextPage)
                await handleSuccess(with: newEvents)
            } catch {
                await handleError(error)
            }
        }
    }
    
    @MainActor
    private func handleSuccess(with fetchedEvents: [Event]) {
        self.events.append(contentsOf: fetchedEvents)
        nextPage += 1
        paginationStatus = fetchedEvents.isEmpty ? .noMoreData : .ready
    }
    
    @MainActor
    private func handleError(_ error: Error) {
        print("Error fetching events: \(error)")
        paginationStatus = .error
    }
}

enum PaginationStatus {
    case ready, isLoading, noMoreData, error
}
