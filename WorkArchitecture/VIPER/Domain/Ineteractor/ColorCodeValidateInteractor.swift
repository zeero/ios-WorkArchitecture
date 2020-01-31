//
//  ContrastValidateInteractor.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/01/29.
//  Copyright © 2020 zeero. All rights reserved.
//

import Foundation

struct ColorCodeValidateInteractor {
}

protocol ColorCodeValidateUseCase {
    func isValid(input: String) -> Bool
}

extension ColorCodeValidateInteractor: ColorCodeValidateUseCase {
    func isValid(input: String) -> Bool {
        return isHex(input)
    }
    
    private func isHex(_ target: String) -> Bool {
        return Int(target) != nil
    }
}
