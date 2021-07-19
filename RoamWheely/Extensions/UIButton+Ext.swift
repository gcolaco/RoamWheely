//
//  UIButton+Ext.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 18/07/21.
//

import UIKit

extension UIButton {
    
    func buttonAnimation(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        } completion: { _ in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseIn) {
                viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    func popUpAnimatedView(visualEffectView: UIVisualEffectView, popUpView: UIView) {
        UIView.animate(withDuration: 0.5, animations: {
            visualEffectView.alpha  = 0
            popUpView.alpha         = 0
            popUpView.transform     = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }) { (_) in
            popUpView.removeFromSuperview()
            print("Did remove pop up window..")
        }
    }
       
}
