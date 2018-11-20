//
//  ProfileViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/7/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var currentPassword: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    var supervisor: Supervisor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.masksToBounds = false
        photoImageView.layer.borderColor = UIColor.black.cgColor
        photoImageView.layer.cornerRadius = photoImageView.frame.height/2
        photoImageView.clipsToBounds = true
        
        BetterRideApi.getSupervisor(responseHandler: handleResponse.self, errorHandler: handleError.self)
        
    }
    
    func handleResponse(response: SupervisorResponse){
        if response.code != "200"{
            print("Error in response: \(response.message!)")
            return
        }
        if let supervisor = response.data {
            self.supervisor =  supervisor
            photoImageView.setImage(fromUrlString: (supervisor.photo)!,
                                    withDefaultNamed: "operatorPlaceHolder",
                                    withErrornamed: "operatorPlaceHolder")
            nameTextField.text = supervisor.name
            lastNameTextField.text = supervisor.last_name
            emailTextField.text = supervisor.email
            usernameTextField.text = supervisor.username
        }
    }
    
    func handleError(error: Error){
        print("Error while requesting Operators: \(error.localizedDescription)")
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        supervisor?.name = nameTextField.text
        supervisor?.last_name =  lastNameTextField.text
        supervisor?.email = emailTextField.text
        supervisor?.username = usernameTextField.text
        if currentPassword.text == supervisor?.password && newPasswordTextField.text != "" {
            supervisor?.password = newPasswordTextField.text
        }
        BetterRideApi.postProfileSupervisor(fromSession: supervisor)
        
        let alert = UIAlertController(title: "Changes saved", message: "Your profile changes were saved correctly.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
