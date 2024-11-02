import Foundation

class EventListViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published public var events: [Event] = []
    @Published public var paginationStatus: PaginationStatus = .ready
    
    @Published public var sortOption: SortOption = .relevance
    @Published public var isAscending: Bool = false
    
    
    private var nextPage = 0
    
    init() {
        fetchEvents()
    }
    
    func fetchEvents() {
        if paginationStatus == .isLoading { return }
        
        paginationStatus = .isLoading

        Task {
            do {
                let newEvents = try await apiService.fetchEvents(page: nextPage, sort: getSortOption())
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
    
    public func setSortOption(_ sort: SortOption) {
        if(sortOption == sort && sort.allowedDescending) { isAscending.toggle() }
        else { sortOption = sort; isAscending = true }
        
        events = []
        nextPage = 0
        paginationStatus = .ready
        fetchEvents()
    }
    
    public func getSortOption() -> String {
        if(sortOption == .random) { return sortOption.rawValue }
        if(!isAscending && sortOption.allowedDescending) { return sortOption.rawValue + ",desc" }
        return sortOption.rawValue + ",asc"
    }
}

enum PaginationStatus {
    case ready, isLoading, noMoreData, error
}

enum SortOption: String, CaseIterable {
    case relevance = "relevance"
    case name = "name"
    case date = "date"
    case nameDate = "name,date"
    case dateName = "date,name"
    case venueName = "venueName"
    case random = "random"
    
    var displayName: String {
        switch self {
        case .name: return "Nazwa"
        case .date: return "Data"
        case .relevance: return "Trafność"
        case .nameDate: return "Nazwa i Data"
        case .dateName: return "Data i Nazwa"
        case .venueName: return "Nazwa miejsca"
        case .random: return "Losowo"
        }
    }
    
    var allowedDescending: Bool {
        switch(self) {
        case .name, .date, .relevance, .nameDate, .dateName, .venueName: return true
        default: return false
        }
    }
}
