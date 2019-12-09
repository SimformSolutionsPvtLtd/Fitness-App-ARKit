//
//  AbstractNode.swift
//  WorkoutDemo
//
//  Created by Vishal Patel on 24/10/19.
//  Copyright © 2019 Vishal Patel. All rights reserved.
//

import SceneKit

class AbstractNode: SCNNode {
    
    override init() { super.init() }
    
    required init?(coder aDecoder: NSCoder) { fatalError() }
    
}// End of Class

extension SCNNode {
    
    func addChildNodes(_ nodes: SCNNode...) { addChildNodes(nodes) }
    
    func addChildNodes(_ nodes: [SCNNode]) { nodes.forEach { addChildNode($0) } }
    
}// End of Extension
