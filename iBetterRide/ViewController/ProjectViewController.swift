//
//  ProjectViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/8/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AddSessionViewControllerDelegate {
    func controller(controller: AddSessionViewController, session: Session) {
        self.sessions.append(session)
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
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
            if(sessions[indexPath.row].status != "rea"){
                sessions.remove(at: indexPath.row)
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Denied Action", message: "Unable to delete an initiated session.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        } 
    }

    @IBAction func editButton(_ sender: UIBarButtonItem) {
        self.tableView.isEditing = !self.tableView.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSession" {
            let destination = segue.destination as! SessionViewController
            destination.session = sessions[currentRow]
        }
        if segue.identifier == "showAddSession" {
            let destination = segue.destination as! AddSessionViewController
            destination.delegate = self
            destination.project_id = project?.id!
        }
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        self.performSegue(withIdentifier: "showSession", sender: self)
    }

}
