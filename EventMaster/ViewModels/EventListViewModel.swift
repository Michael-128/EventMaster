import Foundation

class EventListViewModel: ObservableObject {
    let apiService = APIService.shared
    
    @Published public var events: [Event] = []
    @Published public var paginationStatus: PaginationStatus = .ready
    
    @Published public var sortOption: SortOption = .relevance
    @Published public var isAscending: Bool = true
    
    
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
    
    @MainActor
    public func setSortOption(_ sort: SortOption) {
        if(sortOption == sort && sort.allowedDescending) { isAscending.toggle() }
        else { sortOption = sort; isAscending = true }
        
        events = []
        nextPage = 0
        paginationStatus = .ready
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

enum SortOption: String {
    case name = "name"
    case date = "date"
    case relevance = "relevance"
    case distance = "distance"
    case nameDate = "name,date"
    case dateName = "date,name"
    case distanceDate = "distance,date"
    case onSaleStartDate = "onSaleStartDate"
    case id = "id"
    case venueName = "venueName"
    case random = "random"
    
    var displayName: String {
        switch self {
        case .name: return "Nazwa"
        case .date: return "Data"
        case .relevance: return "Trafność"
        case .distance: return "Odległość"
        case .nameDate: return "Nazwa i Data"
        case .dateName: return "Data i Nazwa"
        case .distanceDate: return "Odległość i Data"
        case .onSaleStartDate: return "Data rozpoczęcia sprzedaży"
        case .id: return "ID"
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
