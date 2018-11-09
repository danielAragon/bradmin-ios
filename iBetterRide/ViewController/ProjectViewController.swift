//
//  ProjectViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numSessionsLabel: UILabel!
    var project: Project?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let project = project,
            let nameLabel = nameLabel,
            let numSessionsLabel = numSessionsLabel {
            nameLabel.text = project.name
            dateLabel.text = (project.date)!.padding(toLength: 10, withPad: "0", startingAt: 0)
            numSessionsLabel.text = String(project.num_session!)
        }
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
