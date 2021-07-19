//
//  AddOptionsVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import UIKit

class AddOptionsVC: UIViewController {
    
    let wheelLogo       = UIImageView()
    let messageLabel    = RoamWheelyBodyLabel(textAlignment: .center)
    let optionTxtField  = RoamWheelyTextField()
    let actionButton    = RoamWheelyButton(backgroundColor: .systemGreen, title: "Add option")
    
    var isOptionEntered: Bool {
        return !optionTxtField.text!.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title                = "Add options"
        view.addSubviews(wheelLogo, actionButton, optionTxtField, messageLabel)
        createDismissKeyboardTapGesture()
        configureWheelImg()
        configureMessageLabel()
        configureTextField()
        configureActionButton()
    }
    
    private func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureWheelImg() {
        wheelLogo.translatesAutoresizingMaskIntoConstraints = false
        wheelLogo.image = Images.wheelOfFortune
        
        NSLayoutConstraint.activate([
            wheelLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            wheelLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wheelLogo.heightAnchor.constraint(equalToConstant: 200),
            wheelLogo.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    private func configureMessageLabel() {
        messageLabel.text = "Add the option for the Roam Wheely."
        
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: wheelLogo.bottomAnchor, constant: 16),
            messageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            messageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    
    private func configureTextField() {
        optionTxtField.delegate = self
        
        NSLayoutConstraint.activate([
            optionTxtField.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            optionTxtField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            optionTxtField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            optionTxtField.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    

    private func configureActionButton() {
        actionButton.setTitle("Add option", for: .normal)
        actionButton.addTarget(self, action: #selector(addOptionAction), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.topAnchor.constraint(equalTo: optionTxtField.bottomAnchor, constant: 16),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            actionButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    
    @objc private func addOptionAction() {
        guard isOptionEntered else {
            presentRoamWheelyALertOnMainThread(title: "🚨 Ooops", message: "An option can't be empty.", buttonTitle: "Ok")
            return
        }
        let option = Option(optionName: optionTxtField.text!)
        
        PersistenceManager.updateWith(option: option, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.optionTxtField.resignFirstResponder()
                self.presentRoamWheelyALertOnMainThread(title: "Success! ✅", message: "You have successfully add an option to the wheely", buttonTitle: "Ok")
                self.optionTxtField.text = ""
                return
            }
            self.presentRoamWheelyALertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
        }
    }
    

}

extension AddOptionsVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addOptionAction()
        return true
    }
    
}
