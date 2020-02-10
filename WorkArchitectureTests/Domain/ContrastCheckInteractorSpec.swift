//
//  ContrastCheckInteractorSpec.swift
//  WorkArchitectureTests
//
//  Created by zeero on 2020/01/21.
//  Copyright © 2020 zeero. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import WorkArchitecture

class ContrastCheckInteractorSpec: QuickSpec {

    override func spec() {
        describe("ContrastCheck") {
            beforeEach {
                dicon.register(ContrastCheckRepository.self, factory: {
                    return ContrastCheckRepositoryStub()
                })
            }
            
            context("success") {
                it("should return ratio") {
                    let input = ContrastCheck.Request(fg: "", bg: "")
                    let interactor = ContrastCheckInteractor()
                    let blocking = interactor.getResult(input: input).toBlocking()
                    
                    expect(try? blocking.first()?.ratio).to(equal("1"))
                }
            }
        }
    }
}

struct ContrastCheckRepositoryStub: ContrastCheckRepository {
    func fetchResult(input: ContrastCheck.Request) -> Observable<ContrastCheckDataModel> {
        let model = ContrastCheckDataModel(ratio: "1", AA: "", AALarge: "", AAA: "", AAALarge: "")
        return Observable.just(model)
    }
}
