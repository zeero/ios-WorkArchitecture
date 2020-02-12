//
//  ViewPresenterSpec.swift
//  WorkArchitectureTests
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxCocoa
@testable import WorkArchitecture

class ViewPresenterSpec: QuickSpec {

    override func spec() {
        
        let disposeBag = DisposeBag()
        
        describe("button tapped") {
            it("can test") {
                let router = RouterMock()
                let presenter = ViewPresenter(router: router)
                
                let view = ViewControllerMock()
                disposeBag.insert([
                    view.outputPort.fg.bind(to: presenter.inputPort.fg),
                    view.outputPort.bg.bind(to: presenter.inputPort.bg),
                    view.outputPort.buttonTap.bind(to: presenter.inputPort.buttonTap)
                ])
                view.fg.text = "foo"
                view.bg.text = "bar"
                view.button.sendActions(for: .touchUpInside)
                
                waitUntil(timeout: 3.0) { done in
                    if let message = router._message {
                        expect(message).to(equal("不正な値です"))
                        done()
                    }
                }
            }
        }
    }
}

class RouterMock: Wireframe {
    var _message: String?
    var _handler: ((UIAlertAction) -> Void)?
    var _model: ResultViewModel?
    
    func showAlert(message: String) {
        _message = message
    }
    
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)?) {
        _message = message
        _handler = handler
    }
    
    func showResult(_ model: ResultViewModel) {
        _model = model
    }
}

class ViewControllerMock {
    lazy var outputPort = (
        fg: fg.rx.text,
        bg: bg.rx.text,
        buttonTap: button.rx.tap
    )
    let fg = UITextField()
    let bg = UITextField()
    let button = UIButton()
}
