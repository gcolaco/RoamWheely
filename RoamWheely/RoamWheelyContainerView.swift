//
//  RoamWheelyContainerView.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class RoamWheelyContainerView: UIView {

      
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .systemBackground
        
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
    }

}
