import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel
    @State private var isLoading: Bool
    
    init() {
        let viewModel: EventListViewModel = .init()
        self.viewModel = viewModel
        self.isLoading = viewModel.apiService.apiKey == nil
    }
    
    // The view will ask you for an API key if it's not provided already.
    // Othewise is will display a list of events.
    var body: some View {
        if isLoading {
            AppLoadingView().askForApiKey(then: { viewModel.fetchEvents(); isLoading = false })
        } else {
            NavigationStack {
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.events, id: \.id) { event in
                            NavigationLink {
                                EventDetailsView(event: event)
                                    .navigationTitle("Szczegóły")
                            } label: {
                                EventCardView(event: event)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        lastRowView()
                    }
                }
                .toolbar { toolbarMenu() }
                .navigationTitle("Wydarzenia")
            }
        }
    }
    
    // This view handles pagination. If it becomes visible, new items are loaded
    func lastRowView() -> some View {
        ZStack(alignment: .center) {
            switch viewModel.paginationStatus {
            case .isLoading:
                ProgressView()
            case .ready, .noMoreData:
                EmptyView()
            case .error:
                Text("Wystąpił problem")
            }
        }
        .frame(height: 50)
        .accessibilityIdentifier("lastRowView")
        .onAppear { viewModel.fetchEvents() }
    }

    // This is a toolbar that contains a menu where you can sort items
    func toolbarMenu() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Menu {
                ForEach(SortOption.allCases, id: \.self) { sortOption in
                    Button {
                        viewModel.setSortOption(sortOption)
                    } label: {
                        Text(sortOption.displayName)
                        if sortOption == viewModel.sortOption {
                            if viewModel.isAscending {
                                Image(systemName: "arrow.up")
                            } else {
                                Image(systemName: "arrow.down")
                            }
                        }
                    }
                }
            } label: {
                Image(systemName: "arrow.up.arrow.down.circle")
            }
        }
    }
}
