//
//  Extension+Image.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 02/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import UIKit

extension UIImage {
    static let errorImage = UIImage(named: "ic_error")!
    
    static func image(_ name: ImageName) -> UIImage {
        return UIImage(named: name.rawValue) ?? errorImage
    }
}

enum ImageName: String {
    case ic_radio
    case ic_signal
}
