//
//  GRFloor.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class GRFloor {
    
    public let node: SKShapeNode
    private var obstacles: [GRObstacle] = []
    
    public init(frame: CGRect) {
        node = GRFloor.createFloorNode(frame: frame)
    }
    
    public func createObstacle(atPoint percent: CGFloat) {
        
        let obstacle = GRObstacle()
        
        let mult = percent - 0.5
        
        obstacle.position = CGPoint(
            x: node.frame.maxX * mult,
            y: -(obstacle.frame.height/2)
        )
        
        obstacles.append(obstacle)
        node.addChild(obstacle.node)
        obstacle.show()
    }
    
    public func removeObstacles() {
        
        obstacles.forEach { $0.hide() }
        obstacles.removeAll()
    }
    
    public func runOnObstacles(_ action: SKAction, completion: (() -> Void)? = nil) {
        
        obstacles.forEach { obstacle in
            obstacle.node.run(action)
        }
        
        completion?()
    }
    
    private static func createFloorNode(frame: CGRect) -> SKShapeNode {
        
        let floor = SKShapeNode(rectOf: frame.size)
        
        floor.position = CGPoint(
            x: frame.midX,
            y: frame.midY
        )
        
        floor.fillColor = .blue
        floor.strokeColor = .blue
        
        floor.physicsBody = SKPhysicsBody(rectangleOf: frame.size)
            
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.allowsRotation = false
        floor.physicsBody?.isDynamic = false
        
        floor.physicsBody?.categoryBitMask = GRPhysicsCategory.floor.bitMask
        floor.physicsBody?.collisionBitMask = GRPhysicsCategory.module.bitMask
        floor.physicsBody?.contactTestBitMask = GRPhysicsCategory.module.bitMask
        
        return floor
    }
}
