//
//  ProjectsViewController.swift
//  iBetterRide
//
//  Created by Silvana Stipetich Santillán on 11/7/18.
//  Copyright © 2018 Better Ride. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class ProjectsViewController: UITableViewController, AddProjectViewControllerDelegate {
    func controller(controller: AddProjectViewController, project: Project) {
        self.projects.append(project)
        self.tableView.reloadData()
        self.dismiss(animated: true, completion: nil)
    }
    
    var projects: [Project] = [Project]()
    var currentRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BetterRideApi.getProject(responseHandler: self.handleResponse,
                                 errorHandler: self.handleError)
    }

    func handleResponse(response: ProjectsResponse){
        if response.code != "200"{
            print("Error in response: \(response.message!)")
            return
        }
        if let projects = response.projects {
            self.projects = projects
            self.tableView.reloadData()
        }
        print("Sources count: \(response.projects!.count)")
    }
    
    func handleError(error: Error){
        print("Error while requesting Projects: \(error.localizedDescription)")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProjectCell
        cell.update(from: projects[indexPath.row])
        return cell
    }
 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if (projects[indexPath.row].num_session == 0) {
                projects.remove(at: indexPath.row)
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Denied Action", message: "Unable to delete an initiated project.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func editButton(_ sender: UIBarButtonItem) {
        self.isEditing = !self.isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue,
                          sender: Any?) {
        if segue.identifier == "showAddProject" {
            let destination = segue.destination as! AddProjectViewController
            destination.delegate = self
        }
        if segue.identifier == "showProject" {
            let destination = segue.destination as! ProjectViewController
            destination.project = projects[currentRow]
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        currentRow = indexPath.row
        self.performSegue(withIdentifier: "showProject", sender: self)
    }
}
