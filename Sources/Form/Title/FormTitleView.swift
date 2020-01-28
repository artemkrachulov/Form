//
//  FormTitleView.swift
//  Form
//
//  Created by Artem on 05.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit
import Extensions

open class FormTitleView: UIView {
    
    // MARK: -
    // MARK: ** Definitions **
    
    public typealias ViewModel = FormTitleViewModel
    
    // MARK: -
    // MARK: ** Connections **
    
    public var titleRowStackView: UIStackView!
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 251), for: .horizontal)
        return label
    }()
    
    public lazy var requiredLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        return label
    }()
    
    public lazy var optionalLabel: UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 249), for: .horizontal)
        return label
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.gray
        return label
    }()
    

    // MARK: -
    // MARK: ** ViewModels **
    
    var viewModel: ViewModel! {
        didSet { setupViewModel() }
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    public init(viewModel: ViewModel) {
        defer { self.viewModel = viewModel }
        super.init(frame: CGRect.zero)
        
        self.setup()
    }
    
    public init() {
        super.init(frame: CGRect.zero)
        
        self.setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    // MARK: -
    // MARK: ** Other methods **
    
    func setup() {

        titleRowStackView = UIStackView(arrangedSubviews: [titleLabel, requiredLabel, optionalLabel])
        titleRowStackView.axis = .horizontal
        titleRowStackView.distribution = .fill
        titleRowStackView.spacing = 4
        
        let stackView = UIStackView(arrangedSubviews: [titleRowStackView, descriptionLabel])
        stackView.axis = .vertical
        
        self.pinSubview(stackView)
        
        setupViewInterface()
    }
    
    private func setupViewInterface() {}
    
    private func setupViewModel() {
        
        titleLabel.text = viewModel.titleLabelText
        requiredLabel.text = viewModel.requiredLabelText
        requiredLabel.isHidden = viewModel.isOptional
        optionalLabel.text = viewModel.optionalLabelText
        optionalLabel.isHidden = true
    }
}
