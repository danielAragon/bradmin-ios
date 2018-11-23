//
//  AddEditOperatorViewController.swift
//  iBetterRide
//
//  Created by Daniel Aragon Ore on 11/22/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

class AddEditOperatorViewController: DialogBaseViewController {
    var operators: [Operator]?
    var sessionId: String?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BetterRideApi.getOperatorsNotInSession(responseHandler: responseHandler.self, sessionId: sessionId!)
    }
    func responseHandler(response: OperatorResponse){
        self.operators = response.operators
        tableView.reloadData()
    }

}

extension AddEditOperatorViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operators?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
}
