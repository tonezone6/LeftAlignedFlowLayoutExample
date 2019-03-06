//
//  TagInputView.swift
//  TagsCollectionView
//
//  Created by Alex Stratu on 06/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

protocol TagInputViewDelegate {
    func tagInputView(_ : TagInputView, didAddTag tag: String)
}

class TagInputView: XibView {
    
    var delegate: TagInputViewDelegate?
    
    @IBOutlet weak var inputField: RoundedTextField!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addTag(_ sender: UIButton) {
        guard let tag = inputField.text, tag.count > 0 else { return }
        delegate?.tagInputView(self, didAddTag: tag)
        inputField.text = ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        addButton.layer.cornerRadius = 15
        inputField.delegate = self
    }
}

extension TagInputView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
}
