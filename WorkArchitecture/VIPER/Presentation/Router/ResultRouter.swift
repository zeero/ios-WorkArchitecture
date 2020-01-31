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

    static func buildUp(model: ResultViewModel) -> UIViewController {
        let view = ResultViewController(model :model)

        return view
    }
}

extension ResultRouter: ResultWireframe {}
