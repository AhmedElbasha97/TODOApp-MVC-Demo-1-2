//
//  FiltextField.swift
//  TODOAPP_MVC_DEMO
//
//  Created by ahmedelbasha on 10/29/20.
//  Copyright © 2020 ahmedelbasha. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func ShapeTheTextField(theTextField: UITextField){
        theTextField.layer.cornerRadius = 25
        theTextField.layer.borderWidth = 1
        theTextField.layer.borderColor = UIColor.white.cgColor
    }
    func shapeTheBTN(BTN: UIButton){
          BTN.backgroundColor = .clear

          BTN.layer.cornerRadius = BTN.frame.height / 2

          BTN.layer.borderWidth = 4
    

          BTN.layer.borderColor = UIColor.darkGray.cgColor
        
    }
    func shapeOfTextField(textView: UITextField){
        textView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        textView.layer.cornerRadius = 35
        textView.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
          textView.layer.borderWidth = 0.5
          textView.clipsToBounds = true
    }
    func addIconToTextView(iconName: String, textField: UITextField){
        let imageView = UIImageView(frame: CGRect(x: 8.0, y: 8.0, width: 24.0, height: 24.0))
        let image = UIImage(named: "\(iconName)")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
     

        let view = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 40))
        view.addSubview(imageView)
        
        textField.leftViewMode = UITextField.ViewMode.always
        textField.leftView = view
    }
}
