//
//  Extension+Error.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 03/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import Foundation

enum ViewModelError: Error {
    case genericError
    case disposedBeforeReturn
    
    var localizedDescription: String {
        switch self {
        case .genericError:
            return "\(String(describing: Date().toString())) - generic app error"
        case .disposedBeforeReturn:
            return "\(String(describing: Date().toString())) - disposed before return"
        }
    }
}
