//
//  RWErrorMessage.swift
//  RoamWheely
//
//  Created by Gustavo Colaço on 17/07/21.
//

import Foundation

enum RWErrorMessage: String, Error {

    case unableToSaveOption = "There was an error trying to save option. Please try again!"
    case notEnoughSlices    = "not enough slices. Should have at least two slices!"
    case genericError       = "Oooops something went wrong"
}
