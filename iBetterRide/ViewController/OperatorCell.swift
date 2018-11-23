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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        operatorImageView.layer.borderWidth = 1
        operatorImageView.layer.masksToBounds = false
        operatorImageView.layer.borderColor = UIColor.black.cgColor
        operatorImageView.layer.cornerRadius = operatorImageView.frame.height/2
        operatorImageView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func update(from operator1: Operator){
        operatorImageView.setImage(fromUrlString: operator1.photo!, withDefaultNamed: "operatorPlaceHolder", withErrornamed: "operatorPlaceHolder")
        operatorNameLabel.text = "\(operator1.name!) \(operator1.last_name!)"
        
    }
}
