//
//  Router.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit
import RxSwift
import RxViewController

struct Router {

    private unowned let _viewController: UIViewController

    private init(viewController: UIViewController) {
        _viewController = viewController
    }

    static func buildUp() -> UIViewController {
        let view = ViewController()
        let router = Router(viewController: view)

        let presenter = ViewPresenter(router: router)
        
        let disposer = CompositeDisposable()
        view.rx.viewDidLoad.subscribe(onNext: {
            view.outputPort.fg.bind(to: presenter.inputPort.fg).disposed(by: view.disposeBag)
            view.outputPort.bg.bind(to: presenter.inputPort.bg).disposed(by: view.disposeBag)
            view.outputPort.buttonTap.bind(to: presenter.inputPort.buttonTap).disposed(by: view.disposeBag)
            presenter.outputPort.fgBackgroundColor.bind(to: view.inputPort.fgBackgroundColor).disposed(by: view.disposeBag)
            presenter.outputPort.bgBackgroundColor.bind(to: view.inputPort.bgBackgroundColor).disposed(by: view.disposeBag)
            
            disposer.dispose()
            }
        ).disposed(by: disposer)

        view.inject(presenter: presenter)

        return view
    }
}


protocol Wireframe {
    func showAlert(message: String)
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)?)
    func showResult(_ model: ResultViewModel)
}

extension Router: Wireframe {
    func showAlert(message: String) {
        showAlert(message: message, handler: nil)
    }
    
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        _viewController.present(alert, animated: true, completion: nil)
    }
    
    func showResult(_ model: ResultViewModel) {
        let view = ResultRouter.buildUp(model: model)

        _viewController.navigationController?.pushViewController(view, animated: true)
    }
}
