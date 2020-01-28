//
//  Router.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

struct Router {

    private unowned let _viewController: UIViewController

    private init(viewController: UIViewController) {
        _viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let view = ViewController()
        let router = Router(viewController: view)

        let presenter = ViewPresenter(view: view, router: router)

        view.inject(presenter: presenter)

        return view
    }
}


protocol Wireframe {
    func showResult(_ model: ResultViewModel)
}

extension Router: Wireframe {
    func showResult(_ model: ResultViewModel) {
        let view = ResultRouter.assembleModules(model: model)

        _viewController.navigationController?.pushViewController(view, animated: true)
    }
}
