//
//  OptionsVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class OptionsVC: UIViewController {
    
    private let tableView       = UITableView()
    private let goToWheelyBtn   = RoamWheelyButton(backgroundColor: .systemPurple, image: Images.wheelBtnImg!)

    
    var options: [Option] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        configureGoToWheelyButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        getOptions()
    }
    
     
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        title                                                   = "Options"
        navigationController?.navigationBar.prefersLargeTitles  = true
        let addOptions = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavoriteButtonPressed))
        navigationItem.rightBarButtonItem                       = addOptions
        navigationItem.rightBarButtonItem?.tintColor            = .systemOrange
    }
    
    
    private func updateUIWith(with options: [Option]) {
        if options.isEmpty {
            self.showEmptyStateView(with: "You don't have any options. Add one by tapping the \"+\" sign!", in: self.view)
            self.goToWheelyBtn.isHidden = true
        } else {
            self.options = options
            DispatchQueue.main.async {
                self.goToWheelyBtn.isHidden = false
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    
    private func getOptions() {
        PersistenceManager.retrieveOptions { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let options):
                self.updateUIWith(with: options)
            case .failure(let error):
                self.presentRoamWheelyALertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame             = view.bounds
        tableView.rowHeight         = 110
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.separatorStyle    = .none
        tableView.removeExcessCells()
        
        tableView.register(OptionsCell.self, forCellReuseIdentifier: OptionsCell.reuseID)
    }
    
    
    private func configureGoToWheelyButton() {
        tableView.addSubview(goToWheelyBtn)
        goToWheelyBtn.layer.cornerRadius = 50
        goToWheelyBtn.addTarget(self, action: #selector(goToWheelyButtonPressed), for: .touchUpInside)
        
        let centerXConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 100 : 125
        
        NSLayoutConstraint.activate([
            goToWheelyBtn.bottomAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            goToWheelyBtn.centerXAnchor.constraint(equalTo: tableView.centerXAnchor, constant: centerXConstant),
            goToWheelyBtn.widthAnchor.constraint(equalToConstant: 100),
            goToWheelyBtn.heightAnchor.constraint(equalToConstant: 100)
        
        ])
        
    }
    
    @objc private func goToWheelyButtonPressed() {
        let destVC = WheelyVC()
        destVC.modalPresentationStyle  = .overFullScreen
        destVC.modalTransitionStyle    = .crossDissolve
        self.present(destVC, animated: true)
    }
    
    @objc private func addFavoriteButtonPressed() {
        let addOptionVC = AddOptionsVC()
        navigationController?.pushViewController(addOptionVC, animated: true)
    }

}



extension OptionsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OptionsCell.reuseID, for: indexPath) as! OptionsCell
        let option = options[indexPath.row]
        cell.set(option: option)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {return}
        
        let option  = options[indexPath.row]
        PersistenceManager.updateWith(option: option, actionType: .remove) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {
                self.options.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                return
            }
            
            self.presentRoamWheelyALertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
            
        }
        
        
        if options.isEmpty {
            showEmptyStateView(with: "You don't have any options. Add one by tapping the \"+\" sign!", in: self.view)
            self.goToWheelyBtn.isHidden = true
        }
        
        
    }
    
    
}


