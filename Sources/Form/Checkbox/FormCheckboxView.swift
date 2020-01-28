//
//  FormCheckboxView.swift
//  Connect2Treat
//
//  Created by Artem on 01.12.2019.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

open class FormCheckboxView: FormFieldView {
    
    // MARK: -
    // MARK: ** Connections **
    
    lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    lazy var sswitch: UISwitch = {
        let sswitch = UISwitch()
        sswitch.isHidden = true
        sswitch.setContentHuggingPriority(UILayoutPriority(rawValue: 750), for: .horizontal)
        sswitch.addTarget(self, action: #selector(switchDidChange), for: .valueChanged)
        return sswitch
    }()
    
    var tapGestureTapGesture: UITapGestureRecognizer!
    
    public lazy var iconContainerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: height)
        heightConstraint.identifier = "height"
        heightConstraint.isActive = true
        
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: height)
        widthConstraint.identifier = "width"
        widthConstraint.isActive = true
        
        return view
    }()
    
    public lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        let heightConstraint = imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        heightConstraint.identifier = "height"
        heightConstraint.isActive = true
        
        let widthConstraint = imageView.widthAnchor.constraint(equalToConstant: imageHeight)
        widthConstraint.identifier = "width"
        widthConstraint.isActive = true
        
        return imageView
    }()
    
    private var replacedLabel: UILabel!
    public var label: UILabel! {
        guard _label != nil else { return replacedLabel }
        return _label
    }
    
    private lazy var _label: UILabel! = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 500), for: .horizontal)
        return label
    }()
    
    public var height: CGFloat = 20 {
        didSet {
            iconContainerView.constraints.first(where: { $0.identifier == "height" })?.constant = height
            iconContainerView.constraints.first(where: { $0.identifier == "width" })?.constant = height
        }
    }
    
    public var imageHeight: CGFloat = 16 {
        didSet {
            iconImageView.constraints.first(where: { $0.identifier == "height" })?.constant = imageHeight
            iconImageView.constraints.first(where: { $0.identifier == "width" })?.constant = imageHeight
        }
    }

    // MARK: -
    // MARK: ** Properties **
    
    public weak var delegate: FormCheckboxViewDelegate?
    
    open var viewModel: FormCheckboxViewModel! {
        didSet { setupViewModel() }
    }
    
    public func replaceLabel(with newLabel: UILabel) {
        
        self._label.removeFromSuperview()
        self.replacedLabel = newLabel

        contentStackView.addArrangedSubview(newLabel)
    }
    
    // MARK: -
    // MARK: ** Initialization **
    
    public init(viewModel: FormCheckboxViewModel) {
        defer { self.viewModel = viewModel }
        super.init(frame: CGRect.zero)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func makeUI() {
        super.makeUI()
        
        tapGestureTapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        
        
        iconContainerView.addGestureRecognizer(tapGestureTapGesture)
        iconContainerView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor, constant: 0).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor, constant: 0).isActive = true
        
        contentStackView.addArrangedSubview(iconContainerView)
        contentStackView.addArrangedSubview(sswitch)
        contentStackView.addArrangedSubview(_label)

        contentWrapperStackView.addArrangedSubview(contentStackView)
    }
    
    // MARK: -
    // MARK: ** Other methods **
    
    private func setupViewModel() {
        
        baseViewModel = viewModel.baseViewModel
        
        _label.text = viewModel.labelText
        
        sswitch.isOn = viewModel.value
        setChecked(sswitch.isOn)
    }
    
    @objc private func tap() {
        sswitch.isOn = !sswitch.isOn
        switchDidChange(sswitch)
    }
        
    // MARK: -
    // MARK: ** Closures **
    
    public var decorateError: ((FormCheckboxView) -> Void)? {
        didSet { decorateError?(self) }
    }
    
    public var decorateEnabled: ((FormCheckboxView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateEnabled?(self, viewModel.baseViewModel.isEnabled)
        }
    }
    
    public var decorateChecked: ((FormCheckboxView, Bool) -> Void)? {
        didSet {
            guard let viewModel = viewModel else { return }
            decorateChecked?(self, viewModel.value)
            
            iconImageView.alpha = viewModel.value ? 1.0 : 0.0
        }
    }
}

extension FormCheckboxView: FormCheckboxStateProtocol {
    
    func setChecked(_ isChecked: Bool) {
        print("setChecked", isChecked)
        
        // Decorate
//        guard didisOn?(self, isChecked) == nil else { return }
        decorateChecked?(self, isChecked)
        
        iconImageView.alpha = isChecked ? 1.0 : 0.0
    }
    
    override func setEnabled(_ isEnabled: Bool) {
        super.setEnabled(isEnabled)
        // Decorate
        decorateEnabled?(self, isEnabled)
        //
        viewModel?.setEnabled(isEnabled)
    }
    
    override func setOk() {
        super.setOk()
        
        // Decorate
        decorateChecked?(self, viewModel.value)
        
        delegate?.formCheckboxViewDidSetOk(self)
    }

    override func setError(_ errorText: String) {

        // Closure
        decorateError?(self)
        
        // Style error view if allowed
        guard delegate?.formCheckboxViewShouldShowAnError(self, errorString: errorText) ?? true else { return }
        super.setError(errorText)
    }
}

public protocol FormCheckboxViewDelegate: class {
    
    func formCheckboxViewDidSetOk(_ fieldView: FormCheckboxView)
    func formCheckboxViewShouldShowAnError(_ fieldView: FormCheckboxView, errorString: String) -> Bool
}
