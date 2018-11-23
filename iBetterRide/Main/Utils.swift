//
//  Utils.swift
//  iBetterRide
//
//  Created by Daniel Aragon Ore on 11/21/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import Foundation
import UIKit
enum Direction{
    case top
    case bottom
    case right
    case left
}

class DialogBaseViewController: UIViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var dialogView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    var dialogViewFrame:CGRect?
    
    var animate:Bool?
    var animateDirection:Direction?
    
    var descriptionText:String?
    var titleText:String?
    
    var isFromReloadBalance: Bool = false
    
    let ANIMATE_DURATION = 0.2
    let DIALOG_CORNER_RADIUS = 5.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        
    }
 
    override func viewWillAppear(_ animated: Bool) {
        if self.animate != nil{
            self.animateDialogView(self.animate!)
        }
        else{
            self.animateDialogView(false)
        }
    }
    
    
    func initView(){
        self.addStyleToElements()
        self.setPositionToDialog()
    }
    
    func addStyleToElements(){
        self.contentView.layer.cornerRadius = CGFloat(10.0)
    }
    
    func setPositionToDialog(){
        
        var yDialogPosition = self.backgroundView.frame.size.height
        var xDialogPosition = self.dialogView.frame.origin.x
        
        if (self.animateDirection != nil){
            switch self.animateDirection! {
            case .top:
                yDialogPosition = self.backgroundView.frame.origin.y - self.dialogView.frame.size.height
                break
            case .left:
                xDialogPosition = self.backgroundView.frame.origin.x - self.dialogView.frame.size.width
                yDialogPosition = self.dialogView.frame.origin.y
                break
            case .right:
                xDialogPosition = self.backgroundView.frame.size.width
                yDialogPosition = self.dialogView.frame.origin.y
                break
            default:
                yDialogPosition = self.backgroundView.frame.size.height
                break
            }
        }
        self.dialogViewFrame = self.dialogView.frame
        self.dialogView.frame = CGRect(x: xDialogPosition,
                                       y: yDialogPosition,
                                       width: (self.dialogViewFrame?.size.width)!,
                                       height: (self.dialogViewFrame?.size.height)!)
    }
    
    func animateDialogView(_ value:Bool){
        if(value){
            UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.dialogView.frame = self.dialogViewFrame!
            })
        }
        else{
            self.dialogView.frame = self.dialogViewFrame!
        }
    }
    
}
class RoundImageView: UIImageView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        initialSetup()
    }
    func initialSetup()
    {
        layer.cornerRadius = bounds.width/2
    }
}
class RoundView: UIView
{
    override func layoutSubviews()
    {
        super.layoutSubviews()
        initialSetup()
    }
    func initialSetup()
    {
        layer.cornerRadius = bounds.width/2
    }
}
