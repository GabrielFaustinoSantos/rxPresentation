//
//  ViewController.swift
//  RxPresentation
//
//  Created by Gabriel Faustino dos Santos - GSN on 31/07/20.
//  Copyright © 2020 Gabriel Faustino dos Santos - GSN. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FirstExampleView: UIViewController {
    @IBOutlet weak var btnLab1: UIButton!
    @IBOutlet weak var btnLab2: UIButton!
    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var logTextView: UITextView!
    
    private let viewModel = FirstExampleViewModel()
    private let viewDisposeBag = DisposeBag()
    private var sessionDisposeBag: DisposeBag!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindView()
    }

    func bindView() {
        btnLab1.rx.tap.bind { [unowned self] _ in
            self.viewModel.getLab1Log()
        }.disposed(by: viewDisposeBag)
        
        btnLab2.rx.tap.bind { [unowned self] _ in
            self.bindLab2()
        }.disposed(by: viewDisposeBag)
        
        btnRadio.rx.tap.bind { [unowned self] _ in
            if self.btnRadio.isSelected {
                self.sessionDisposeBag = nil
            } else {
                self.sessionDisposeBag = DisposeBag()
                self.bindLab1()
            }
            self.btnRadio.isSelected = !self.btnRadio.isSelected
        }.disposed(by: viewDisposeBag)
        
        btnNext.rx.tap.bind { [unowned self] _ in
            let view: SecondExampleView = UIStoryboard.viewController()
            view.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(view, animated: true)
        }.disposed(by: viewDisposeBag)
    }
    
    func bindLab1() {
        viewModel.lab1Log.subscribe(onNext: { [weak self] radioLog in
            self?.logTextView.text += "\n\(radioLog.description)" 
        }, onDisposed: { [weak self] in
                self?.logTextView.text += "\n\(Date().toString()) - laboratories are no longer being observed"
        }).disposed(by: sessionDisposeBag)
    }
    
    func bindLab2() {
        if sessionDisposeBag == nil { return }
        self.viewModel.getLab2Log().subscribe(onSuccess: { [weak self] radioLog in
            self?.logTextView.text += "\n\(radioLog.description)"
        }, onError: { [weak self] error in
            let error = error as? ViewModelError
            self?.logTextView.text += "\n\(error?.localizedDescription ?? "ERROR")"
        }).disposed(by: self.sessionDisposeBag)
    }
}
