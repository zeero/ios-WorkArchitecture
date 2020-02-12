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
        
        describe("button tapped") {
            it("can test") {
                let router = RouterMock()
                let presenter = ViewPresenter(router: router)
                
                presenter.inputPort.fg.accept("foo")
                presenter.inputPort.bg.accept("bar")
                presenter.inputPort.buttonTap.accept(())
                
                expect(router._message).to(equal("不正な値です"))
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
