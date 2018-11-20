//
//  AddSessionViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

protocol AddSessionViewControllerDelegate {
    func controller(controller: AddSessionViewController, session: Session)
}

class AddSessionViewController: UIViewController {

    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var startedTextField: UITextField!
    @IBOutlet weak var finishedTextField: UITextField!
    @IBOutlet weak var avenueFirstTextField: UITextField!
    @IBOutlet weak var avenueSecondTextField: UITextField!
    private var datePicker: UIDatePicker?
    private var hourPicker: UIDatePicker?
    private var hourPickerSecond: UIDatePicker?
    var session = Session()
    var project_id : String?
    var delegate: AddSessionViewControllerDelegate?
    
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
        hourPicker?.addTarget(self, action: #selector(AddSessionViewController.startTimeDiveChangedFirst(sender:)), for: .valueChanged)
        view.addGestureRecognizer(tapGesture)
        
        hourPickerSecond = UIDatePicker()
        hourPickerSecond?.datePickerMode = .time
        hourPickerSecond?.addTarget(self, action: #selector(AddSessionViewController.startTimeDiveChangedSecond(sender:)), for: .valueChanged)
        view.addGestureRecognizer(tapGesture)
        
        startedTextField.inputView = hourPicker
        finishedTextField.inputView = hourPickerSecond
        
    }
    
    @objc func startTimeDiveChangedFirst(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        startedTextField.text = formatter.string(from: sender.date)
        view.endEditing(true)
    }
    
    @objc func startTimeDiveChangedSecond(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = "HH:mm"
        finishedTextField.text = formatter.string(from: sender.date)
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

    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        if (dateTextField.text != "" &&
            startedTextField.text != "" &&
            finishedTextField.text != "" &&
            avenueFirstTextField.text != "" &&
            avenueSecondTextField.text != ""){
                session.id = ""
                session.date = dateTextField.text
                session.started_at = startedTextField.text
                session.finished_at = finishedTextField.text
                session.avenue_first = avenueFirstTextField.text
                session.avenue_second = avenueSecondTextField.text
                session.status = "pen"
                session.project_id = project_id!
                BetterRideApi.postSession(fromSession: session)
                if let delegate = self.delegate {
                    delegate.controller(controller: self, session: session)
                }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
