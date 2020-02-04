//
//  CSResultPresenter.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/02/03.
//  Copyright (c) 2020 zeero. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CSResultPresentationLogic {
    func presentSomething(response: CSResult.Something.Response)
}

class CSResultPresenter: CSResultPresentationLogic {
    
    weak var viewController: CSResultDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(response: CSResult.Something.Response) {
        let viewModel = CSResult.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
}
