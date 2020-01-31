//
//  Transitionar.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/30.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

protocol Transitionar where Self: UIViewController {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Void)?)
}

extension Transitionar {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRootViewController(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    func popToViewController(_ viewController: UIViewController, animated: Bool) {
        navigationController?.popToViewController(viewController, animated: animated)
    }
    
    func presentAlert(_ alertControllerToPresent: UIAlertController, animated: Bool, completion: (() -> Void)?) {
        present(alertControllerToPresent, animated: animated, completion: completion)
    }
}
