import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel = .init()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach(viewModel.events, id: \.id) {
                        event in
                        VStack {
                            AsyncImage(url: URL(string: event.images[0].url))
                            Text("\(event.name)")
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Wydarzenia")
            }
        }
    }
}
