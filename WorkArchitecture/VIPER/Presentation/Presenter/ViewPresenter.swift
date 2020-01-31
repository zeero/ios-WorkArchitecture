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
    private let fgBackgroundColor = BehaviorRelay<UIColor>(value: .white)
    private let bgBackgroundColor = BehaviorRelay<UIColor>(value: .white)

    private let _router: Wireframe

    init(router: Wireframe) {
        _router = router
        
        buttonTap.subscribe(
            onNext: { [weak self] in
                self?.buttonTapped()
            }
        ).disposed(by: disposeBag)
    }
    
    private func buttonTapped() {
        guard let fg = inputPort.fg.value, let bg = inputPort.bg.value else { return }
        let input = ContrastCheckInputModel(fg: fg, bg: bg)
        
        let isValidFg = isValidColorCode(input: input.fg)
        let isValidBg = isValidColorCode(input: input.bg)
        
        if isValidFg && isValidBg {
            checkContrast(input: input)
        } else {
            let handler: (UIAlertAction) -> Void = { [weak self] _ in
                // 背景色を変える
                self?.outputPort.fgBackgroundColor.accept(isValidFg ? .white : .red)
                self?.outputPort.bgBackgroundColor.accept(isValidBg ? .white : .red)
            }
            _router.showAlert(message: "不正な値です", handler: handler)
        }
    }
    
    private func isValidColorCode(input: String) -> Bool {
        guard let interactor = dicon.resolve(ColorCodeValidateUseCase.self) else { return false }
        return interactor.isValid(input: input)
    }
}


protocol ViewPresentation {
    typealias InputPort = (
        fg: BehaviorRelay<String?>,
        bg: BehaviorRelay<String?>,
        buttonTap: PublishRelay<Void>
    )
    
    typealias OutputPort = (
        fgBackgroundColor: BehaviorRelay<UIColor>,
        bgBackgroundColor: BehaviorRelay<UIColor>
    )
    
    var inputPort: InputPort { get }
    var outputPort: OutputPort { get }
    
//    func checkContrast(input: ContrastCheckInputModel)
}

extension ViewPresenter: ViewPresentation {
    var inputPort: InputPort {
        return (fg: fg, bg: bg, buttonTap: buttonTap)
    }
    
    var outputPort: OutputPort {
        return (fgBackgroundColor: fgBackgroundColor, bgBackgroundColor: bgBackgroundColor)
    }
    
    func checkContrast(input: ContrastCheckInputModel) {
        guard let interactor = dicon.resolve(ContrastCheckUseCase.self) else { return }
        interactor.getResult(input: input).subscribe(
            onNext: { [weak self] model in
                self?._router.showResult(model)
            },
            onError: { [weak self] error in
                self?._router.showAlert(message: "データ取得に失敗しました")
            }
        ).disposed(by: disposeBag)
    }

//    func checkContrast(input: ContrastCheckInputModel) {
//        let callback: (ContrastCheckDataModel?) -> Void = { [weak self] entity in
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
