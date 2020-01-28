//
//  GroupFormView.swift
//  Form
//
//  Created by Artem on 11/7/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

open class GroupFormView: FormBaseView {
    
    
    
    open var viewModel: GroupFormViewModel! {
         didSet { setupViewModel() }
     }
    
    // MARK: -
    // MARK: ** Initialization **
    
    public init(viewModel: GroupFormViewModel) {
        defer { self.viewModel = viewModel }
        super.init(frame: CGRect.zero)
        
//        setupViewInterface()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setupViewInterface()
    }
    
    public func addFieldViews(_ view: UIView) {
        contentWrapperStackView.addArrangedSubview(view)
    }
    
    func setupViewModel() {
        
        viewModel.baseViewModel.rxIsEnabled
            .subscribe(onNext: { [unowned self] isEnabled in
                self.viewModel.inputViewModels.map({ $0.baseViewModel.rxIsEnabled }).forEach ({ $0.accept(isEnabled)})
            })
            .disposed(by: disposeBag)
    }
}
