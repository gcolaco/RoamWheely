//
//  RoamWheelyWinnerView.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 18/07/21.
//

import UIKit

protocol RoamWheelyWinnerViewDelegate {
    func handleDismissView()
}

class RoamWheelyWinnerView: UIView {
    
    private let winnerImg       = UIImageView()
    private let winnerLbl       = RoamWheelyTitleLabel(textAlignment: .center, fontSize: 26)
    private let actionButton    = RoamWheelyButton(backgroundColor: .systemGreen, title: "Ok!")
    
    var delegate: RoamWheelyWinnerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        addSubviews(winnerImg, winnerLbl, actionButton)
        configureWinnerImg()
        configureWinnerLabel()
        configureActionButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = .white
        
        layer.cornerRadius = 10
    }
    
    
    private func configureWinnerImg() {
        winnerImg.translatesAutoresizingMaskIntoConstraints = false
        winnerImg.image = Images.winnerImg
        
        NSLayoutConstraint.activate([
            winnerImg.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -60),
            winnerImg.centerXAnchor.constraint(equalTo: centerXAnchor),
            winnerImg.heightAnchor.constraint(equalToConstant: 150),
            winnerImg.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func configureWinnerLabel() {
        winnerLbl.text = "The winner is: "
        
        NSLayoutConstraint.activate([
            winnerLbl.topAnchor.constraint(equalTo: winnerImg.bottomAnchor, constant: 16),
            winnerLbl.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            winnerLbl.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            winnerLbl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
    
    
    private func configureActionButton() {
        actionButton.addTarget(self, action: #selector(handleActionButton), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func handleActionButton() {
        delegate?.handleDismissView()
    }
    
}
