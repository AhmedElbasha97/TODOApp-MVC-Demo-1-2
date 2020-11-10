//
//  DelTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct DelTaskResponse: Codable {
    var result: Bool

    enum CodingKeys: String, CodingKey {
        case result = "success"

        
    }
    
}
