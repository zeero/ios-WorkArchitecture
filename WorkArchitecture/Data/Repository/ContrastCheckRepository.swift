//
//  ContrastCheckRepository.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

struct WebAIMAPI {

    private func contrastChecker(fcolor: String, bcolor: String, callback: @escaping (ContrastCheckEntity?) -> Void) {
        var components = URLComponents(string: "https://webaim.org/resources/contrastchecker/")!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "fcolor", value: fcolor),
            URLQueryItem(name: "bcolor", value: bcolor),
            URLQueryItem(name: "api", value: nil)
        ]
        components.queryItems = queryItems
        let url = components.url!

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let response = response {
                print(response)
                let entity = try? JSONDecoder().decode(ContrastCheckEntity.self, from: data)
                callback(entity)
            } else {
                print(error ?? "Error")
                callback(nil)
            }
        }
        task.resume()
    }
}


protocol ContrastCheckRepository {
    func fetchResult(fcolor: String, bcolor: String, callback: @escaping (ContrastCheckEntity?) -> Void)
}

extension WebAIMAPI: ContrastCheckRepository {
    func fetchResult(fcolor: String, bcolor: String, callback: @escaping (ContrastCheckEntity?) -> Void) {
        contrastChecker(fcolor: fcolor, bcolor: bcolor, callback: callback)
    }
}
