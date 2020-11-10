//
//  UpdateUserDataResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct UpdateUserDataResponse: Codable {
var result: Bool
var userData: UserDataSignUp
enum CodingKeys: String, CodingKey {
    case result = "success"
    case userData = "data"
    
}
}
