//
//  Presenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

class ViewPresenter {

    weak var view: View?
    private let _router: Wireframe
    private let _checkInteractor: ContrastCheckUseCase

    init(router: Wireframe, checkInteractor: ContrastCheckUseCase) {
        _router = router
        _checkInteractor = checkInteractor
    }
}


protocol ViewPresentation {
    func checkContrast(fcolor: String, bcolor: String)
}

extension ViewPresenter: ViewPresentation {
    func checkContrast(fcolor: String, bcolor: String) {
        let callback: (ContrastCheckEntity?) -> Void = { [weak self] entity in
            guard let entity = entity else {
                self?.view?.showAlert(message: "データ取得に失敗しました")
                return
            }

            self?._router.showResult(entity)
        }

        _checkInteractor.getResult(fcolor: fcolor, bcolor: bcolor, callback: callback)
    }
}
