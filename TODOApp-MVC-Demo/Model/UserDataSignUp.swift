//
//  userDataSignUp.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct UserDataSignUp: Codable {
    var id: String
    var name, email: String
    var age: Int
    var createdAtTime: String
    var UpdatedAtTime: String
    var v: Int
      enum CodingKeys: String, CodingKey {
          case age, name, email
          case id = "_id"
          case createdAtTime = "createdAt"
          case UpdatedAtTime = "updatedAt"
          case v = "__v"
      }
    
}
