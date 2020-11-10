//
//  sentTaskResponse.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
struct SendTaskReponse: Codable {
    var result: Bool
    var taskData: ToDoData
    enum CodingKeys: String, CodingKey {
        case result = "success"
        case taskData = "data"
        
    }
    
}
