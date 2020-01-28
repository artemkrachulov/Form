//
//  NonRxTestViewController.swift
//  FormDemo
//
//  Created by Artem on 06.01.2020.
//  Copyright © 2020 Artem Krachulov. All rights reserved.
//

import UIKit
import Form

class NonRxTestViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!

    var button: UIButton!
    
    @IBAction func vv(_ sender: Any) {
//        field1.textField.text = "asdasdasd"
//        field2.textField.text = "123"
        
        
//        field2.viewModel.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        form1 = Form1()
        form2 = Form2()
    }
    
    var form1: Form1! {
        didSet {
            
            makeTextField(viewModel: form1.field1)
            makeTextField(viewModel: form1.field2)
            
            button = makeButton()
            button.addTarget(self, action: #selector(submitForm1(_:)), for: .touchDown)
            
//            form1.isEnabled = { [weak self] isEnabled in
//                print("Button", isEnabled)
//                self?.button.isEnabled = isEnabled
//            }
            
            
        }
    }
    
    var form2: Form2! {
        didSet {
            
            let field1 = makeTextField(viewModel: form2.field1)
            let field2 = makeTextField(viewModel: form2.field2)
        
            field1.textField.layer.borderWidth = 1
            field1.decorateHighlighted = { (view, isHighlighted) in
                view.textField.layer.borderColor = isHighlighted ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
            }
            
            field2.textField.layer.borderWidth = 1
            field2.decorateHighlighted = { (view, isHighlighted) in
                view.textField.layer.borderColor = isHighlighted ? UIColor.blue.cgColor : UIColor.lightGray.cgColor
            }

            
            button = makeButton()
            button.addTarget(self, action: #selector(submitForm2(_:)), for: .touchDown)
        }
    }
    
    private func makeTextField(viewModel: FormInputViewModel) -> FormTextFieldView {
    
        let view = FormTextFieldView(viewModel: viewModel)
        
        let fieldStatesView = FieldStatesView()
        fieldStatesView.formInputView = view
        stackView.addArrangedSubview(fieldStatesView)
        
        return view
    }
    
    private func makeTextview(viewModel: FormInputViewModel) -> FormTextView {
    
        let view = FormTextView(viewModel: viewModel)
        
        let fieldStatesView = FieldStatesView()
        fieldStatesView.formTextView = view
        stackView.addArrangedSubview(fieldStatesView)
        
        return view
    }
    
    private func makeCheckbox(viewModel: FormCheckboxViewModel) -> FormCheckboxView {
    
        let view = FormCheckboxView(viewModel: viewModel)
        
        let fieldStatesView = FieldStatesView()
        fieldStatesView.formCheckboxView = view
        stackView.addArrangedSubview(fieldStatesView)
        
        return view
    }
    
    private func makeButton() -> UIButton {
        
        let button = UIButton(type: .system)
        
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundColor(.black, for: .normal)
        
        button.setTitleColor(.white, for: .disabled)
        button.setBackgroundColor(UIColor.black.withAlphaComponent(0.3), for: .disabled)
        
        button.backgroundColor = .clear
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
   
        stackView.addArrangedSubview(button)
        return button
    }

    @objc private func submitForm1(_ button: UIButton) {
        
        do {

            print("VALID")
            
        } catch {
            print(error)
        }
    }
    
    @objc private func submitForm2(_ button: UIButton) {
        
        do {
  
            print("VALID")
            
        } catch {
            print(error)
        }
    }
}
