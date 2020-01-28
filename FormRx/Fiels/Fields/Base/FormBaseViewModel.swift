//
//  FormBaseViewModel.swift
//  Form
//
//  Created by Artem on 8/31/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//


public class FormBaseViewModel {
    
    let settings: FormBaseSettings
    
    let rxIsEnabled: BehaviorRelay<Bool>
    var isEnabled: Bool {
        return rxIsEnabled.value
    }
    
    var rxValidationResult: Observable<ValidationResult> = .empty()
    var rxIsValid: Driver<Bool> = .empty()
    
    let rxIsAuto = BehaviorRelay(value: false)
    let rxManualValidationResult: PublishRelay<ValidationResult> = PublishRelay()
    
    // Non reactive
    var validationResult: ValidationResult = .ok
    var isValid: Bool = true
    
    init(isEnabled: Bool, settings: FormBaseSettings) {
        self.rxIsEnabled = BehaviorRelay(value: isEnabled)
        self.settings = settings
    }
    
    func setValidationResult(_ validationResult: Observable<ValidationResult>) {
        
        let rxValidationResult = validationResult.share()
        
        self.rxIsValid = validationResult
            .do(onNext: { validationResult in
                self.validationResult = validationResult
                self.isValid = validationResult.isValid
            })
            .map({ $0.isValid })
            .distinctUntilChanged()
            .asDriver(onErrorRecover: { _ in return .empty() })
        
        let autoValidationResult = rxValidationResult.withLatestFrom(rxIsAuto) { ($0,$1) }
            .map({ (validationResult, processErrors) -> ValidationResult in

                if !validationResult.isValid {
                    if processErrors {
                        return validationResult
                    } else {
                        return .ok
                    }
                }
                
                return validationResult
            })
        
        self.rxValidationResult = Observable.merge(rxManualValidationResult.asObservable(), autoValidationResult).distinctUntilChanged()
    }
    
//    public func setValidationResult(validationResult: Observable<ValidationResult>) {
//
//        let rxValidationResult = Observable.combineLatest(validationResult, baseViewModel.rxIsEnabled)
//            .observeOn(SerialDispatchQueueScheduler(qos: .background))
//            .map({ (result, isEnabled) -> ValidationResult in
//                if !isEnabled { return .ok }
//                return result
//            })
//
//        // Update
//        self.baseViewModel.setValidationResult(rxValidationResult)
//    }
    
    func validate() {
        
        if settings.validateWhenError {
            rxIsAuto.accept(true)
        }
        rxManualValidationResult.accept(validationResult)
    }
}

public protocol FormBaseViewModelData: class {
    
    var baseViewModel: FormBaseViewModel { get }
}

extension FormBaseViewModelData {
    
    public func setEnabled(_ isEnabled: Bool) {
        baseViewModel.rxIsEnabled.accept(isEnabled)
    }
    
    public var rxIsEnabled: BehaviorRelay<Bool> {
        return baseViewModel.rxIsEnabled
    }
    
    public var isEnabled: Bool {
        return baseViewModel.isEnabled
    }
    
    public var rxIsValid: Driver<Bool> {
        return baseViewModel.rxIsValid
    }
    
    public var isValid: Bool {
        return baseViewModel.isValid
    }
    
    public func validate() {
        baseViewModel.validate()
    }
}
