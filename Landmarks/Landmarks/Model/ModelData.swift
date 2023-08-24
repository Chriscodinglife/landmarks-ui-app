//
//  ModelData.swift
//  Landmarks
//
//  Created by Chris Orellana on 8/22/23.
//

import Foundation

var landmarks: [Landmark] = load("landmarkData.json")

// The load function below is for loading in a file and to conform it to a specific type.
// In the landmarks variable above, I pass in the expected type of [Array] of "Landmark" which is exactly the struct we created in the Landmark.swift file
// Thanks to the load function, I can ensure the type I am expecting is of Landmark and that is it can be read using the Decodable protocol, which is part of the
// Codable protocol

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load file \(filename) from main bundle: \(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Could not decode \(filename) as \(T.self): \(error)")
    }
    
}
