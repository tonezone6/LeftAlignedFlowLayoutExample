//
//  KeyboardObservable.swift
//  TagsCollectionView
//
//  Created by Alex Stratu on 06/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        guard name == UIResponder.keyboardWillShowNotification,
            let userInfo = userInfo,
            let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        else {
            return 0
        }
        return value.cgRectValue.size.height
    }
}

protocol KeyboardObservable {}
extension KeyboardObservable where Self: UIViewController {
    
    func observeKeyboard(handler: @escaping (_ notification: Notification) -> Void) {
        NotificationCenter.default
        .addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: nil) { notification in
            handler(notification)
        }
        NotificationCenter.default
        .addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: nil) { notification in
            handler(notification)
        }
    }
    
    func removeKeyboardObserver() {
        NotificationCenter
        .default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter
        .default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
