//
//  AddSessionViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class AddSessionViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startedTextField: UITextField!
    @IBOutlet weak var finishedTextField: UITextField!
    @IBOutlet weak var avenueFirstTextField: UITextField!
    @IBOutlet weak var avenueSecondTextField: UITextField!
    private var datePicker: UIDatePicker?
    private var hourPicker: UIDatePicker?
    var session = Session()
    var project_id : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(AddSessionViewController.dateChange(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AddProjectViewController.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dateTextField.inputView = datePicker
        
        hourPicker = UIDatePicker()
        hourPicker?.datePickerMode = .time
        hourPicker?.addTarget(self, action: #selector(AddSessionViewController.startTimeDiveChanged(sender:)), for: .valueChanged)
        view.addGestureRecognizer(tapGesture)
        startedTextField.inputView = hourPicker
        finishedTextField.inputView = hourPicker
        
    }
    
    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        if startedTextField.isFocused == true {
            startedTextField.text = formatter.string(from: sender.date)
        }
        if finishedTextField.isFocused == true {
            finishedTextField.text = formatter.string(from: sender.date)
        }
        view.endEditing(true)
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
        session.id = ""
        session.date = dateTextField.text
        session.started_at = startedTextField.text
        session.finished_at = finishedTextField.text
        session.avenue_first = avenueFirstTextField.text
        session.avenue_second = avenueSecondTextField.text
        session.status = "pen"
        session.project_id = project_id!
        BetterRideApi.postSession(fromSession: session)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
