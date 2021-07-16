//
//  OptionsVC.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

class OptionsVC: UIViewController {
    
    private let tableView       = UITableView()

    var options: [String]       = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.options = UserDefaults.standard.stringArray(forKey: "option") ?? []
        updateUIWith(with: options)
    }
    
     
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        title                                                   = "Options"
        navigationController?.navigationBar.prefersLargeTitles  = true
        let addOptions = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFavoriteButtonPressed))
        navigationItem.rightBarButtonItem                       = addOptions
        navigationItem.rightBarButtonItem?.tintColor            = .systemOrange
    }
    
    
    private func updateUIWith(with options: [String]) {
        if options.isEmpty {
            self.showEmptyStateView(with: "You don't have any options. Add one by tapping the \"+\" sign!", in: self.view)
        } else {
            self.options = options
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
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
    
    
    @objc private func addFavoriteButtonPressed() {
        let alert = UIAlertController(title: "Add option", message: "Add the option for the Roam Wheely.", preferredStyle: .alert)
        
        alert.addTextField { field in
            field.placeholder = "Enter Item"
        }
        
        let cancelButton    = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let doneButton      = UIAlertAction(title: "Add", style: .default) { [weak self] _ in
            guard let self = self else {return}
            
            if let field = alert.textFields?.first {
                if let text = field.text, !text.isEmpty {
                    DispatchQueue.main.async {
                        var currentOptions = UserDefaults.standard.stringArray(forKey: "option") ?? []
                        currentOptions.append(text)
                        UserDefaults.standard.setValue(currentOptions, forKey: "option")
                        self.options.append(text)
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            }
        }
        
        alert.addAction(cancelButton)
        alert.addAction(doneButton)
        
        present(alert, animated: true)
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
}


