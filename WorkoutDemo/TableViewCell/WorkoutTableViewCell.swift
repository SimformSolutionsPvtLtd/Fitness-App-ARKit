//
//  WorkoutTableViewCell.swift
//  WorkoutDemo
//
//  Created by Amit Kajwani on 28/11/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import UIKit

class WorkoutTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var workoutImageView: UIImageView!
    @IBOutlet weak var workoutNameLabel: UILabel!
    
    // MARK: - Variables
    var workoutData: WorkoutModel? {
        didSet {
            updateUI()
        }
    }
    
    // MARK: - View Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // MARK: - Custom Function
    func updateUI() {
        if let workoutData = self.workoutData {
            workoutImageView.image = workoutData.image
            workoutNameLabel.text = workoutData.name
        }
    }
    
}// End of Class
