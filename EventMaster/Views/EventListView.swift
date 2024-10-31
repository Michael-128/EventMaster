import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel = .init()
    
    var body: some View {
        VStack {
            NavigationView {
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
        .onAppear { viewModel.fetchEvents() }
    }

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
