//
//  Landmark.swift
//  Landmarks
//
//  Created by Chris Orellana on 8/22/23.
//

import Foundation
import SwiftUI
import CoreLocation

// So here I am defining essentially the data I am expecting from a JSON file, using the Codable protocol
// I will use this in my Model Data to load my json file stored locally and then parse it so that I can make
// An array of landmarks that conform the format below

struct Landmark: Hashable, Codable, Identifiable {
    
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var isFavorite: Bool
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double 
    }
}

