//
//  SignUpResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct SignUpResponse: Codable {
    var token: String
    var user: UserDataSignUp
    enum CodingKeys: String, CodingKey {
           case token, user
       }
}
