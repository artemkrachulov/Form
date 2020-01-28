//
//  FormTitleView.swift
//  Connect2Treat
//
//  Created by Artem on 7/6/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormTitleView: UIView {
    
    // MARK: -
    // MARK: ** Definitions **
    
    public typealias ViewModel = FormTitleViewModel
    
    // MARK: -
    // MARK: ** Connections **
    
    public lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 251), for: .horizontal)
        return label
    }()
    
    public lazy var requiredLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
         label.textColor = UIColor.red
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 250), for: .horizontal)
        return label
    }()
    
    public lazy var optionalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 249), for: .horizontal)
        label.textColor = UIColor.lightGray
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

        let row1StackView = UIStackView(arrangedSubviews: [titleLabel, requiredLabel, optionalLabel])
        row1StackView.axis = .horizontal
        row1StackView.distribution = .fill
        
        let row2StackView = UIStackView(arrangedSubviews: [descriptionLabel])
        row2StackView.axis = .horizontal
        
        let stackView = UIStackView(arrangedSubviews: [row1StackView, row2StackView])
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
