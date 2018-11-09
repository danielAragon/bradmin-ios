//
//  OperatorViewController.swift
//  iBetterRide
//
//  Created by Mauricio Rivas Arroyo on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class OperatorViewController: UIViewController {

    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var LastNameLabel: UILabel!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var EmailLabel: UILabel!
    
    var operator1: Operator?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       if let operator1 = operator1,
          let pictureImageView = pictureImageView,
          let photo = operator1.photo,
          let nameLabel = NameLabel,
          let lastNameLable = LastNameLabel,
          let userNameLabel = UserNameLabel,
        let emailLabel = EmailLabel {
         pictureImageView.setImage(fromUrlString: photo, withDefaultNamed: "operatorPlaceHolder", withErrornamed: "operatorPlaceHolder")
         nameLabel.text = operator1.name
         lastNameLable.text = operator1.last_name
         userNameLabel.text = operator1.username
         emailLabel.text = operator1.email
        }
        
        
    }
  
}
