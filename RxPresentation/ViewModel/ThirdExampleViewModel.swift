//
//  ThirdExampleViewModel.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 03/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ThirdExampleViewModel {
    private let lab1LogSubject: PublishSubject<RadioLog> = PublishSubject()
    var lab1Log: Observable<RadioLog> { lab1LogSubject.asObservable() }
    private let lab2LogSubject: PublishSubject<RadioLog> = PublishSubject()
    var lab2Log: Observable<RadioLog> { lab2LogSubject.asObservable() }
    private let lab3LogSubject: BehaviorSubject<RadioLog?> = BehaviorSubject(value: nil)
    var lab3Log: Observable<RadioLog?> { lab3LogSubject.asObservable() }
    
    func getLab1Log() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.lab1LogSubject.onNext(RadioLog("Laboratory 1"))
        }
    }
    
    func getlab2Log() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.lab2LogSubject.onNext(RadioLog("Laboratory 2"))
        }
    }
    
    var isSuccess = false 
    
    func getlab3Log() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            if self?.isSuccess ?? false {
                self?.lab3LogSubject.onNext(RadioLog("Laboratory 3"))
            } else {
                self?.lab3LogSubject.onNext(nil)
            }
            
            self?.isSuccess = !(self?.isSuccess ?? false)
        }
    }
}
