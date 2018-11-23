//
//  SessionViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/14/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit
class OperatorSessionCell: UICollectionViewCell{
    
    @IBOutlet weak var userImageView: RoundImageView!
    @IBOutlet weak var nameLabel: UILabel!
}

class SessionViewController: UIViewController {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var startedLabel: UILabel!
    @IBOutlet weak var finishedLabel: UILabel!
    @IBOutlet weak var avenueFirstLabel: UILabel!
    @IBOutlet weak var avenueSecondLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var session: Session?
    var operatorsInSession: [Operator] = []
    override func viewDidLayoutSubviews() {
        let flow = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flow.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 1)

        flow.minimumInteritemSpacing = 3
        flow.minimumLineSpacing = 3
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        BetterRideApi.getOperatorsInSession(responseHandler: responseHandler.self, sessionId: (session?.id!)!)
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
    private func responseHandler(response: OperatorResponse){
        operatorsInSession = response.operators!
        collectionView.reloadData()
    }
    @IBAction func addOperator(_ sender: Any) {
        
    }
    @IBAction func editSessionOperatorAction(_ sender: UIBarButtonItem) {
        
    }
    
}

extension SessionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return operatorsInSession.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OperatorSessionCell", for: indexPath) as! OperatorSessionCell
        if indexPath.row == operatorsInSession.count{
            if operatorsInSession.count == 4{
                cell.nameLabel.text = "Editar"
                cell.userImageView.image = UIImage(named: "comprobado")
            }else{
                cell.nameLabel.text = "Agregar"
                cell.userImageView.image = UIImage(named: "mas")
            }
        }else{
            cell.nameLabel.text = operatorsInSession[indexPath.row].name!
            cell.userImageView.setImage(fromUrlString: operatorsInSession[indexPath.row].photo!, withDefaultNamed: "user-icon", withErrornamed: "")
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == operatorsInSession.count {
            let dialogsStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let customDialog = dialogsStoryboard.instantiateViewController(withIdentifier: "Dialog") as! AddEditOperatorViewController
            
            customDialog.animate = true
            customDialog.animateDirection = .bottom
            customDialog.sessionId = session!.id!
            customDialog.definesPresentationContext = true
            customDialog.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            customDialog.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            self.present(customDialog, animated: false, completion: nil)
        }
    }
}
