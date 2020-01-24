//
//  ViewController.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var presenter: ViewPresentation?

    @IBOutlet private weak var fg: UITextField!
    @IBOutlet private weak var bg: UITextField!

    @IBAction private func tapped(_ sender: AnyObject) {
        let fgText = fg.text ?? ""
        let bgText = bg.text ?? ""
        let input = ContrastCheckInputModel(fg: fgText, bg: bgText)
        presenter?.checkContrast(input: input)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}


protocol View: class {
    func showAlert(message: String)
}

extension ViewController: View {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "エラー", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
