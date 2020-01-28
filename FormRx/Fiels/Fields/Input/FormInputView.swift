//
//  FormInputView.swift
//  Form
//
//  Created by Artem on 8/8/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

public class FormInputView: FormBaseView {
    
    public enum Side {
        case left
        case right
    }
    
    public enum InputViewType {
        case field
        case textarea
    }
    
    // MARK: -
    // MARK: ** Connections **
    
    public lazy var contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    public var contentView: UIView!
    
    // Fields
    public var fieldView: UIView!
    public var placeholderFieldView: UIView!
    public var placeholderFieldViewTapGesture: UITapGestureRecognizer!
    // In
    public var fieldLeftView: UIView!
    public var fieldRightView: UIView!
    // Out
    public var fieldLeftSideView: UIView!
    public var fieldRightSideView: UIView!
    private var containerLeftSideView: UIView!
    private var containerRightSideView: UIView!

    open var viewModel: FormInputViewModel! {
        didSet { setupViewModel() }
    }
    
    // MARK: -
    // MARK: ** Initialization **

    func makeViews(inputView: UIView, placeholderView: UIView) {
        
        titleViewModel = FormTitleViewModel(titleText: "Field", isOptional: false)
            
        placeholderFieldViewTapGesture = UITapGestureRecognizer()
        
        fieldView = inputView
        placeholderFieldView = placeholderView
        placeholderFieldView.addGestureRecognizer(placeholderFieldViewTapGesture)
        
        contentView = UIView()
        contentView.pinSubview(inputView)
        contentView.pinSubview(placeholderView)
        contentView.bringSubviewToFront(placeholderView)
        
        contentStackView.addArrangedSubview(contentView)
        
        contentWrapperStackView.addArrangedSubview(contentStackView)
    }
    
    func setupViewModel() {
        
        baseViewModel = viewModel.baseViewModel

        disposeBag.insert(
            viewModel.rxValue.map({ !($0 ?? "").isEmpty })
                .bind(to: placeholderFieldView.rx.isHidden),
            placeholderFieldViewTapGesture.rx.event
                .subscribe(onNext: { [weak fieldView] _ in fieldView?.becomeFirstResponder() })
        )
    }

    // Out
    
    open func createImageView(from image: UIImage) -> UIImageView {
        
        let imageView = UIImageView(image: image)
        // image.withRenderingMode(.alwaysTemplate)
        imageView.backgroundColor = .clear
        imageView.contentMode = .center
        //
        return imageView
    }
    
    // Inside

    func setView(_ view: UIView?, for side: Side) {}
    
    open func setInImage(_ image: UIImage?, for side: Side) {
        
        guard let image = image else {
            setView(nil, for: side)
            return
        }
        
        let imageView = createImageView(from: image)
        //
        styleImageView(imageView, side: side)
        //
        setView(imageView, for: side)
    }
    
    // Outside
    
    private func createLabel(from text: String) -> UILabel {
        
        let label = UILabel()
        label.setContentHuggingPriority(.init(1000), for: .horizontal)
        label.text = text
        //
        return label
    }
    
    private func createContainerView(from view: UIView, for side: Side) -> UIView {
        
        let stackView = UIStackView(arrangedSubviews: [view])
        stackView.axis = .horizontal
        stackView.isLayoutMarginsRelativeArrangement = true
        //
        let containerView = UIView()
        containerView.pinSubview(stackView)
        //
        styleSideView(containerView, in: stackView, side: side)
        //
        return containerView
    }
    
    open func setOutText(_ text: String?, for side: Side) {
        
        guard let text = text else {
            setOutView(nil, for: side)
            return
        }
        
        let label = createLabel(from: text)
        
        styleSideLabel(label, side: side)
        
        setOutView(label, for: side)
    }
    
    open func setOutView(_ view: UIView?, for side: Side) {
        
        switch side {
        case .left:
            fieldLeftSideView = view
        case .right:
            fieldRightSideView = view
        }
        
        guard let view = view else {
            switch side {
            case .left:
                containerLeftSideView.removeFromSuperview()
                containerLeftSideView = nil
            case .right:
                containerRightSideView.removeFromSuperview()
                containerRightSideView = nil
            }
            return
        }
        
        let containerView = createContainerView(from: view, for: side)
        
        switch side {
        case .left:
            contentStackView.insertArrangedSubview(containerView, at: 0)
            containerLeftSideView = containerView
        case .right:
            contentStackView.addArrangedSubview(containerView)
            containerRightSideView = containerView
        }
    }
    
    open func styleImageView(_ view: UIView, side: Side) {}
    open func styleSideView(_ view: UIView, in wrapperView: UIStackView, side: Side) {}
    open func styleSideLabel(_ label: UILabel, side: Side) {}
}
