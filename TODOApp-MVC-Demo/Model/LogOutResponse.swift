//
//  LogOutResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct LogOutResponse: Codable{
    var result: Bool
      
      enum CodingKeys: String, CodingKey {
          case result = "success"
          
          
      }
}
