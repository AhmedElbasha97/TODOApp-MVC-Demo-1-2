//
//  ToDoUser.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
     
struct ToDoData: Codable {
    var completed: Bool
    var id: String
    var description: String
    var owner: String
    var creadetAtTime: String
    var upDatedAtTime: String
    var v: Int
    enum CodingKeys: String, CodingKey {
        case completed
        case id = "_id"
        case description, owner
        case creadetAtTime = "createdAt"
        case upDatedAtTime = "updatedAt"
        case v = "__v"
         }
        
    }
    

