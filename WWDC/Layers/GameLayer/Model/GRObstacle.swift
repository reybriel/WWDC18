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

private let showing = SKAction.moveBy(x: 0.0, y: kObstacleHeight, duration: 0.8)
private let hiding  = SKAction.sequence([SKAction.moveBy(x: 0.0, y: -kObstacleHeight, duration: 0.5), SKAction.removeFromParent()])

public class GRObstacle {
    
    // MARK: - Porperties
    
    ///The node of the obstacle.
    public let node: SKShapeNode
    
    ///The position of the obstacle.
    public var position: CGPoint {
        
        get {
            return node.position
        }
        
        set {
            node.position = newValue
        }
    }
    
    ///The frame of the obstacle.
    public var frame: CGRect {
        
        return node.frame
    }
    
    // MARK: - Initializers
    
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
    
    // MARK: - Methods
    
    ///Shows the obstacle by making it comes up from bellow the floor.
    public func show() {
        node.run(showing)
    }
    
    ///Hides the obstacle by miking it comes down to bellow the floor.
    public func hide() {
        node.run(hiding)
    }
    
    ///Setups the obstacle physics body.
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
        node.physicsBody?.collisionBitMask = GRPhysicsCategory.ball.bitMask
        node.physicsBody?.contactTestBitMask = GRPhysicsCategory.ball.bitMask
    }
}
