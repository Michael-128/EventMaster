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
                            } label: {
                                EventCardView(event: event)
                                    .padding(.horizontal)
                                    .padding(.vertical, 8)
                            }.buttonStyle(PlainButtonStyle())
                        }
                        lastRowView(viewModel)
                    }
                }
                .navigationTitle("Wydarzenia")
            }
        }
    }
}

func lastRowView(_ viewModel: EventListViewModel) -> some View {
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
