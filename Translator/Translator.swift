//
//  Translator.swift
//  Translator
//
//  Created by Bilegt Davaa on 2023-03-22.
//

import Foundation
import Alamofire

class Translator {
    
    struct TranslationResponse: Codable {
        let translations: [Translation]
    }
    
    struct Translation: Codable {
        let text: String
        let to: String
    }
    
    struct DetectedLanguage: Codable {
        let language: String
        let score: Float
    }
    
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
            
            do {
                let translationResponse = try JSONDecoder().decode([TranslationResponse].self, from: data)
                if let translatedText = translationResponse.first?.translations.first?.text {
                    completion(translatedText, nil)
                } else {
                    completion(nil, nil) //Pass an appropriate error in the future
                }
            }
            catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    
    //This function is for detecting the language
    func translate1(text: String, to: [String], completion: @escaping (String?, Error?) -> Void) {
        let route = "/translate?api-version=3.0&to=\(to.joined(separator: "&to="))"
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
            
            do {
                let translationResponse = try JSONDecoder().decode([TranslationResponse].self, from: data)
                if let translatedText = translationResponse.first?.translations.first?.text {
                    completion(translatedText, nil)
                } else {
                    completion(nil, nil) //Pass an appropriate error in the future
                }
            }
            catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
    





    
}
