//
//  ProfileVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/1/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ProfileVC: UITableViewController {
    //MARK:- Outlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var ageLbL: UILabel!
    @IBOutlet weak var emaiLBL: UILabel!
    @IBOutlet weak var nameLBL: UILabel!
    @IBOutlet weak var logOutBTN: UIButton!
    @IBOutlet weak var EditBTN: UIButton!
    
   //MARK: variables
   private var id: String!
   private var imagePicker: ImagePicker!
   private var textField1: UITextField?
   private var textField2: UITextField?
   private var textField3: UITextField?
   private var textField4: UITextField?
    

   // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getDataOfTheUser()
        setUpSubViews()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        // Do any additional setup after loading the view.
    }
    //MARK: buttons
    //MARK: edit button
    @IBAction func editBTN(_ sender: Any) {
        present(showEditAlert(), animated: true)
    }
    //MARK: add user image button
    @IBAction func addUserImage(_ sender: UIButton) {
        imagePicker.present(from: sender )
    }
    //MARK: log out button
    @IBAction func loggingOut(_ sender: Any) {
         LogOut(token: UserDefaultsManager.shared().token!)
     
        self.navigationController!.pushViewController(SignInVC.create(), animated: true)
            UserDefaultsManager.shared().token = nil
            
    
    }
    // MARK:- Puplic Method
    class func create() -> ProfileVC {
        let profileVC: ProfileVC = UIViewController.create(storyboardName: Storyboards.profile, identifier: ViewControllers.profilVC)
        return profileVC
    }
}

extension ProfileVC: UITextFieldDelegate{
    //MARK:- private Methods
    //MARK:- APIS
    //MARK:- send user image
    private func sendUserImage(image: UIImage){
        APIManager.uploadImage(userimage: image) { (result) in
            if result{
                self.SetTheStateOfTheImage(setTheState: 2, UserImage: image)
            }else{
                  self.showAlert(title: "something happen wrong", massage: "your image will not be uploaded please try again later")
            }
        }
    }
    //MARK:- log out user
   private func LogOut(token:String) {
    APIManager.logOutTheUser { (response) in
        switch response{
        case .failure(let error):
            print("\(error.localizedDescription)")
            self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
        case .success(_ ):
            self.GoToSignInVC()
        }
    }
                
        
    }
    
    //MARK:- get user data
    private func getDataOfTheUser() {
       
        self.view.showLoader()
        APIManager.getUserData { (response) in
            switch response{
            case .failure(let error):
                print("\(error.localizedDescription)")
                self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
            case .success(let UserData):
                       self.id = UserData.id
                       self.ageLbL.text = "\(UserData.age)"
                       self.nameLBL.text = "\(UserData.name)"
                       self.emaiLBL.text = "\(UserData.email)"
                self.SetTheStateOfTheImage(username: UserData.name, setTheState: 2)
            }
        }
        self.view .hideLoader()
    }
    //MARK:- edit user profile
    private func editUserProfile(name: String = "", age: String = "", email:String = ""){
        APIManager.updteDataOfTheUser(name: name, email: email, Age: age) { (response) in
            switch response{
            case .failure(let error):
                print("\(error.localizedDescription)")
                self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
            case .success(let UserData):
                self.id = UserData.userData.id
                self.ageLbL.text = "\(UserData.userData.age)"
                self.nameLBL.text = "\(UserData.userData.name)"
                self.emaiLBL.text = "\(UserData.userData.email)"
                
            }
        }
    }
    //MARK:- determine image come from where
    private func SetTheStateOfTheImage(username: String = "", setTheState: Int, UserImage: UIImage? = nil){
        switch setTheState{
        case 1:
            self.userImage.image = UserImage
        case 2:
            APIManager.getYourImage(userId: id) { (error, userImage) in
                if let error = error{
                    if UserDefaultsManager.shared().setTheState != nil{
                   self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
                        self.userImage.setImageForName(username , backgroundColor: nil, circular: true, textAttributes: nil)
                        
                        }else{
                         self.userImage.setImageForName(username , backgroundColor: nil, circular: true, textAttributes: nil)                    }
                }else if userImage != nil{
                    if let userimage = userImage{
                    self.userImage.image = userimage
                    }
                }else{
              self.userImage.setImageForName(username , backgroundColor: nil, circular: true, textAttributes: nil)
                }
            }
        default:
               userImage.setImageForName(username , backgroundColor: nil, circular: true, textAttributes: nil)
        }
    }
       // MARK:- go sign in vc
        private func GoToSignInVC(){
                  let signInVc = SignInVC.create()
           let navigationController = UINavigationController(rootViewController: signInVc)
           AppDelegate.shared().window?.rootViewController = navigationController
        }
   

    //MARK:- Set up sub views
    private func setUpSubViews(){
       shapeTheBTN(BTN: logOutBTN)
        shapeTheBTN(BTN: EditBTN)
         navigationItem.title = "Profile"
   
    }

}
//MARK:- user choose image
extension ProfileVC: ImagePickerDelegate{
    func didSelect(image: UIImage?) {
        sendUserImage(image: (image ?? nil)!)
        SetTheStateOfTheImage(setTheState: 2, UserImage: image)
        UserDefaultsManager.shared().setTheState = true
    }
    
    
}
//MARK: Edit Alert
extension ProfileVC{
       //MARK:- show ALERT FOR EDIT PROFILE
       private func showAlertForEdit(){
            self.present(showEditAlert(), animated: true)
       }
       //MARK:- ALERT FOR EDIT PROFILE
       private func showEditAlert() -> UIAlertController{
           let alertEmailAddEditView:UIAlertController = {

           let alert = UIAlertController(title:"My App", message: "Customize Edit Email or Age or Name Pop Up", preferredStyle:UIAlertController.Style.alert)

           //ADD TEXT FIELD (YOU CAN ADD MULTIPLE TEXTFILED AS WELL)
       
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.placeholder = "user name"
               self.textField1 = textField
           }
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.keyboardType = UIKeyboardType.emailAddress
               self.textField2 = textField
               textField.placeholder = "user E-Mail"
           }
    
           alert.addTextField { (textField : UITextField!) -> Void in
               textField.delegate = self
               textField.keyboardType = UIKeyboardType.numberPad
               self.textField4 = textField
               textField.placeholder = "user Age"
           }

           //SAVE BUTTON
           let save = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { saveAction -> Void in
               let textField = alert.textFields![0] as UITextField
               let textField2 = alert.textFields![1]
               let textField3 = alert.textFields![2]
               self.checkVedlity(name: textField.text ?? "", age: textField3.text ?? "" , email: textField2.text ?? "")
           })
           //CANCEL BUTTON
           let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
               (action : UIAlertAction!) -> Void in })


           alert.addAction(save)
           alert.addAction(cancel)

           return alert
       }()
           return alertEmailAddEditView
       }
       //MARK:- check validation
       private func checkVedlity(name: String = "", age: String = "", email:String = ""){
           if fieldIsNotEmpty(field: name){
                self.editUserProfile(name: name, age: age, email: email)
           }else if fieldIsNotEmpty(field: email){
               if isValidEmail(candidate: email){
                   self.editUserProfile(name: name, age: age, email: email)
               }else{
                   showAlert(title: "it is not valid email", massage: "please enter valid email")
                   }
               }else if fieldIsNotEmpty(field: age){
                self.editUserProfile(name: name, age: age, email: email)
           }else{
               showAlert(title: "you didnt enter any thing", massage: "please enter anything to edit your profile.")
           }
       }
}
