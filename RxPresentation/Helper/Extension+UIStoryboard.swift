//
//  Extension+Storyboard.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 02/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import UIKit

extension UIViewController {
    var id: String {
        return String(describing: self)
    }
    
    static var id: String {
        return String(describing: Self.self)
    }
}

extension UIStoryboard {
    static func viewController<T: UIViewController>(fromStoryboard storyboard: String = "Main") -> T {
        if T.self == UIViewController.self {
            fatalError("No type given to generic function")
        }
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle(for: AppDelegate.self))
        return storyboard.instantiateViewController(identifier: T.id)
    }
}
