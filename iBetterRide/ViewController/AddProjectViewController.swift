//
//  AddProjectViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

protocol AddProjectViewControllerDelegate {
    func controller(controller: AddProjectViewController, project: Project)
}

class AddProjectViewController: UIViewController {
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    private var datePicker: UIDatePicker?
    var project = Project()
    var delegate: AddProjectViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddProjectViewController.dateChange(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddProjectViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer){
        view.endEditing(true)
    }
    
    @objc func dateChange(datePicker: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
  
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
    
        project.id = ""
        project.name = nameTextField.text
        project.date = dateTextField.text
        project.supervisor_id = "1"
        project.num_session = 0
        BetterRideApi.postProject(fromProject: project)
        if let delegate = self.delegate {
            delegate.controller(controller: self, project: project)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
