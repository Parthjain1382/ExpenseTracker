//
//  JsonDecoder.swift
//  Danam2.0
//
//  Created by E5000846 on 29/06/24.
//

import Foundation


class JsonDecoder{
    
    func JsondecoderToDatabase(_ jsonString:String){
        if let jsonData = jsonString.data(using: .utf8) {
            do {
                let database = try JSONDecoder().decode(DataOfUserAndTranscation.self, from: jsonData)
                print(database)
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
}

