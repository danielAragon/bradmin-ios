//
//  OperatorCell.swift
//  iBetterRide
//
//  Created by Mauricio Rivas Arroyo on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class OperatorCell: UITableViewCell {
    @IBOutlet weak var operatorImageView: UIImageView!
    
    @IBOutlet weak var operatorNameLabel: UILabel!
    
    @IBOutlet weak var operatorLastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(from operator1: Operator){
        operatorImageView.setImage(fromUrlString: operator1.photo, withDefaultNamed: "operatorPlaceHolder", withErrornamed: "operatorPlaceHolder")
        operatorNameLabel.text = operator1.name
        operatorLastNameLabel.text = operator1.last_name
        
    }
}
