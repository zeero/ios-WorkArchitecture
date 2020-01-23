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

    static func assembleModules(entity: ContrastCheckEntity) -> UIViewController {
        let view = ResultViewController(entity: entity)

        return view
    }
}

extension ResultRouter: ResultWireframe {}
