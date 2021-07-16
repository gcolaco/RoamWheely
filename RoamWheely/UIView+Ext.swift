//
//  UIView+Ext.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

extension UIView {
    
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
}
