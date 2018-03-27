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
    private var obstacles: [SKShapeNode] = []
    
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
        
        obstacle.physicsBody?.categoryBitMask = GRPhysicsCategory.obstacle.bitMask
        obstacle.physicsBody?.collisionBitMask = GRPhysicsCategory.module.bitMask
        obstacle.physicsBody?.contactTestBitMask = GRPhysicsCategory.module.bitMask
        
        obstacles.append(obstacle)
        node.addChild(obstacle)
    }
    
    public func removeObstacles() {
        
        obstacles.forEach { obstacle in
            
            obstacle.run(
                SKAction.sequence(
                    [
                        SKAction.moveBy(
                            x: 0.0,
                            y: -obstacle.frame.height,
                            duration: 0.5
                        ),
                        SKAction.removeFromParent()
                    ]
                )
            )
        }
        
        obstacles.removeAll()
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
        floor.strokeColor = .blue
        
        floor.position = CGPoint(
            x: space.midX,
            y: 40.0
        )
        
        floor.physicsBody = GRFloor.commonPhysicsBody(ofSize: floorSize)
        
        floor.physicsBody?.categoryBitMask = GRPhysicsCategory.floor.bitMask
        floor.physicsBody?.collisionBitMask = GRPhysicsCategory.module.bitMask
        floor.physicsBody?.contactTestBitMask = GRPhysicsCategory.module.bitMask
        
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
