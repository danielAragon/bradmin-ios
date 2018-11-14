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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveAction(_ sender: UIBarButtonItem) {
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
