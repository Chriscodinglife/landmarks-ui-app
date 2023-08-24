//
//  LandmarkDetail.swift
//  Landmarks
//
//  Created by Chris Orellana on 8/23/23.
//

import SwiftUI

struct LandmarkDetail: View {
    var landmark: Landmark
    
    var body: some View {
        
        VStack {
//            MapView()
//                .ignoresSafeArea(edges: .top)
//                .frame(height: 300)
            
            CircleImage(image: landmark.image)
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                HStack {
                    Text(landmark.park)
                    Spacer()
                    Text(landmark.state)
                    
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                Divider()
                
                Text(landmark.description)
                    .font(.title2)
                Text("Honestly, I never been here 😪")
                
            }
            .padding()
            Spacer()
            
        }
    }
}

struct LandmarkDetail_Previews: PreviewProvider {
    static var previews: some View {
        LandmarkDetail(landmark: landmarks[0])
    }
}
