//
//  LayerProtocol.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 24/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

/**
 This protocol establishes all the basic properties and behaviors that
 a layer must provide.
 */
public protocol LayerProtocol {
    
    ///The node of the layer.
    var layerNode: SKNode { get }
    
    /**
     This method is triggered right after the layer is added to a scene.
     
     - parameter scene: The scene wich the layer was added in.
     */
    func wasAdded(to scene: SKScene)
    
    ///This method is called each time the scene is updated.
    func update(_ currentTime: TimeInterval)
}

public extension LayerProtocol {
    
    func wasAdded(to scene: SKScene) {}
    func update(_ currentTime: TimeInterval) {}
}
