//
//  ResultRouter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/22.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

protocol ResultWireframe {}

struct ResultRouter {

    private unowned let _viewController: UIViewController
    
    private init(viewController: UIViewController) {
        _viewController = viewController
    }
    
    static func buildUp(model: ResultViewModel) -> UIViewController {
        let view = ResultViewController()
        let router = ResultRouter(viewController: view)
        let presenter = ResultViewPresenter(router: router, viewModel: model)
        view.inject(presenter: presenter)

        return view
    }
}

extension ResultRouter: ResultWireframe {}
