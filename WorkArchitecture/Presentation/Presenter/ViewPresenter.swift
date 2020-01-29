//
//  Presenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ViewPresenter {
    
    private let disposeBag = DisposeBag()
    private let fg = BehaviorRelay<String?>(value: nil)
    private let bg = BehaviorRelay<String?>(value: nil)
    private let buttonTap = PublishRelay<Void>()

    private weak var _view: View?
    private let _router: Wireframe

    init(view: View, router: Wireframe) {
        _view = view
        _router = router
        
        buttonTap.subscribe(onNext: { [weak self] in
            guard let fg = self?.inputPort.fg.value, let bg = self?.inputPort.bg.value else { return }
            let input = ContrastCheckInputModel(fg: fg, bg: bg)
            self?.checkContrast(input: input)
            }).disposed(by: disposeBag)
    }
}


protocol ViewPresentation {
    typealias InputPort = (
        fg: BehaviorRelay<String?>,
        bg: BehaviorRelay<String?>,
        buttonTap: PublishRelay<Void>
    )
    
    var inputPort: InputPort { get }
    
    func checkContrast(input: ContrastCheckInputModel)
}

extension ViewPresenter: ViewPresentation {
    var inputPort: InputPort {
        return (fg: fg, bg: bg, buttonTap: buttonTap)
    }
    
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
