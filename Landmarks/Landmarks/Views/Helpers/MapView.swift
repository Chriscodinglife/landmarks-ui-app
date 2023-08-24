//
//  MapView.swift
//  Landmarks
//
//  Created by Chris Orellana on 8/22/23.
//

import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    
    // Using @State allows the user interface and this region variable to updated as changes are made. This makes it so the user can interact with the map
    
    // We also set a default for the region location using MKCoordinateRegion and setting the center and span
    @State private var region = MKCoordinateRegion()
    
    // Here we declare the view and make a binding (two way connection
    // for region
    
    var body: some View {
        Map(coordinateRegion: $region)
            .onAppear {
                setRegion(coordinate)
            }
    }
    
    // This method below will update the region that was set
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166_868))
    }
}
