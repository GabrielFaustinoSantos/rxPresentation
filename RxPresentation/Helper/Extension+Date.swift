//
//  Extension+Data.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 02/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import Foundation

extension Date {
    func toString(_ format: String = "HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt-br")
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
