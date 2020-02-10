//
//  ResultRouter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/22.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

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

protocol ResultWireframe {
    func showAlert(message: String)
    func showAlert(message: String, retry: ((UIAlertAction) -> Void)?, handler: ((UIAlertAction) -> Void)?)
    func popViewController()
}
extension ResultRouter: ResultWireframe {
    func showAlert(message: String) {
        showAlert(message: message, retry: nil, handler: nil)
    }
    
    func showAlert(message: String, retry: ((UIAlertAction) -> Void)?, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "再試行", style: .default, handler: retry))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        _viewController.present(alert, animated: true, completion: nil)
    }
    
    func popViewController() {
        _viewController.navigationController?.popViewController(animated: true)
    }
}
