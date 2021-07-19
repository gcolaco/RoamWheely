//
//  WheelyVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import UIKit

class WheelyVC: UIViewController {
    
    // MARK: - Properties
    private let spinWheelButton         = RoamWheelyButton(backgroundColor: .systemPurple, title: "Spin")
    private let goToOptionsVCButton     = RoamWheelyButton(backgroundColor: .systemOrange, title: "+")
    private let backgroundImage         = UIImageView()
    private let winnerView              = RoamWheelyWinnerView(frame: .zero)
    
    private var wheelOptions:[Option]   = []
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubviews(backgroundImage, goToOptionsVCButton)
        configureBackgroundImage()
        configureButtons()
        configureVisualEffectView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        getOptions()
        configureRoamWheely()
    }
    
    
    // MARK: - UI configurations
    private func getOptions() {
        PersistenceManager.retrieveOptions { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let options):
                self.wheelOptions = options
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
        roamWheely.delegate = self
        view.addSubview(roamWheely)
    }
    
    
    private func configureVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.pinToEdges(of: view)
        
        visualEffectView.alpha  = 0
        winnerView.alpha        = 0
    }
    
    
    private func configureWinnerView(winnerOption: String) {
        view.addSubview(winnerView)

        NSLayoutConstraint.activate([
            winnerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            winnerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            winnerView.widthAnchor.constraint(equalToConstant: view.frame.width - 64),
            winnerView.heightAnchor.constraint(equalToConstant: view.frame.width - 32)
        ])
        
        winnerView.transform        = CGAffineTransform(scaleX: 1.3, y: 1.3)
        winnerView.delegate         = self
        winnerView.winnerLbl.text   = winnerOption
        
        UIView.animate(withDuration: 0.5) {
            self.visualEffectView.alpha = 1
            self.winnerView.alpha       = 1
            self.winnerView.transform   = CGAffineTransform.identity
        }
        
    }

    
    // MARK: - Selectors and actions
    @objc private func goToOptionsVC() {
        dismiss(animated: true, completion: nil)
    }
}


    // MARK: - Extensions
extension WheelyVC: RoamWheelyDelegate {
    func shouldSelectObject() -> Int? {
        return Int.random(in: 0...wheelOptions.count)
    }
    
    
    func finishedSelecting(index: Int?, error: Error?) {
        if index != nil {
            let choosenOption = wheelOptions[index!].optionName
            self.configureWinnerView(winnerOption: choosenOption)
        }
    }
}


extension WheelyVC: RoamWheelyWinnerViewDelegate {
    func handleDismissView() {
        spinWheelButton.popUpAnimatedView(visualEffectView: visualEffectView, popUpView: winnerView)
    }

}
