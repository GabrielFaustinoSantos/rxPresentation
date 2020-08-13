//
//  SecondExampleViewModel.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 03/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SecondExampleViewModel {
    private let lab1LogSubject: PublishSubject<RadioLog> = PublishSubject()
    var lab1Log: Observable<RadioLog> { lab1LogSubject.asObservable() }
    
    func getLab1Log() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.lab1LogSubject.onNext(RadioLog("Laboratory 1"))
        }
    }
}
