import SwiftUI

struct EventListView: View {
    @ObservedObject var viewModel: EventListViewModel = .init()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.events, id: \.id) {
                    event in
                    Text("\(event.name)")
                }
            }
        }
    }
}
