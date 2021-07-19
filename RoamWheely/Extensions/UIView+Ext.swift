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
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    
    func makeGradientBg(_ firstColor: UIColor, _ secondColor: UIColor) {
        let gradientLayer           = CAGradientLayer()
        gradientLayer.frame         = bounds
        gradientLayer.colors        = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.locations     = [0.0, 1.0]
        gradientLayer.startPoint    = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint      = CGPoint(x: 1.0, y: 1.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
}
