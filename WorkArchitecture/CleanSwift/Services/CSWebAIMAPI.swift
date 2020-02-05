//
//  CSWebAIMAPI.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/02/04.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

class CSWebAIMAPI {
    
    func contrastChecker(input: CSContrastCheck.GetResult.Request, callback: @escaping (ContrastCheckDataModel?) -> Void) {
        var components = URLComponents(string: "https://webaim.org/resources/contrastchecker/")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "fcolor", value: input.fg),
            URLQueryItem(name: "bcolor", value: input.bg),
            URLQueryItem(name: "api", value: nil)
        ]
        components.queryItems = queryItems
        let url = components.url!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response {
                print(response)
                let entity = try? JSONDecoder().decode(ContrastCheckDataModel.self, from: data)
                callback(entity)
            } else {
                print(error ?? "Error")
                callback(nil)
            }
        }
        task.resume()
    }
}
