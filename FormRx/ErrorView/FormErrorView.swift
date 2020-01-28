//
//  FormErrorView.swift
//  Form
//
//  Created by Artem on 7/29/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormErrorView: UIView {
    
    // MARK: -
    // MARK: ** Definition **
    
    public typealias ViewModel = FormErrorViewModel
    
    // MARK: -
    // MARK: ** Connections **
    
    public lazy var wrapperStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    public lazy var textLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    open var viewModel: ViewModel! {
        didSet { setupViewModel() }
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    init(viewModel: ViewModel) {
        defer { self.viewModel = viewModel }
        super.init(frame: CGRect.zero)
        
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setup()
    }
    
    func setup() {
        wrapperStackView.addArrangedSubview(textLabel)
        self.pinSubview(wrapperStackView)
    }
    
    private func setupViewModel() {
        textLabel.text = viewModel.textLabelText
    }
}
