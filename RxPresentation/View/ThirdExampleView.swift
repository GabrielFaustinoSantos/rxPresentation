//
//  ThirdExampleView.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 03/08/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ThirdExampleView: UIViewController {
    @IBOutlet weak var btnLab1: UIButton!
    @IBOutlet weak var btnLab2: UIButton!
    @IBOutlet weak var btnLab3: UIButton!
    @IBOutlet weak var labelRadio1: UILabel!
    @IBOutlet weak var btnRadio1: UIButton!
    @IBOutlet weak var btnRadio2: UIButton!
    @IBOutlet weak var logTextView: UITextView!
    
    private let viewModel = ThirdExampleViewModel()
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
        
        btnLab2.rx.tap.bind { [unowned self] _ in
            self.viewModel.getlab2Log()
        }.disposed(by: viewDisposeBag)
        
        btnLab3.rx.tap.bind { [unowned self] _ in
            self.viewModel.getlab3Log()
        }.disposed(by: viewDisposeBag)
        
        btnRadio1.rx.tap.bind { [unowned self] _ in
            if self.btnRadio1.isSelected {
                self.session1DisposeBag = nil
                self.labelRadio1.text = ""
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
    }
    
    private var radio1State = 1
    
    func bindLab1OnRadio1() {
        if radio1State == 1 {
            let mergedLabs = Observable.merge(viewModel.lab1Log, viewModel.lab2Log)
            mergedLabs.subscribe(onNext: { [weak self] radioLog in
                self?.logTextView.text += "\nRadio 1: \(radioLog.description)"
            }).disposed(by: session1DisposeBag)
            labelRadio1.text = "Merge"
        } else if radio1State == 2 {
            let mergedLabs = Observable.zip(viewModel.lab1Log, viewModel.lab2Log)
            mergedLabs.map { radios in RadioLog("\n1-\(radios.0.description)\n2-\(radios.1.description)") }
                .subscribe(onNext: { [weak self] radioLog in
                    self?.logTextView.text += "\nRadio 1: \(radioLog.description)"
                }).disposed(by: session1DisposeBag)
            labelRadio1.text = "Zip"
        } else {
            let mergedLabs = Observable.combineLatest(viewModel.lab1Log, viewModel.lab2Log)
            mergedLabs.map { radios in RadioLog("\n1-\(radios.0.description)\n2-\(radios.1.description)") }
                .subscribe(onNext: { [weak self] radioLog in
                    self?.logTextView.text += "\nRadio 1: \(radioLog.description)"
                }).disposed(by: session1DisposeBag)
            radio1State = 0
            labelRadio1.text = "Combine latest"
        }
        
        radio1State += 1
    }
    
    func bindLab1OnRadio2() {
        viewModel.lab3Log.map { $0?.info ?? "NULL" }.subscribe(onNext: { [weak self] radioLog in
//            let radioLog = radioLog!
            self?.logTextView.text += "\n\(radioLog)"
        }).disposed(by: session2DisposeBag)
    }
}
