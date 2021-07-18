//
//  InitialVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import UIKit

class InitialVC: UIViewController {
    
    private let spinWheelButton         = RoamWheelyButton(backgroundColor: .systemPurple, title: "Spin")
    private let goToOptionsVCButton     = RoamWheelyButton(backgroundColor: .systemOrange, title: "+")
    private let backgroundImage         = UIImageView()
    
    private var wheelOptions:[Option]   = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(backgroundImage, spinWheelButton, goToOptionsVCButton)
        configureBackgroundImage()
        configureButtons()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getOptions()
    }
    
    
    private func getOptions() {
        PersistenceManager.retrieveOptions { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let options):
                self.wheelOptions = options
                print("WheelOptions array count is: \(self.wheelOptions.count)")
            case .failure(let error):
                self.presentRoamWheelyALertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureBackgroundImage() {
        backgroundImage.image       = Images.backgroundImg
        backgroundImage.contentMode = .scaleAspectFill
        
        backgroundImage.pinToEdges(of: view)
        
    }
    
    
    private func configureButtons() {
        spinWheelButton.addTarget(self, action: #selector(spinWheel), for: .touchUpInside)
        goToOptionsVCButton.addTarget(self, action: #selector(goToOptionsVC), for: .touchUpInside)
        goToOptionsVCButton.layer.cornerRadius = 25
        
        NSLayoutConstraint.activate([
            spinWheelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            spinWheelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            spinWheelButton.widthAnchor.constraint(equalToConstant: 220),
            spinWheelButton.heightAnchor.constraint(equalToConstant: 50),
            
            goToOptionsVCButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            goToOptionsVCButton.leadingAnchor.constraint(equalTo: spinWheelButton.trailingAnchor, constant: 16),
            goToOptionsVCButton.widthAnchor.constraint(equalToConstant: 50),
            goToOptionsVCButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    @objc private func spinWheel() {
        spinWheelButton.buttonAnimation(spinWheelButton)
        
    }
    
    @objc private func goToOptionsVC() {
        let destVC = OptionsVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
}
