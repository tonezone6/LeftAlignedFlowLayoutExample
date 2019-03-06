//
//  ViewController.swift
//  TagsCollectionView
//
//  Created by Alex Stratu on 05/03/2019.
//  Copyright © 2019 Alex Stratu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardObservable {
    
    var collectionVC: CollectionViewController?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var tagInputView: TagInputView!
    @IBOutlet weak var tagInputViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterFromKeyboardNotifications()
    }
    
    // Get collection view child controller from container view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CollectionViewController {
            collectionVC = destination
            /*
             Important note:
             To make container view self sizing, use the below line of code
             and also change the collection view bottom constraint priority from 1000 to 999 */
            destination.view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension ViewController: TagInputViewDelegate {
    
    func tagInputView(_: TagInputView, didAddTag tag: String) {
        collectionVC?.add(tag: tag)
        scrollToBottom()
    }
}

extension ViewController {
    
    func setup() {
        registerToKeyboardNotifications { [unowned self] notification in
            self.animateInputView(height: notification.keyboardHeight)
            if notification.name == UIResponder.keyboardWillShowNotification {
                self.scrollToBottom()
            }
        }
        configureTapToDismiss()
        tagInputView.delegate = self
    }
    
    func animateInputView(height: CGFloat) {
        tagInputViewBottomConstraint.constant = -height
        UIView.animate(withDuration: 0.15) {
            self.view.layoutIfNeeded()
        }
    }
    
    func scrollToBottom() {
        guard scrollView.contentSize.height > scrollView.bounds.height else { return }
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    func configureTapToDismiss() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handle(tap:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handle(tap: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

