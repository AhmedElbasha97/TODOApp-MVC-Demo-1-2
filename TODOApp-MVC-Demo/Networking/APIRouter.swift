//
//  APIRouter.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/9/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible{
    
    // The endpoint name
    case login(_ email: String, _ password: String)
    case getTodos
    case regestier(_ email: String, _ name: String, _ password: String, _ age: String)
    case SendToDo(_ description: String)
    case delteTheTask(_ taskId: String)
    case logOutTheUser
    case getUserData
    case upDateUserData(_ name: String = "", _ email:String = "", _ Age:String = "")
    // MARK: - HttpMethod
    private var method: HTTPMethod {
        switch self{
        case .upDateUserData:
            return .put
        case .getTodos, .getUserData:
            return .get
        case .delteTheTask:
            return .delete
        default:
            return .post
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .login(let email, let password):
            return [ParameterKeys.email: email, ParameterKeys.password: password]
        case .regestier(let email, let name, let Password, let age):
            return [ParameterKeys.name: name,
            ParameterKeys.email: email,
            ParameterKeys.password: Password,
            ParameterKeys.age: Int(age) ?? 0]
        case .SendToDo(let description):
           return [ParameterKeys.description: description]
        case .upDateUserData(let name, let email, let age):
            var params: [String: Any] = [:]
               if  name != ""{
                   params[ParameterKeys.name] = name
               }else if email != ""{
                  params[ParameterKeys.email] = email
               }else if age != ""{
                  params[ParameterKeys.age] = Int(age) ?? 0
               }
            return params
        default:
            return nil
        }
    }
    // MARK: - Path
    private var path: String {
        switch self {
        case .login:
            return URLs.login
        case .getTodos:
            return URLs.task
        case .regestier:
            return URLs.register
        case .SendToDo:
            return URLs.task
        case .delteTheTask(let taskId):
            return URLs.task + "/\(taskId)"
        case .logOutTheUser:
            return URLs.logout
        case .getUserData:
            return URLs.logInViaToken
        case .upDateUserData:
            return URLs.logInViaToken 
        }
    }
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try URLs.base.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //httpMethod
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getTodos, .SendToDo, .delteTheTask, .upDateUserData:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")" ,forHTTPHeaderField: HeaderKeys.Authorization)
            urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
        case .logOutTheUser, .getUserData:
            urlRequest.setValue("Bearer \(UserDefaultsManager.shared().token ?? "")",forHTTPHeaderField: HeaderKeys.Authorization)
        default:
            urlRequest.setValue("application/json", forHTTPHeaderField: HeaderKeys.contentType)
                   
        }
      
        
        // HTTP Body
        let httpBody: Data? = {
            switch self {
            default:
                return nil
            }
        }()
        
        // Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get, .delete:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        print(try encoding.encode(urlRequest, with: parameters))
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}

extension APIRouter {
    private func encodeToJSON<T: Encodable>(_ body: T) -> Data? {
        do {
            let anyEncodable = AnyEncodable(body)
            let jsonData = try JSONEncoder().encode(anyEncodable)
            let jsonString = String(data: jsonData, encoding: .utf8)!
            print(jsonString)
            return jsonData
        } catch {
            print(error)
            return nil
        }
    }
}

// type-erasing wrapper
struct AnyEncodable: Encodable {
    private let _encode: (Encoder) throws -> Void
    
    public init<T: Encodable>(_ wrapped: T) {
        _encode = wrapped.encode
    }
    
    func encode(to encoder: Encoder) throws {
        try _encode(encoder)
    }
}
