//
//  LandmarkList.swift
//  Landmarks
//
//  Created by Chris Orellana on 8/23/23.
//

import SwiftUI

struct LandmarkList: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showFavoritesOnly = false
    
    // Create a filtered variable containing only the rows of landmarks that are set as favorite
    
    // Basically per Landmark in the landmarks array, if the landmark.isFavorite is false, but !showFavoritesOnly is true, then the landmark will be included in the array. Basically this is a smart way to add all the items in the landmarks array to be shown.
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
            
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        // When the Navigation link is clicked it will take it to the LandMark Detail
                        // And the label will be the Landmark Row
                        LandmarkRow(landmark: landmark)
                    }
                }
                
            }
            .navigationTitle("Landmarks")
        }
        
        
    }
}

struct LandmarkList_Previews: PreviewProvider {
    static var previews: some View {
            LandmarkList()
            .environmentObject(ModelData())
    }
}
