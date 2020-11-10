//
//  SignInVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class SignInVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sigininBtnOutlet: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSupViews()
        setUpNavBar()
    }
    //MARK:- buttons
    //MARK:- gotoSignUpVC
    @IBAction func signUpBTN(_ sender: Any) {
        self.navigationController!.pushViewController(SignUPVC.create(), animated: true)
    }
    //MARK:- signIn Button
    @IBAction func signInBTN(_ sender: Any) {
        if CheckFieldsIsNotEmpty(){
            if checkValidation(){
                loggingIn(email: emailTextField.text ?? "", Password: passwordTextField.text ?? ""){
                    self.GoToToDovc()
                }
            }
        }
         
        
    }
    // MARK:- Public Methods
    class func create() -> SignInVC {
        let signInVC: SignInVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signInVC)
        return signInVC
    }

}
extension SignInVC{
     //MARK:- supViews as textFields & Buttons
     private func setUpSupViews(){
         setUpTheBackGroundImage(imageName: "\(Background.athentication)")
              shapeTheBTN(BTN: sigininBtnOutlet)
             shapeOfTextField(textView: emailTextField)
              addIconToTextView(iconName: "emailIcon", textField: emailTextField)
              shapeOfTextField(textView: passwordTextField)
              addIconToTextView(iconName: "passwordIcon", textField: passwordTextField)
          
         
     }
     //MARK:- Navigation Bar
     private func setUpNavBar(){
           self.navigationController?.isNavigationBarHidden = true
               
     }
     // MARK:- Private Func
     // MARK:- API
    private func loggingIn(email: String, Password: String, completion: @escaping () -> Void){
        self.view.showLoader()
        APIManager.LogIn(email: email, password: Password) { (response) in
            switch (response){
            case .failure(let error):
                self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
                break
            case .success(let result):
                UserDefaultsManager.shared().token = result.token
                completion()
            }
        }
        self.view.hideLoader()
    }
 
     // MARK:- go todo list vc
     private func GoToToDovc(){
               let todoListVC = TodoListVC.create()
        let navigationController = UINavigationController(rootViewController: todoListVC)
        AppDelegate.shared().window?.rootViewController = navigationController
     }
}
//MARK:- Validatons
extension SignInVC{
    //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty() -> Bool{
        if fieldIsNotEmpty(field: emailTextField.text ?? ""){
          if fieldIsNotEmpty(field: passwordTextField.text ?? ""){
                 return true
          }else{
             showAlert(title: "There's No Password", massage: "please write your password")
          }
         }else{
            showAlert(title: "There's No E-Mail", massage: "please write your E-Mail")
         }
     return false
     }
     // MARK:- check validation
     private func checkValidation() -> Bool{
         if isValidEmail(candidate: emailTextField.text ?? ""){
             if validpassword(mypassword: passwordTextField.text ?? ""){
                 
                 return true
             }else{
            showAlert(title: "Password Is Weak", massage: "The Password Must Be Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character")
             }
         }else{
             showAlert(title: "This Isn't a Valid E-Mail", massage: "please put your valid E-Mail")
         }
         return false
     }
}
