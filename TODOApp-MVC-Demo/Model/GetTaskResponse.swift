//
//  GetTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct GetTaskDataResponse: Codable {
    var counter: Int
    var data: [ToDoData]
     enum CodingKeys: String, CodingKey {
           case counter = "count"
           case data 
           
       }
    
}
