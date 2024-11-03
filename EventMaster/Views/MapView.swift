import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let coordinates: CLLocationCoordinate2D
}

// This view displays a map from MapKit with the location of the event
struct MapView: View {
    @State private var region: MKCoordinateRegion
    var locations: [Location] = []
    var eventVenue: String
    
    init(coordinates: CLLocationCoordinate2D, eventVenue: String?) {
        let coordinates = coordinates
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        
        self.region = MKCoordinateRegion(center: coordinates, span: span)
        self.locations.append(Location(coordinates: coordinates))
        self.eventVenue = eventVenue?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapMarker(coordinate: location.coordinates)
        }
            .disabled(true)
            .frame(height: 200)
            .cornerRadius(10)
    }
}
