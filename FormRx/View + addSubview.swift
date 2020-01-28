//
//  View + addSubview.swift
//  Form
//
//  Created by Artem on 7/26/19.
//  Copyright © 2019 Artem Krachulov. All rights reserved.
//

import UIKit

extension UIView {
    
    public func pinSubview(_ view: UIView, layoutAttributes: [NSLayoutConstraint.Attribute] = [.top, .leading, .bottom, .trailing]) {
        
        view.frame.size = self.frame.size
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        NSLayoutConstraint.activate(layoutAttributes.map { attribute in
            NSLayoutConstraint(
                item: view, attribute: attribute,
                relatedBy: .equal,
                toItem: self, attribute: attribute,
                multiplier: 1, constant: 0.0
            )
        })
    }
    
    public func pinSubview(_ view: UIView, layoutAttribute: NSLayoutConstraint.Attribute, width: CGFloat) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(view)
        
        var layoutAttributes = [NSLayoutConstraint.Attribute]()
        
        switch layoutAttribute {
        case .top, .bottom:
            layoutAttributes = [.leading, .trailing]
            view.heightAnchor.constraint(equalToConstant: width).isActive = true
        case .leading, .trailing:
            layoutAttributes = [.top, .bottom]
            view.widthAnchor.constraint(equalToConstant: width).isActive = true
        default:
            layoutAttributes = []
        }
        
        layoutAttributes.append(layoutAttribute)
        
        NSLayoutConstraint.activate(layoutAttributes.map { attribute in
            NSLayoutConstraint(
                item: view, attribute: attribute,
                relatedBy: .equal,
                toItem: self, attribute: attribute,
                multiplier: 1, constant: 0.0
            )
        })
    }
    
}
