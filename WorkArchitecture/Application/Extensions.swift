//
//  Extensions.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/05/09.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation
import RxSwift

extension Disposable {
    
    @discardableResult
    func disposed(by disposer: CompositeDisposable) -> CompositeDisposable.DisposeKey? {
        return disposer.insert(self)
    }
}
