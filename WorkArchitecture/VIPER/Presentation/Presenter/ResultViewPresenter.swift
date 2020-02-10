//
//  ResultViewPresenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/22.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ResultViewPresenter {
    private let _router: ResultWireframe
    private let _viewModel: ResultViewModel
    
    private let disposeBag = DisposeBag()
    private lazy var ratio = BehaviorRelay<String>(value: _viewModel.ratio)
    
    init(router: ResultWireframe, viewModel: ResultViewModel) {
        _router = router
        _viewModel = viewModel
    }
}

protocol ResultViewPresentation {
    typealias OutputPort = (
        Observable<String>
    )

    var outputPort: OutputPort { get }
    
    func checkContrast()
}
extension ResultViewPresenter: ResultViewPresentation {
    var outputPort: OutputPort {
        // mutating getter の問題が発生するからやっぱりPresenterはclass
        return (ratio.asObservable())
    }
    
    func checkContrast() {
        guard let interactor = dicon.resolve(ContrastCheckUseCase.self) else { return }
        interactor.getResult(input: _viewModel.query).subscribe(
            onNext: { [weak self] model in
                self?.ratio.accept(model.ratio)
            },
            onError: { [weak self] error in
                self?._router.showAlert(
                    message: "データ取得に失敗しました",
                    retry: { _ in
                        self?.checkContrast()
                    },
                    handler: nil
                )
            }
        ).disposed(by: disposeBag)
    }
}
