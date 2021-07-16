//
//  OptionsCell.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class OptionsCell: UITableViewCell {

    static let reuseID  = "OptionsCell"
    
    let usernameLabel   = RoamWheelyTitleLabel(textAlignment: .left, fontSize: 26)
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
    
    
    func set(option: String) {
        usernameLabel.text = option
    }
    
    
    private func configureBgView() {
        addSubview(bgView)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat        = 12
        bgView.backgroundColor      = .systemOrange
        
        bgView.layer.cornerRadius   = 20
        bgView.clipsToBounds        = true
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        
        ])
        
    }
    
    
    private func configureUserNameLabel() {
        addSubview(usernameLabel)
        
        let padding: CGFloat    = 8
        
        NSLayoutConstraint.activate([

            
            usernameLabel.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    

}

