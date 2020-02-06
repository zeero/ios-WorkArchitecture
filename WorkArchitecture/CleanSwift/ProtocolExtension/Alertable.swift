//
//  Alertable.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/02/05.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

protocol Alertable {}

extension Alertable where Self: UIViewController {
    func showAlert(message: String) {
        showAlert(message: message, handler: nil)
    }
    
    func showAlert(message: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
