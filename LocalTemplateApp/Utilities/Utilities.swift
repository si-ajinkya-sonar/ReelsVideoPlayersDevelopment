//
//  Utilities.swift
//  LocalTemplateApp
//
//  Created by Kiran Padhiyar on 18/07/25.
//

import Foundation

final class Utilities {
    
    static func loadJson<T: Decodable>(from fileName: String, as type: T.Type) -> T? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            print("Error Decoding Data: \(error)")
            return nil
        }
    }
    
    static func loadRawJson(from fileName: String) -> Any? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String: Any]
        } catch {
            print("Error Decoding Data: \(error)")
            return nil
        }
    }
}
