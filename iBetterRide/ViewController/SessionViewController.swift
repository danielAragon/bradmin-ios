//
//  SessionViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class SessionViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var finishedLabel: UILabel!
    @IBOutlet weak var avenueFirstLabel: UILabel!
    @IBOutlet weak var avenueSecondLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    var session: Session?
    override func viewDidLoad() {
        super.viewDidLoad()

        if let session = session,
            let dateLabel = dateLabel,
            let startedLabel = startedLabel,
            let finishedLabel = finishedLabel,
            let avenueFirstLabel = avenueFirstLabel,
            let avenueSecondLabel = avenueSecondLabel,
            let statusLabel = statusLabel{
            
            dateLabel.text = (session.date)!.padding(toLength: 10, withPad: "0", startingAt: 0)
            startedLabel.text = session.started_at
            finishedLabel.text = session.finished_at
            avenueFirstLabel.text = session.avenue_first
            avenueSecondLabel.text = session.avenue_second
            if(session.status == "rea"){
                statusLabel.text = "finished"
            }else{
                statusLabel.text = "unfinished"
            }
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
