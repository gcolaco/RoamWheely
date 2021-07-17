//
//  UITableView+Ext.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 16/07/21.
//

import UIKit

extension UITableView {
 
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
 
}
