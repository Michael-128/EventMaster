import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel = .init()
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    ForEach(viewModel.events, id: \.id) { event in
                        NavigationLink {
                            EventDetailsView(event: event)
                        } label: {
                            EventCardView(event: event)
                                .padding(.horizontal)
                                .padding(.vertical, 8)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationTitle("Wydarzenia")
            }
        }
    }
}
