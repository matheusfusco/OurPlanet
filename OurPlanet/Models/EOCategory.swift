//
//  EOCategory.swift
//  OurPlanet
//
//  Created by Matheus on 27/09/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import Foundation

struct EOCategory {
    
    let id: Int
    let name: String
    let description: String
    let endpoint: String
    var events = [EOEvent]()
    
    init?(json: [String: Any]) {
        guard let id = json["id"] as? Int,
            let name = json["title"] as? String,
            let description = json["description"] as? String else {
                return nil
        }
        
        self.id = id
        self.name = name
        self.description = description
        self.endpoint = "\(EONET.categoriesEndpoint)/\(id)"
    }
}

extension EOCategory: Equatable {
    
    static func ==(lhs: EOCategory, rhs: EOCategory) -> Bool {
        return lhs.id == rhs.id
    }
}
