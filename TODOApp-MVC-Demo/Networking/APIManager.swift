//
//  APIManager.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    //MARK:- log in The User
    class func LogIn(email: String, password: String, completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.login(email, password)) { (resonse) in
            completion(resonse)
        }
        
    }
    //MARK:- upload Data Of The User
    class func Registier(name: String, email:String, Age:String, password: String,  completion: @escaping (Result<LoginResponse, Error>)-> ()){
        request(APIRouter.regestier(email, name, password, Age)) {(response) in
           completion(response)
          }
    }
    //MARK:- upload Data Of The task
       class func addTask (task:String, completion: @escaping (Result<SendTaskReponse, Error>)-> ()){
       request(APIRouter.SendToDo(task)) {(response) in
          completion(response)
         }
         
     }
    //MARK:- get Data Of The task
     class func getTodos(completion: @escaping (Result<GetTaskDataResponse, Error>)-> ()){
            request(APIRouter.getTodos){ (response) in
                completion(response)
            }
        }
    //MARK:- get Data Of The User
    class func getUserData (completion: @escaping (Result<UserDataSignUp, Error>)-> ()){
    request(APIRouter.getUserData){ (response) in
        completion(response)
    }
    }
         
    //MARK:- log out Of The User
    class func logOutTheUser (completion: @escaping (Result<LogOutResponse, Error>)-> ()){
    request(APIRouter.logOutTheUser){ (response) in
        completion(response)
    }
    }
    //MARK:- delete the task
    class func DelteTaskByid(taaskId: String,completion: @escaping (Result<DelTaskResponse, Error>)-> ()){
    request(APIRouter.delteTheTask(taaskId)){ (response) in
        completion(response)
    }
       
    }
    //MARK:- upload image of The User
    class func uploadImage(userimage: UIImage, completion:  @escaping (_ result: Bool) -> Void){
        guard let token = UserDefaultsManager.shared().token else {return}
        guard let UserImage = userimage.jpegData(compressionQuality: 0.8) else { return }
        let headers: HTTPHeaders = [ HeaderKeys.Authorization: " Bearer \(token)",
            ]
        AF.upload(multipartFormData: { (MultipartFormData) in
            MultipartFormData.append(UserImage, withName: "avatar", fileName: "/home/ali/Mine/c/nodejs-blog/public/img/blog-header.jpg", mimeType: "blog-header.jpg")
        }, to: URLs.uploadUserImage, method: .post, headers: headers).response {
        response in
        guard response.error == nil else {
            print(response.error!)
            completion(false)
            return
        }
           print("task deleted")
           completion(true)
        }
    }
    //MARK:- Get image of The User
    class func getYourImage(userId: String, completion:  @escaping (_ error: Error?, _ userImage: UIImage?) -> Void){
        AF.request(URLs.base + URLs.user + "/\(userId)" + URLs.getUserImage, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil).response {
        response in
        guard response.error == nil else {
            print(response.error!)
            completion(response.error, nil)
            return
        }
         guard let data = response.data else {
        print("didn't get any data from API")
        return
        }
          let userImage = UIImage(data: data)
            completion(nil, userImage)
        }
    }

//MARK:- updte Data Of The User
    class func updteDataOfTheUser(name: String = "", email:String = "", Age:String = "",completion: @escaping (Result<UpdateUserDataResponse, Error>)-> ()){
        request(APIRouter.upDateUserData(name, email, Age)) { (response) in
          completion(response)
        }
    
    }
}
extension APIManager{
    // MARK:- The request function to get results in a closure
    private static func request<T: Decodable>(_ urlConvertible: URLRequestConvertible, completion:  @escaping (Result<T, Error>) -> ()) {
        // Trigger the HttpRequest using AlamoFire
        AF.request(urlConvertible).responseDecodable { (response: AFDataResponse<T>) in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        .responseJSON { response in
            print(response)
        }
    }
}
