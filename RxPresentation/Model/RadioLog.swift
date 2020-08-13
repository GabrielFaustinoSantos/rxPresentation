//
//  PressPaper.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 31/07/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import Foundation

struct RadioLog {
    let publishTime: Date
    let info: String
    
    init(_ info: String) {
        publishTime = Date()
        self.info = info
    }
}

extension RadioLog: CustomStringConvertible {
    var description: String {
        let time = self.publishTime.toString()
        return "\(time) - \(info)"
    }
}
