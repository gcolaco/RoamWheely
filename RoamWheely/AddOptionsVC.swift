//
//  AddOptionsVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

protocol AddOptionDelegate {
    func add(option: String)
}

class AddOptionsVC: UIViewController {
    
    
    let containerView   = RoamWheelyContainerView()
    let titleLabel      = RoamWheelyTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel    = RoamWheelyBodyLabel(textAlignment: .center)
    let optionTxtField  = RoamWheelyTextField()
    let actionButton    = RoamWheelyButton(backgroundColor: .systemGreen, title: "Add option")
    let cancelButton    = RoamWheelyButton(backgroundColor: .systemOrange, title: "Cancel")
    
    var alertTitle: String?
    var message: String?
    
    var delegate: AddOptionDelegate?
    
    var isOptionEntered: Bool {
        return !optionTxtField.text!.isEmpty
    }

    
    private let padding: CGFloat = 20
    
    
    init(title: String, message: String) {
        super.init(nibName: nil, bundle: nil)
        alertTitle          = title
        self.message        = message

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        view.addSubviews(containerView, titleLabel, cancelButton, actionButton, optionTxtField, messageLabel)
        createDismissKeyboardTapGesture()
        configureContainerView()
        configuretitleLabel()
        configureCancelButton()
        configureActionButton()
        configureTextField()
        configureMessageLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        optionTxtField.text = ""

    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    private func configureContainerView() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 90),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 300),
            containerView.heightAnchor.constraint(equalToConstant: 330)
        ])
    }
    
    
    private func configuretitleLabel() {
        titleLabel.text = alertTitle ?? " "
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    
    private func configureActionButton() {
        actionButton.setTitle("Add option", for: .normal)
        actionButton.addTarget(self, action: #selector(addOptionAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func configureCancelButton() {
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            cancelButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            cancelButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            cancelButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            cancelButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    
    private func configureTextField() {
        optionTxtField.resignFirstResponder()
        optionTxtField.delegate = self
        
        NSLayoutConstraint.activate([
            optionTxtField.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -16),
            optionTxtField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            optionTxtField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            optionTxtField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = message ?? " "
        messageLabel.numberOfLines = 4
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: optionTxtField.topAnchor, constant: -12)
            
        ])
        
    }
    
    
    @objc private func addOptionAction() {
        guard isOptionEntered else {
            let alert = UIAlertController(title: "🚨 Ooops", message: "An option can't be empty.", preferredStyle: .alert)
            let cancelButton    = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            present(alert, animated: true)
            return
        }
        delegate?.add(option: optionTxtField.text!)
        dismiss(animated: true)
    }
    
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
    
}


extension AddOptionsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
