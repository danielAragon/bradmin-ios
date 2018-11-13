//
//  AddProjectViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    private var datePicker: UIDatePicker?
    var project = Project()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddProjectViewController.dateChange(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddProjectViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
        dateTextField.inputView = datePicker
        project.id = ""
        project.name = nameTextField.text
        project.date = "2018-11-23"
        project.supervisor_id = "1"
        project.num_session = 0
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

    func handleResponse(response: PostResponse){
        if response.code != "200" {
            print("Error in response: \(response.message!)")
            return
        }
    }
    
    func handleError(error: Error){
        print("Error while requesting AddProject: \(error.localizedDescription)")
    }
    
    @IBAction func doneAction(_ sender: UIBarButtonItem) {
        BetterRideApi.postProject(fromProject: project,
                                  responseHandler: handleResponse.self,
                                  errorHandler: handleError.self)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
