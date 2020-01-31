//
//  ResultViewController.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var presenter: ResultViewPresentation?
    private let _model: ResultViewModel

    @IBOutlet private weak var result: UILabel!


    init(model: ResultViewModel) {
        _model = model
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        result.text = _model.ratio
    }
}

protocol ResultView: Transitionar {}
extension ResultViewController: ResultView {}
