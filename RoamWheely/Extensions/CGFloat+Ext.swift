//
//  CGFloat+Ext.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 18/07/21.
//

import UIKit

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    
    func toRadians() -> CGFloat {
        return (self * .pi) / 180.0
    }
    
}
