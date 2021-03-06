//
//  ViewController.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    private var _presenter: ViewPresentation?

    let disposeBag = DisposeBag()
    lazy var outputPort = (
        fg: fg.rx.text,
        bg: bg.rx.text,
        buttonTap: button.rx.tap
    )
    lazy var inputPort = (
        fgBackgroundColor: fg.rx.backgroundColor,
        bgBackgroundColor: bg.rx.backgroundColor
    )

    @IBOutlet private weak var fg: UITextField!
    @IBOutlet private weak var bg: UITextField!
    @IBOutlet private weak var button: UIButton!

    @IBAction private func tapped(_ sender: AnyObject) {
//        let fgText = fg.text ?? ""
//        let bgText = bg.text ?? ""
//        let input = ContrastCheckInputModel(fg: fgText, bg: bgText)
//        _presenter?.checkContrast(input: input)
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        guard let _presenter = _presenter else { return }
//        outputPort.fg.bind(to: _presenter.inputPort.fg).disposed(by: disposeBag)
//        outputPort.bg.bind(to: _presenter.inputPort.bg).disposed(by: disposeBag)
//        outputPort.buttonTap.bind(to: _presenter.inputPort.buttonTap).disposed(by: disposeBag)
//        _presenter.outputPort.fgBackgroundColor.bind(to: inputPort.fgBackgroundColor).disposed(by: disposeBag)
//        _presenter.outputPort.bgBackgroundColor.bind(to: inputPort.bgBackgroundColor).disposed(by: disposeBag)
    }
    
    
    /// プロトコルに公開しないことでRouterからのアクセスに限定する
    func inject(presenter: ViewPresentation) {
        _presenter = presenter
    }
}
