//
//  SignUpVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/27/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//
import UIKit

class SignUPVC: UIViewController {
    //MARK:- Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var siginupBtnOutlet: UIButton!
    @IBOutlet weak var ageTextField: UITextField!
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
     setUpSupViews()
      setUpNavBar()
        
    }
   //MARK:- buttons
   //MARK:- goToSignInScreen
    @IBAction func goToSignInBTN(_ sender: Any) {
         self.navigationController!.pushViewController(SignInVC.create(), animated: true)
        
    }
    //MARK:- signUp
    @IBAction func signUpBTN(_ sender: Any) {
        if CheckFieldsIsNotEmpty(){
            if checkValidation(){
        SignUP(name:nameTextField.text ?? "" , Password: passwordTextField.text ?? "", Email: emailTextField.text ?? "" , Age: ageTextField.text ?? ""){
            self.GoToToDovc()
                }
            }
        }
    }
    // MARK:- Public Methods
    class func create() -> SignUPVC {
        let signUpVC: SignUPVC = UIViewController.create(storyboardName: Storyboards.authentication, identifier: ViewControllers.signUpVC)
        return signUpVC
    }

}
extension SignUPVC{
    //MARK:- supViews as textFields & Buttons
    private func setUpSupViews(){
        setUpTheBackGroundImage(imageName: "\(Background.athentication)")
             shapeTheBTN(BTN: siginupBtnOutlet)
             shapeOfTextField(textView: nameTextField)
             addIconToTextView(iconName: "userNameIcon", textField: nameTextField)
             shapeOfTextField(textView: emailTextField)
             addIconToTextView(iconName: "emailIcon", textField: emailTextField)
             shapeOfTextField(textView: passwordTextField)
             addIconToTextView(iconName: "passwordIcon", textField: passwordTextField)
             shapeOfTextField(textView: ageTextField)
             addIconToTextView(iconName: "userAge", textField: ageTextField)
        
    }
    //MARK:- Navigation Bar
    private func setUpNavBar(){
          self.navigationController?.isNavigationBarHidden = true
              
    }
    
    // MARK:- API
    private func SignUP(name: String, Password:String, Email:String, Age:String, completion: @escaping () -> Void ) {
        self.view.showLoader()
        APIManager.Registier(name: name, email: Email, Age: Age, password: Password) { (response) in
            switch response{
            case .failure(let error):
                self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
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
extension SignUPVC{
     //MARK:- Fields Isn't Empty
    private func CheckFieldsIsNotEmpty() -> Bool{
     if fieldIsNotEmpty(field: nameTextField.text ?? "" ){
        if fieldIsNotEmpty(field: emailTextField.text ?? ""){
          if fieldIsNotEmpty(field: passwordTextField.text ?? ""){
             if fieldIsNotEmpty(field:ageTextField.text ?? ""){
                 return true
             }else{
               showAlert(title: "There's No Age", massage: "please write your age")
             }
          }else{
             showAlert(title: "There's No Password", massage: "please write your password")
          }
         }else{
            showAlert(title: "There's No E-Mail", massage: "please write your E-Mail")
         }
     }else{
        showAlert(title: "There's No Name", massage: "please write your Name")
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
