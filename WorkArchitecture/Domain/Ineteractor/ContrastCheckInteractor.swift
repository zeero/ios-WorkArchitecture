//
//  Interactor.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

struct ContrastCheckInteractor {

    private let _repository: ContrastCheckRepository

    init(repository: ContrastCheckRepository) {
        _repository = repository
    }
}


// データ変換を担うべき
// オブザーバ同期への変換を担当する
protocol ContrastCheckUseCase {
    func getResult(fcolor: String, bcolor: String, callback: @escaping (ContrastCheckEntity?) -> Void)
}

extension ContrastCheckInteractor: ContrastCheckUseCase {
    func getResult(fcolor: String, bcolor: String, callback: @escaping (ContrastCheckEntity?) -> Void) {
        let closure: (ContrastCheckEntity?) -> Void = { entity in
            DispatchQueue.main.async {
                callback(entity)
            }
        }
        _repository.fetchResult(fcolor: fcolor, bcolor: bcolor, callback: closure)
    }
}
