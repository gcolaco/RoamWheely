//
//  RoamWheelyTextField.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class RoamWheelyTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("fatal error on RoamWheelyTextField")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 2
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        clearButtonMode             = .whileEditing
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .done
        
        placeholder                 = "Enter an option"
        
    }

}
