//
//  ViewController.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let _presenter: ViewPresentation

    @IBOutlet private weak var fg: UITextField!
    @IBOutlet private weak var bg: UITextField!

    @IBAction private func tapped(_ sender: AnyObject) {
        let fcolor = fg.text ?? ""
        let bcolor = bg.text ?? ""
        _presenter.checkContrast(fcolor: fcolor, bcolor: bcolor)
    }


    init(presenter: ViewPresentation) {
        _presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
