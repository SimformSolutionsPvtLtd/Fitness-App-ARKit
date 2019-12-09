//
//  TestNode.swift
//  WorkoutDemo
//
//  Created by Vishal Patel on 24/10/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import Foundation
import ARKit

class WorkoutNode: AbstractNode {
    
    // MARK: - Initialization
    init(hitResult: ARHitTestResult?, workout: String) {
        super.init()
        if let hitResult = hitResult {
            guard let workoutScene = SCNScene(named: "\(Model.path)\(workout)\(Model.extension)") else { return }
            self.position = SCNVector3Make(
                hitResult.worldTransform.columns.3.x,
                hitResult.worldTransform.columns.3.y ,
                hitResult.worldTransform.columns.3.z
            )
            self.scale = SCNVector3(0.005, 0.005, 0.005)
            
            workoutScene.rootNode.childNodes.forEach { (node) in
                self.addChildNodes([node])
            }
            
            // Add notification observer
            NotificationCenter.default.addObserver(self, selector: #selector(self.updateWorkoutSpeed(notification:)), name: .workoutSpeed, object: nil)
        }
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
    override convenience init() { self.init() }
    
    // MARK: - Selector Function
    @objc func updateWorkoutSpeed(notification: Notification) {
        if let rate = notification.userInfo?[Key.workoutSpeedValue] as? Float {
            self.childNodes.first?.animationPlayer(forKey: AnimationKey.speed)?.speed = CGFloat(rate)
        }
    }
    
}// End of Class
