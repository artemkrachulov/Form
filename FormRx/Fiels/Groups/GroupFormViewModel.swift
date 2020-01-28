//
//  GroupFormViewModel.swift
//  Form
//
//  Created by Artem on 11/7/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//



open class GroupFormViewModel {
    
    let baseViewModel: FormBaseViewModel = FormBaseViewModel(isEnabled: true, settings: FormBaseSettings(resetAutoWhenOk: true, validateWhenError: true))

    public var isOptional: Bool
    
    var inputViewModels: [FormBaseViewModelData] = []
    
    public let rxIsChanged: Driver<Bool>
//    public var isChanged: Bool = false
    
    
    
    public init(inputViewModels: [FormInputViewModel], validationService: FormGroupInputValidationService) {
        
        self.inputViewModels = inputViewModels
        
        self.isOptional = validationService.requiredClosure == nil
        
        self.rxIsChanged = Driver
            .combineLatest(inputViewModels.map({ $0.rxIsChanged }), { $0.contains(true) })

        let rxValidationResultShared = Observable.combineLatest(inputViewModels.map({ $0.rxValue })) { $0 }
            .observeOn(SerialDispatchQueueScheduler(qos: .background))
            .withLatestFrom(baseViewModel.rxIsEnabled) { ($0, $1) }
            .map(validationService.valueValidate)
//            .share()
//
//        let rxIsValid = Driver.merge(
//            Driver.combineLatest(inputViewModels.map({ $0.baseViewModel.rxIsValid }), { !$0.contains(false) }),
//            rxValidationResultShared.as.map({ $0.isValid })
//        )
        let rxIsValid = Driver.just(true)

        let rxValidationResult = Observable.merge(
            // Error
            rxValidationResultShared,
            // Reset
            rxIsChanged.asObservable().map({ _ in return .ok })
        )
        
//        self.rxIsChanged = .empty()
//        baseViewModel.setValidationResult(rxValidationResult, and: rxIsValid)
    }
}
