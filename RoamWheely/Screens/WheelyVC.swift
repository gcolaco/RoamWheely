//
//  WheelyVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import UIKit

class WheelyVC: UIViewController {
    
    private let spinWheelButton         = RoamWheelyButton(backgroundColor: .systemPurple, title: "Spin")
    private let goToOptionsVCButton     = RoamWheelyButton(backgroundColor: .systemOrange, title: "+")
    private let backgroundImage         = UIImageView()
    
    private var wheelOptions:[Option]   = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(backgroundImage, goToOptionsVCButton)
        configureBackgroundImage()
        configureButtons()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getOptions()
        configureRoamWheely()
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
        goToOptionsVCButton.addTarget(self, action: #selector(goToOptionsVC), for: .touchUpInside)
        goToOptionsVCButton.layer.cornerRadius = 25
        
        NSLayoutConstraint.activate([
            
            goToOptionsVCButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            goToOptionsVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            goToOptionsVCButton.widthAnchor.constraint(equalToConstant: 50),
            goToOptionsVCButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    
    private func configureRoamWheely() {
        var slices = [Slice]()

        wheelOptions.forEach { op in
            let slice = Slice(option: op.optionName)
            slice.color = .random()
            slices.append(slice)
        }

        let roamWheely = RoamWheely(center: CGPoint.init(x: self.view.frame.width/2, y: (self.view.frame.height/2) - 80), diameter: 300, slices: slices)
        print("\(self.view.frame.height/2)")
        roamWheely.delegate = self
        view.addSubview(roamWheely)
    }

    
    @objc private func goToOptionsVC() {
        navigationController?.popViewController(animated: true)
    }
}


extension WheelyVC : RoamWheelyDelegate {
    func shouldSelectObject() -> Int? {
        return Int.random(in: 0...wheelOptions.count)
    }
    
    //If you want to get notified when the selection is complete the implement this function also
    func finishedSelecting(index: Int?, error: Error?) {
        if index != nil {
            print("\(wheelOptions[index!].optionName)")
        }
    }
    
}
