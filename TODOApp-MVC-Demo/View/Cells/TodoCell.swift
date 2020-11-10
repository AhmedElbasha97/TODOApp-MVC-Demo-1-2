//
//  TodoCell.swift
//  TODOApp-MVC-Demo
//
//  Created by ahmedelbash on 11/5/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class TodoCell: UITableViewCell {

    @IBOutlet weak var desriptionLbl: UILabel!
     var delegate: showAlertOfDeletingDelegate?
    var callback : ((UITableViewCell) -> Void)?
    var idOfTheTask: String!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(todo: String, idOfToDo: String) {
         desriptionLbl.text = todo
        idOfTheTask = idOfToDo
         
     }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func deletBtn(_ sender: UIButton) {
       callback?(self)
        self.delegate?.showAlertOfDeleting(customTableViewCell: self, didTapButton: sender , taskId: idOfTheTask)
    }
    
}
protocol showAlertOfDeletingDelegate{
    func showAlertOfDeleting(customTableViewCell: UITableViewCell, didTapButton button: UIButton, taskId: String)
}
