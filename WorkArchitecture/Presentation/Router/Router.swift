//
//  Router.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

struct Router {

    private unowned var viewController: UIViewController?

    static func assembleModules() -> UIViewController {
        var router = Router()
        let checkInteractor = ContrastCheckInteractor(repository: WebAIMAPI())

        let presenter = ViewPresenter(router: router, checkInteractor: checkInteractor)
        let view = ViewController(presenter: presenter)

        presenter.view = view
        router.viewController = view

        return view
    }
}


protocol Wireframe {
    func showResult(_ entity: ContrastCheckEntity)
}

extension Router: Wireframe {
    func showResult(_ entity: ContrastCheckEntity) {
        let view = ResultRouter.assembleModules(entity: entity)

        viewController?.navigationController?.pushViewController(view, animated: true)
    }
}
