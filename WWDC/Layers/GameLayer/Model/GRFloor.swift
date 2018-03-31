//
//  GRFloor.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class GRFloor {
    
    // MARK: - Properties
    
    ///The floor node.
    public let node: SKShapeNode
    ///The obstacles of the floor.
    private var obstacles: [GRObstacle] = []
    
    // MARK: - Initializers
    
    public init(frame: CGRect) {
        node = GRFloor.createFloorNode(frame: frame)
    }
    
    // MARK: - Methods
    
    /**
     Creates anobstacle in a given point of the floor.
     
     - parameter point: The on wich the obstacle will be created,
     this value must be between 0.0 and 1.0.
     */
    public func createObstacle(atPoint point: CGFloat) {
        
        let obstacle = GRObstacle()
        
        let mult = point - 0.5
        
        obstacle.position = CGPoint(
            x: node.frame.maxX * mult,
            y: -(obstacle.frame.height/2)
        )
        
        obstacles.append(obstacle)
        node.addChild(obstacle.node)
        obstacle.show()
    }
    
    ///Remove all the obstacles of the floor.
    public func removeObstacles() {
        
        obstacles.forEach { $0.hide() }
        obstacles.removeAll()
    }
    
    /**
     Runs an actions for each obstacle in the floor.
     
     - parameter action: The action the be runnned.
     - parameter completion: A block of code to be executed once the actions
     where delivered to be runned.
     */
    public func runOnObstacles(_ action: SKAction, completion: (() -> Void)? = nil) {
        
        obstacles.forEach { obstacle in
            obstacle.node.run(action)
        }
        
        completion?()
    }
    
    /**
     Creates the floor node with a given frame.
     
     - parameter frame: The frame of the floor.
     */
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
        floor.physicsBody?.collisionBitMask = GRPhysicsCategory.ball.bitMask
        floor.physicsBody?.contactTestBitMask = GRPhysicsCategory.ball.bitMask
        
        return floor
    }
}
