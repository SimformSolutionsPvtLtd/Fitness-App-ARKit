//
//  WorkoutModel.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 28/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit

struct WorkoutModel {
    
    // MARK: - Parameter
    var name: String = ""
    var image: UIImage = UIImage()
    
    // MARK: - Custom Function
    func getWorkoutData() -> [WorkoutModel] {
        var workouts = [WorkoutModel]()
        let workoutNames = Workout.allCases.map({ $0.rawValue })
        for (index, name) in workoutNames.enumerated() {
            let model = WorkoutModel(name: name, image: UIImage(named: "\(index)")!)
            workouts.append(model)
        }
        return workouts
    }
    
}// End of Struct
