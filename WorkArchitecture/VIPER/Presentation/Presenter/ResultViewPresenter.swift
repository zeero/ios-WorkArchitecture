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
}
extension ResultViewPresenter: ResultViewPresentation {
    var outputPort: OutputPort {
        // mutating getter の問題が発生するからやっぱりPresenterはclass
        return (ratio.asObservable())
    }
}
