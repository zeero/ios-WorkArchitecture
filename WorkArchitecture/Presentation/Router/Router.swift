//
//  Router.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

struct Router {

    private unowned let _transitionar: Transitionar

    private init(transitionar: Transitionar) {
        _transitionar = transitionar
    }

    static func buildUp() -> UIViewController {
        let view = ViewController()
        let router = Router(transitionar: view)

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
        let view = ResultRouter.buildUp(model: model)

        _transitionar.pushViewController(view, animated: true)
    }
}
