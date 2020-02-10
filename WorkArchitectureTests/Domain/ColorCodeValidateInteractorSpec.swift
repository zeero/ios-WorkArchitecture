//
//  ColorCodeValidateInteractorSpec.swift
//  WorkArchitectureTests
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Quick
import Nimble
@testable import WorkArchitecture

class ColorCodeValidateInteractorSpec: QuickSpec {

    override func spec() {
        describe("isValid") {
            context("when Numeric") {
                it("should return true") {
                    let interactor = ColorCodeValidateInteractor()
                    expect(interactor.isValid(input: "1")).to(beTrue())
                }
            }
            
            context("when Non-Numeric") {
                it("should return false") {
                    let interactor = ColorCodeValidateInteractor()
                    expect(interactor.isValid(input: "a")).to(beFalse())
                }
            }
        }
    }
}
