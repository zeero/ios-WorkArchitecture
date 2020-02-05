//
//  CSResultModels.swift
//  WorkArchitecture
//
//  Created by zeero on 2020/02/03.
//  Copyright (c) 2020 zeero. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum CSResult {
    // MARK: Use cases
    
    enum ContrastCheck {
        struct Request {
            let fg: String
            let bg: String
        }
        struct Response {
            let ratio: String
        }
        struct ViewModel {
            let ratio: String
        }
    }
}
