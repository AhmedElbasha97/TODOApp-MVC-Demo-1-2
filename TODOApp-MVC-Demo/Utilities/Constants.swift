//
//  Constants.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//


import Foundation


// Storyboards
struct Storyboards {
    static let authentication = "Authentication"
    static let main = "Main"
    static let profile = "Profile"
}

// View Controllers
struct ViewControllers {
    static let signUpVC = "SignUPVC"
    static let signInVC = "SignInVC"
    static let todoListVC = "TodoListVC"
    static let profilVC = "ProfileVC"
    static let addToDoVC = "AddTaskVC"
}

// Urls
struct URLs {
    static let base = "https://api-nodejs-todolist.herokuapp.com"
    static let user = "/user"
    static let login = user + "/login"
    static let register = user + "/register"
    static let task = "/task"
    static let logInViaToken = user + "/me"
    static let logout = user + "/logout"
    static let uploadUserImage = base + logInViaToken + "/avatar"
    static let getUserImage = "/avatar"
}

// Header Keys
struct HeaderKeys {
    static let Authorization = "Authorization"
    static let contentType = "Content-Type"
}

// Parameters Keys
struct ParameterKeys {
    static let email = "email"
    static let password = "password"
    static let name = "name"
    static let age = "age"
    static let description = "description"
}

// UserDefaultsKeys
struct UserDefaultsKeys {
    static let token = "UDKToken"
    static let setTheState = "setTheState"

}
//background
struct Background {
    static let lanchScreen = "My Post"
    static let athentication = "My Post (2)"
    static let insideTheApp = "My Post (3)"
}

// Cells
struct Cells {
    static let todoCell = "TodoCell"
}
