//
//  File.swift
//  PicturesTestTask
//
//  Created by OMac on 8/22/19.
//  Copyright © 2019 OMac. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func keyBoardDidDisappear(){}
    
    @objc func keyBoardDidAppear(){}
    
    func observeKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardNotification(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func unobserveKeyboard() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardConstraint() -> NSLayoutConstraint? {
        return nil
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo, let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue, let keyboardHeightLayoutConstraint = self.keyboardConstraint() {
            let endFrameY = endFrame.origin.y
            let duration:TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            if endFrameY >= UIScreen.main.bounds.size.height {
                keyboardHeightLayoutConstraint.constant = 0.0
                self.keyBoardDidDisappear()
            } else {
                keyboardHeightLayoutConstraint.constant = endFrame.size.height
                self.keyBoardDidAppear()
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
        
    }
}

