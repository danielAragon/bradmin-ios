//
//  SessionCell.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class SessionCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avenueFirst: UILabel!
    @IBOutlet weak var avenueSecond: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func update(from session: Session){
        nameLabel.text = "Session \((session.date)!.padding(toLength: 10, withPad: "0", startingAt: 0))"
        avenueFirst.text = session.avenue_first
        avenueSecond.text = session.avenue_second
    }
}
