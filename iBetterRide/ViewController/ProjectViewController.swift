//
//  ProjectViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var numSessionsLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var project: Project?
    var sessions: [Session] = [Session]()
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let project = project,
            let nameLabel = nameLabel,
            let dateLabel = dateLabel,
            let numSessionsLabel = numSessionsLabel {
            nameLabel.text = project.name
            dateLabel.text = (project.date)!.padding(toLength: 10, withPad: "0", startingAt: 0)
            numSessionsLabel.text = String(project.num_session!)
            
            BetterRideApi.getSession(projectId: project.id!,
                                     responseHandler: self.handleResponse,
                                     errorHandler: self.handleError)
        }
    }
    
    func handleResponse(response: SessionsResponse){
        if response.code != "200"{
            print("Error in response: \(response.message!)")
            return
        }
        if let sessions = response.sessions {
            self.sessions = sessions
            self.tableView.reloadData()
        }
        print("Sources count: \(response.sessions!.count)")
    }
    
    func handleError(error: Error){
        print("Error while requesting Projects: \(error.localizedDescription)")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sessions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SessionCell
        cell.update(from: sessions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSession" {
            let destination = segue.destination as! SessionViewController
            destination.session = sessions[currentRow]
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        self.performSegue(withIdentifier: "showSession", sender: self)
    }

}
