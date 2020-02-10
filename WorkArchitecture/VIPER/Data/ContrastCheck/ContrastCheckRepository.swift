//
//  ContrastCheckRepository.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift

struct WebAIMAPI {

    private func contrastChecker(input: ContrastCheck.Request) -> Observable<ContrastCheckDataModel> {
        return Observable.create { observer in
            let callback: (ContrastCheckDataModel?) -> Void = { entity in
                if let entity = entity {
                    observer.onNext(entity)
                    observer.onCompleted()
                } else {
                    observer.onError(AppError.apiError)
                }
            }
            self.contrastChecker(input: input, callback: callback)

            return Disposables.create()
        }
    }

    private func contrastChecker(input: ContrastCheck.Request, callback: @escaping (ContrastCheckDataModel?) -> Void) {
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


protocol ContrastCheckRepository {
    func fetchResult(input: ContrastCheck.Request) -> Observable<ContrastCheckDataModel>
//    func fetchResult(input: ContrastCheck.Request, callback: @escaping (ContrastCheckDataModel?) -> Void)
}

extension WebAIMAPI: ContrastCheckRepository {
    func fetchResult(input: ContrastCheck.Request) -> Observable<ContrastCheckDataModel> {
        return contrastChecker(input: input)
    }

    func fetchResult(input: ContrastCheck.Request, callback: @escaping (ContrastCheckDataModel?) -> Void) {
        contrastChecker(input: input, callback: callback)
    }
}
