//
//  EOError.swift
//  OurPlanet
//
//  Created by Matheus on 27/09/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation

enum EOError: Error {
    
    case invalidURL(String)
    case invalidParameter(String, Any)
    case invalidJSON(String)
}
