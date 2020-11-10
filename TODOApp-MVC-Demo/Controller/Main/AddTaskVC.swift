//
//  AddTaskVC.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 10/31/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit
protocol refreshDataDelegate: AnyObject {
    func refreshData()
}
class AddTaskVC: UIViewController {
   //MARK:- Outlets
    @IBOutlet weak var addTask: UITextField!
    @IBOutlet weak var addTaskBTN: UIButton!
    @IBOutlet weak var addTaskView: UIView!
    //MARK:- variables 
   weak var delegate: refreshDataDelegate?
    
    // MARK:- Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
  setUpSubViews()
    }
//MARK:- Buttons
    //MARK:- Exit Buuton
    @IBAction func exitBTN(_ sender: Any) {
             self.dismiss(animated: true, completion: nil)
    }
    //MARK:- Add Task Button
    @IBAction func AddTaskBtn(_ sender: Any) {
        if fieldIsNotEmpty(field: addTask.text ?? ""){
           SendTaskData(task: addTask.text ?? "")
            self.delegate?.refreshData()
            self.dismiss(animated: true, completion: nil)
          
        }else{
            showAlert(title: "There's no task to add", massage: "please input your task")
        }
        
    }
    //Mark:- puplic Method
    class func create() -> AddTaskVC {
        let addToDoVC: AddTaskVC = UIViewController.create(storyboardName: Storyboards.main, identifier: ViewControllers.addToDoVC)
        return addToDoVC
    }
}
extension AddTaskVC{
   //MARK:- private Methods
    //MARK:- APIS
        //MARK:- send task data
   private func SendTaskData(task: String){
    APIManager.addTask(task: task) { (response) in
        switch response{
        case .failure(let error):
            print("\(error.localizedDescription)")
        self.showAlert(title: "Something Went Wrong", massage: "\(error.localizedDescription)")
        case .success( _): break
           
        }
    }
       }
    
    //MARK:- sup views
    private func setUpSubViews(){
        shapeOfTextField(textView: addTask)
           self.navigationController?.isNavigationBarHidden = false
          shapeTheBTN(BTN: addTaskBTN)
          addTaskView.layer.cornerRadius = 25
          self.addTaskView.backgroundColor = UIColor(patternImage: UIImage(named: "\(Background.athentication)")! )
    }
}


