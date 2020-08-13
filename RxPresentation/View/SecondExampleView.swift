//
//  SecondExampleView.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 03/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SecondExampleView: UIViewController {
    @IBOutlet weak var btnLab1: UIButton!
    @IBOutlet weak var btnRadio1: UIButton!
    @IBOutlet weak var btnRadio2: UIButton!
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var btnNext: UIButton!
    
    private let viewModel = SecondExampleViewModel()
    private let viewDisposeBag = DisposeBag()
    private var session1DisposeBag: DisposeBag!
    private var session2DisposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }

    func bindView() {
        btnLab1.rx.tap.bind { [unowned self] _ in
            self.viewModel.getLab1Log()
        }.disposed(by: viewDisposeBag)
        
        btnRadio1.rx.tap.bind { [unowned self] _ in
            if self.btnRadio1.isSelected {
                self.session1DisposeBag = nil
            } else {
                self.session1DisposeBag = DisposeBag()
                self.bindLab1OnRadio1()
            }
            self.btnRadio1.isSelected = !self.btnRadio1.isSelected
        }.disposed(by: viewDisposeBag)
        
        btnRadio2.rx.tap.bind { [unowned self] _ in
            if self.btnRadio2.isSelected {
                self.session2DisposeBag = nil
            } else {
                self.session2DisposeBag = DisposeBag()
                self.bindLab1OnRadio2()
            }
            self.btnRadio2.isSelected = !self.btnRadio2.isSelected
        }.disposed(by: viewDisposeBag)
        
        btnNext.rx.tap.bind { [unowned self] _ in
            let view: ThirdExampleView = UIStoryboard.viewController()
            view.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(view, animated: true)
        }.disposed(by: viewDisposeBag)
        
        bindTextView()
    }
    
    func bindLab1OnRadio1() {
        viewModel.lab1Log
            .asDriver(onErrorJustReturn: RadioLog("FAILURE")) 
            .debounce(.seconds(1))
            .drive(onNext: { [weak self] radioLog in
            self?.logTextView.text += "\nRadio 1: \(radioLog.description)" 
        }, onDisposed: { [weak self] in
                self?.logTextView.text += "\n\(Date().toString()) - laboratories no longer being observed by radio 1"
        }).disposed(by: session1DisposeBag)
    }
    
    func bindLab1OnRadio2() {
        viewModel.lab1Log
            .skip(1)
            .subscribeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] radioLog in
            self?.logTextView.text += "\nRadio 2: \(radioLog.description)" 
        }, onDisposed: { [weak self] in
                self?.logTextView.text += "\n\(Date().toString()) - laboratories no longer being observed by radio 2"
        }).disposed(by: session2DisposeBag)
    }
    
    func bindTextView() {
        let kvoObservableLog = logTextView.rx.observe(String.self, #keyPath(UITextView.text))
        let rxControlEventLog = logTextView.rx.text
        let logZip = Observable.zip(rxControlEventLog.asObservable(), kvoObservableLog)
        logZip.subscribe(onNext: { kvo, rx in
            print("\(kvo ?? "-")\n-----\(rx ?? "-")\n\n")
        }).disposed(by: viewDisposeBag)
    }
}
