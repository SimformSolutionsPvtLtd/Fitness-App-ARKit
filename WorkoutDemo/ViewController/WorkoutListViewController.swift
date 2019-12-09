//
//  WorkoutListViewController.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 28/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit

class WorkoutListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var workoutData = [WorkoutModel]()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setup()
    }
    
    // MARK: - Custom Function
    func setup() {
        self.navigationController?.setCustomFont()
        let model = WorkoutModel()
        workoutData = model.getWorkoutData()
        tableView.reloadData()
    }
    
    // MARK: - Prepare For Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? Int {
            if let destinationVC = segue.destination as? WorkoutARSceneViewController {
                destinationVC.workout = workoutData[index]
            }
        }
    }
    
}// End of Class

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WorkoutListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? WorkoutTableViewCell else { return UITableViewCell() }
        cell.workoutData = workoutData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.workout, sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Cell.height
    }
    
}// End of Extension
