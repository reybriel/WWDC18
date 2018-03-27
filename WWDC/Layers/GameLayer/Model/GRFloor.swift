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
    
    public init(worldFrame: CGRect) {
        node = GRFloor.createFloorNode(inSpace: worldFrame)
    }
    
    public func createObstacle(ofSize size: CGSize, atPosition x: CGFloat) {
        
        let obstacle = SKShapeNode(
            rectOf: size,
            cornerRadius: 5.0
        )
        
        obstacle.fillColor = .blue
        obstacle.strokeColor = .blue
        
        obstacle.position = CGPoint(
            x: x,
            y: node.frame.maxY + obstacle.frame.midY
        )
        
        obstacle.physicsBody = GRFloor.commonPhysicsBody(ofSize: size)
        
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle.bitMask
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.module.bitMask
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.module.bitMask
        
        node.addChild(obstacle)
    }
    
    private static func createFloorNode(inSpace space: CGRect) -> SKShapeNode {
        
        let floorSize = CGSize(
            width: space.width,
            height: 80.0
        )
        
        let floor = SKShapeNode(
            rectOf: floorSize
        )
        
        floor.fillColor = .blue
        
        floor.position = CGPoint(
            x: space.midX,
            y: 40.0
        )
        
        floor.physicsBody = GRFloor.commonPhysicsBody(ofSize: floorSize)
        
        floor.physicsBody?.categoryBitMask = PhysicsCategory.floor.bitMask
        floor.physicsBody?.collisionBitMask = PhysicsCategory.module.bitMask
        floor.physicsBody?.contactTestBitMask = PhysicsCategory.module.bitMask
        
        return floor
    }
    
    private static func commonPhysicsBody(ofSize size: CGSize) -> SKPhysicsBody {
        
        let physicsBody = SKPhysicsBody(rectangleOf: size)
        
        physicsBody.affectedByGravity = false
        physicsBody.allowsRotation = false
        physicsBody.isDynamic = false
        
        return physicsBody
    }
}
