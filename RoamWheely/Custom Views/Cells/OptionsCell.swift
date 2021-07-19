//
//  OptionsCell.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class OptionsCell: UITableViewCell {

    static let reuseID  = "OptionsCell"
    
    let optionLabel     = RoamWheelyTitleLabel(textAlignment: .left, fontSize: 26)
    let bgView          = UIView()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        configureBgView()
        configureUserNameLabel()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(option: Option) {
        optionLabel.text = option.optionName
        bgView.makeGradientBg(.systemOrange, .systemRed)
    }
    
    
    private func configureBgView() {
        addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat        = 12
        
        bgView.layer.cornerRadius   = 20
        bgView.clipsToBounds        = true
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            bgView.heightAnchor.constraint(equalToConstant: 100)
        
        ])
             
    }
    
    
    private func configureUserNameLabel() {
        addSubview(optionLabel)
        
        let padding: CGFloat    = 12
        
        NSLayoutConstraint.activate([
            optionLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            optionLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: padding),
            optionLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -padding),
            optionLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}

