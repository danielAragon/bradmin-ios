//
//  OperatorsViewController.swift
//  iBetterRide
//
//  Created by Mauricio Rivas Arroyo on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

private let reuseIdentifier = "OperatorCell"

class OperatorsViewController: UITableViewController {

    var operators: [Operator] = [Operator]()
    var currentRow = 0  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BetterRideApi.getOperator(responseHandler: self.handleResponse,
                                 errorHandler: self.handleError)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    
    func handleResponse(response: OperatorResponse){
        if response.code != "200"{
            print("Error in response: \(response.message!)")
            return
        }
        if let operators = response.operators {
            self.operators =  operators
            self.tableView.reloadData()
        }
        print("Operators count: \(response.operators!.count)")
    }
    
    func handleError(error: Error){
        print("Error while requesting Operators: \(error.localizedDescription)")
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.operators.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! OperatorCell

        cell.update(from: operators[indexPath.row])
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOperator"{
            let destination = segue.destination as! OperatorViewController
            destination.operator1 = operators[currentRow]
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
    }
  

}
