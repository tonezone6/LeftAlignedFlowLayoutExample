//
//  RoundedTextInput.swift
//  InputKeyboardObservable
//
//  Created by Alex Stratu on 01/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

class RoundedTextField: UITextField {
        
    private let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 32)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height/2
    }
}
