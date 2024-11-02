//

import Testing
@testable import EventMaster

struct EventMasterTests {

    

    @Test func fetchEvents() async throws {
        guard let event = mockEvents.first else { return }
        
        let eventDetailsViewModel = EventDetailsViewModel(event: event)
        
        eventDetailsViewModel.fetchPerformer(from: event) {
            
        }
    }

}


/**private func fetchPerformer(from event: Event) -> String? {
 return event._embedded.attractions?.first?.name
}
*/
