//
//  Form1View.swift
//  FormDemo
//
//  Created by Artem on 7/29/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import Reusable
import RxCocoa
import RxSwift
import Form

final class Form1View: UIView, NibOwnerLoadable {
    
    // MARK: -
    // MARK: ** Connections **
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var field1View: FormFieldView!
    @IBOutlet weak var field2View: FormFieldView!
    @IBOutlet weak var checkboxView: FormCheckboxView!
    @IBOutlet weak var button: UIButton!
    
    // MARK: -
    // MARK: ** Properties **
    
    private let disposeBag = DisposeBag()
    
    // MARK: -
    // MARK: ** Initialization **
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadNibContent()
    }
    
    // MARK: -
    // MARK: ** Other methods **
    
    
    func setupViewModel() {
        
        titleLabel.text = "Form 1"
        
        let formService = Form1Service(field: .field1)
        let field1FIVM = Form1FIVM(service: formService)
        //
        formService.setField(.field2)
        let field2FIVM = Form1FIVM(service: formService)
        //
        formService.setField(.checkbox)
        let checkboxFCVM = Form1FCVM(service: formService)
        //
        let rxIsValid = Driver.combineLatest(field1FIVM.rxIsValid, field2FIVM.rxIsValid, checkboxFCVM.rxIsValid) { $0 && $1 && $2 }
        
        field1View.viewModel = field1FIVM
        field2View.viewModel = field2FIVM
        checkboxView.viewModel = checkboxFCVM
        
        rxIsValid.drive(button.rx.isEnabled).disposed(by: disposeBag)
    }
}
