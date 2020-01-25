//
//  Presenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift

class ViewPresenter {

    private let disposeBag = DisposeBag()

    private weak var _view: View?
    private let _router: Wireframe

    init(view: View, router: Wireframe) {
        _view = view
        _router = router
    }
}


protocol ViewPresentation {
    func checkContrast(input: ContrastCheckInputModel)
}

extension ViewPresenter: ViewPresentation {
    func checkContrast(input: ContrastCheckInputModel) {
        guard let interactor = dicon.resolve(ContrastCheckUseCase.self) else { return }
        interactor.getResult(input: input).subscribe(
            onNext: { [weak self] model in
                self?._router.showResult(model)
            },
            onError: { [weak self] error in
                self?._view?.showAlert(message: "データ取得に失敗しました")
            }
        ).disposed(by: disposeBag)
    }

//    func _checkContrast(input: ContrastCheckInputModel) {
//        let callback: (ContrastCheckEntity?) -> Void = { [weak self] entity in
//            guard let entity = entity else {
//                self?._view?.showAlert(message: "データ取得に失敗しました")
//                return
//            }
//
//            self?._router.showResult(entity)
//        }
//
//        let interactor = dicon.resolve(ContrastCheckUseCase.self)
//        interactor?.getResult(input: input, callback: callback)
//    }
}
