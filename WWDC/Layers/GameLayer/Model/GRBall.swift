//
//  Module.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let ballSize: CGSize = .init(width: 50, height: 50)

public class GRBall {
    
    // MARK: - Properties
    
    private(set) var state: State = .stopped
    public let node: SKShapeNode
    
    // MARK: - Initializers
    
    public init(color: UIColor, placedAt point: CGPoint) {
        
        node = GRBall.createNode(
            color: color,
            placeAt: point
        )
    }
    
    // MARK: - Methods
    
    public func jump() {
        
        guard state != .jumping, state != .jumpingRolling, state != .stopping else { return }
        
        if state == .stopped {
            state = .jumping
        } else if state == .rolling {
            state = .jumpingRolling
        }
        
        node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 60.0))
    }
    
    public func jumpForever() {
        
        state = .jumpingForever
        jump()
    }
    
    public func stopJumping() {
        state = .stopped
    }
    
    public func fall() {
        
        switch state {
            
        case .stopped: break
        case .rolling: break
            
        case .stopping:
            state = .stopped
            stopRolling()
            break
            
        case .jumping:
            state = .stopped
            break
            
        case .jumpingRolling:
            state = .rolling
            break
            
        case .jumpingForever:
            jump()
            break
        }
    }
    
    public func roll(_ direction: ScreenSide) {
        
        guard state != .jumping, state != .jumpingRolling, state != .stopping else { return }
        
        let velocity = node.physicsBody!.velocity.dx
        
        if velocity.absolute < 250 {
            
            let dx = direction.rawValue * 250.0
            
            node.physicsBody?.applyForce(
                CGVector(
                    dx: dx,
                    dy: 0.0
                )
            )
        }
        
        state = .rolling
    }
    
    public func stopRolling() {
        
        guard state != .jumpingRolling, state != .jumping, state != .stopping else {
            state = .stopping
            return
        }
        
        Timer.scheduledTimer(
            withTimeInterval: 0.1,
            repeats: false) { _ in self.node.physicsBody?.velocity = .zero }
        
        state = .stopped
    }
    
    public func screenSide(onFrame frame: CGRect) -> ScreenSide {
        return node.position.x < frame.midX ? .left : .right
    }
    
    // MARK: - Static auxiliars
    
    private static func createNode(color: UIColor, placeAt point: CGPoint) -> SKShapeNode {
        
        let node = SKShapeNode(
            ellipseOf: ballSize
        )
        
        node.fillColor = color
        node.strokeColor = .black
        
        node.physicsBody = SKPhysicsBody(
            circleOfRadius: ballSize.width/2
        )
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.categoryBitMask = GRPhysicsCategory.module.bitMask
        node.physicsBody?.collisionBitMask = GRPhysicsCategory.floor.bitMask | GRPhysicsCategory.obstacle.bitMask
        node.physicsBody?.contactTestBitMask = GRPhysicsCategory.floor.bitMask | GRPhysicsCategory.obstacle.bitMask
        
        node.position = point
        
        return node
    }
    
    // MARK: - Enums
    
    public enum State {
        case stopped
        case stopping
        case rolling
        case jumping
        case jumpingRolling
        case jumpingForever
    }
}
