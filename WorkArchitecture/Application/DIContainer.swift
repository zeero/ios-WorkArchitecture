//
//  DIContainer.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/24.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

class DIContainer {
    private var factories: [ObjectIdentifier: () -> Any] = [:]
    private let locker = NSRecursiveLock()

    func register<T>(_ type: T.Type = T.self, factory: @escaping () -> T) {
        locker.lock()
        defer { locker.unlock() }

        let key = ObjectIdentifier(type)
        factories[key] = factory
    }

    func resolve<T>(_ type: T.Type = T.self) -> T? {
        locker.lock()
        defer { locker.unlock() }

        let key = ObjectIdentifier(type)
        return factories[key]?() as? T
    }
}

// MARK: - dicon
let dicon: DIContainer = {
    let dicon = DIContainer()

    // MARK: ContrastCheck
    dicon.register(ContrastCheckUseCase.self, factory: { return ContrastCheckInteractor() })
    dicon.register(ContrastCheckRepository.self, factory: { return WebAIMAPI() })

    return dicon
}()
