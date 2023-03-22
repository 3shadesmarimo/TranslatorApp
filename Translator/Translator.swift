//
//  Translator.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-03-22.
//

import Foundation

class Translator {
    private let key: String
    private let endpoint: String
    private let location: String

    init(key: String, endpoint: String, location: String) {
        self.key = key
        self.endpoint = endpoint
        self.location = location
    }

    func translate(text: String, from: String, to: [String], completion: @escaping (String?, Error?) -> Void) {
        let route = "/translate?api-version=3.0&from=\(from)&to=\(to.joined(separator: "&to="))"
        let body: [Any] = [ ["Text": text] ]
        guard let requestBody = try? JSONSerialization.data(withJSONObject: body, options: []) else {
            completion(nil, nil) // or pass an appropriate error
            return
        }

        var request = URLRequest(url: URL(string: endpoint + route)!)
        request.httpMethod = "POST"
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(key, forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        request.setValue(location, forHTTPHeaderField: "Ocp-Apim-Subscription-Region")

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }

            if let result = String(data: data, encoding: .utf8) {
                completion(result, nil)
            } else {
                completion(nil, nil) // or pass an appropriate error
            }
        }
        task.resume()
    }
}
