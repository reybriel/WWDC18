//
//  GRObstacle.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let kObstacleHeight: CGFloat = 100.0
private let kObstacleWidth : CGFloat =  15.0

public class GRObstacle {
    
    public let node: SKShapeNode
    
    public var position: CGPoint {
        
        get {
            return node.position
        }
        
        set {
            node.position = newValue
        }
    }
    
    public var frame: CGRect {
        
        return node.frame
    }
    
    private lazy var showing: SKAction = SKAction.moveBy(
        x: 0.0,
        y: kObstacleHeight,
        duration: 0.5
    )
    
    private lazy var hiding: SKAction = SKAction.sequence(
        [
            SKAction.resize(
                toHeight: 0.0,
                duration: 0.3
            ),
            SKAction.removeFromParent()
        ]
    )
    
    init(forShowing: Bool = true) {
        
        node = SKShapeNode(
            rectOf: CGSize(
                width: kObstacleWidth,
                height: kObstacleHeight
            ),
            cornerRadius: 5.0
        )
        
        node.fillColor = .blue
        node.strokeColor = .blue
        
        setupPhysicsBody()
    }
    
    public func show() {
        node.run(showing)
    }
    
    public func hide() {
        node.run(hiding)
    }
    
    private func setupPhysicsBody() {
        
        node.physicsBody = SKPhysicsBody(
            rectangleOf: CGSize(
                width: kObstacleWidth,
                height: kObstacleHeight
            )
        )
        
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.isDynamic = false
        
        node.physicsBody?.categoryBitMask = GRPhysicsCategory.obstacle.bitMask
        node.physicsBody?.collisionBitMask = GRPhysicsCategory.module.bitMask
        node.physicsBody?.contactTestBitMask = GRPhysicsCategory.module.bitMask
    }
}
