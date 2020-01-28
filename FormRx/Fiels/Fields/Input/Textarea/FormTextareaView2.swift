//
//  FormTextareaView.swift
//  Form
//
//  Created by Artem on 7/26/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit


public class FormTextareaView2: FormInputView {
/*
    public lazy var textView: UITextView = {
        let textView = UITextView()
        textView.isEditable = true
        textView.isSelectable = true
        textView.isScrollEnabled = true
        return textView
    }()
    
    public lazy var placeholderTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    // MARK: -
    // MARK: ** Initialization **
    
    override func setup() {
        super.setup()
        
        setupInputViews(inputView: textView, placeholderView: placeholderTextView)
    }
    
    override func setupViewModel() {
        
        disposeBag = DisposeBag()
        
        (textView.rx.text <-> viewModel.rxTextFieldText).disposed(by: disposeBag)
        placeholderTextView.text = viewModel.placeholder
        
        super.setupViewModel()
        
//        let states = viewModel.states(didBeginEditing: textView.rx.didBeginEditing, didChange: textView.rx.didChange, didEndEditing: textView.rx.didEndEditing)
        
//        setupViewModelStates(states)
    }
    
    public func setFieldInsets(_ insets: UIEdgeInsets) {
        
        
        textView.textContainerInset = insets
        textView.textContainer.lineFragmentPadding = 0
        placeholderTextView.textContainerInset = insets
        placeholderTextView.textContainer.lineFragmentPadding = 0
        
    }
    */
}

extension FormTextareaView2: UITextViewDelegate {
    
  
}


