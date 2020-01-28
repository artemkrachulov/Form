//
//  FormInputViewModel.swift
//  Form
//
//  Created by Artem on 7/26/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//


open class FormInputViewModel: FormValueViewModel<String?>, FormBaseViewModelData {

    public let baseViewModel: FormBaseViewModel
    
    // Additional events
    
    public let rxIsHighlighted = BehaviorRelay(value: false)
    public var isHighlighted: Bool {
        return rxIsHighlighted.value
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    public let placeholderLabelText: String?
    public let validationService: FormInputValidationService
    
    public init(text: String?, placeholder: String?, validationService: FormInputValidationService = .disabled) {
        
        self.baseViewModel = FormBaseViewModel(isEnabled: true, settings: validationService.settings.baseSettings)
        
        self.placeholderLabelText = placeholder
        self.validationService = validationService
        
        //
        super.init(value: text, closure: { $0 ?? "" != $1 ?? "" })
        
        let rxValidationResult = Observable.combineLatest(rxValue, baseViewModel.rxIsEnabled)
            .observeOn(SerialDispatchQueueScheduler(qos: .background))
            .map(validationService.valueValidate)
        
        // Update
        self.baseViewModel.setValidationResult(rxValidationResult)
    }
}
