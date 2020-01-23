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
    private let _entity: ContrastCheckEntity

    @IBOutlet private weak var result: UILabel!


    init(entity: ContrastCheckEntity) {
        _entity = entity
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        result.text = _entity.ratio
    }
}

protocol ResultView {}
extension ResultViewController: ResultView {}
