//
//  Interactor.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift

struct ContrastCheckInteractor {
}


// データ変換を担うべき
// オブザーバ同期への変換を担当する
protocol ContrastCheckUseCase {
    func getResult(input: ContrastCheckInputModel) -> Observable<ResultViewModel>
    func getResult(input: ContrastCheckInputModel, callback: @escaping (ContrastCheckEntity?) -> Void)
}

extension ContrastCheckInteractor: ContrastCheckUseCase {
    func getResult(input: ContrastCheckInputModel) -> Observable<ResultViewModel> {
        guard let repository = dicon.resolve(ContrastCheckRepository.self) else { return .error(AppError.unknown) }
        return repository.fetchResult(input: input)
            .map { return ResultViewModel(ratio: $0.ratio) }
            .observeOn(MainScheduler.asyncInstance)
    }

    func getResult(input: ContrastCheckInputModel, callback: @escaping (ContrastCheckEntity?) -> Void) {
        let closure: (ContrastCheckEntity?) -> Void = { entity in
            DispatchQueue.main.async {
                callback(entity)
            }
        }
        let repository = dicon.resolve(ContrastCheckRepository.self)
        repository?.fetchResult(input: input, callback: closure)
    }
}
