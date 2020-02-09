//
//  ResultViewController.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ResultViewController: UIViewController {

    private var _presenter: ResultViewPresentation?
    
    private let disposeBag = DisposeBag()
    private lazy var inputPort = (
        result.rx.text
    )

    @IBOutlet private weak var result: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bind()
        
        _presenter?.checkContrast()
    }
    
    
    func inject(presenter: ResultViewPresentation) {
        _presenter = presenter
    }
    
    private func bind() {
        _presenter?.outputPort.bind(to: inputPort).disposed(by: disposeBag)
    }
}
