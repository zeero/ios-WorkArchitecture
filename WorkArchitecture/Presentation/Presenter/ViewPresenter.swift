//
//  Presenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

class ViewPresenter {

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
        let callback: (ContrastCheckEntity?) -> Void = { [weak self] entity in
            guard let entity = entity else {
                self?._view?.showAlert(message: "データ取得に失敗しました")
                return
            }

            self?._router.showResult(entity)
        }

        let interactor = dicon.resolve(ContrastCheckUseCase.self)
        interactor?.getResult(input: input, callback: callback)
    }
}
