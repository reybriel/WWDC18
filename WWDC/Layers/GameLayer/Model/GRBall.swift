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
    
    ///The state of the ball.
    private(set) var state: State = .stopped
    ///The node of the ball.
    public let node: SKShapeNode
    
    // MARK: - Initializers
    
    public init(color: UIColor, placedAt point: CGPoint) {
        
        node = GRBall.createNode(
            color: color,
            placeAt: point
        )
    }
    
    // MARK: - Methods
    
    ///This method makes the ball jump
    public func jump() {
        
        guard state != .jumping, state != .jumpingRolling, state != .stopping else { return }
        
        if state == .stopped {
            state = .jumping
        } else if state == .rolling {
            state = .jumpingRolling
        }
        
        node.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 60.0))
    }
    
    ///This methods makes the ball jump forever.
    public func jumpForever() {
        
        state = .jumpingForever
        jump()
    }
    
    ///This method makes the ball stop jumping.
    public func stopJumping() {
        state = .stopped
    }
    
    ///This method must be called when the ball hits the floor after jumping.
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
    
    /**
     This method makes the ball start rolling for a given screen side.
     
     - parameter direction: The screen side wich the ball must run to.
     */
    public func roll(_ direction: ScreenSide) {
        
        guard /* state != .jumping, */ state != .jumpingRolling, state != .stopping else { return }
        
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
    
    ///This method makes the ball stop rolling.
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
    
    /**
     This method tells wich side of the screen the ball is for a given frame.
     
     - parameter frame: The frame to be used as base for the test.
     */
    public func screenSide(onFrame frame: CGRect) -> ScreenSide {
        return node.position.x < frame.midX ? .left : .right
    }
    
    /**
     This method tells if the ball has passed a given x point.
     
     - parameter x: The point used in the test.
     */
    public func hasPassed(xPoint x: CGFloat) -> Bool {
        return node.position.x > x
    }
    
    /**
     This methods makes the ball node run a given action.
     
     - parameter action: the action to be runned.
     */
    public func run(_ action: SKAction) {
        node.run(action)
    }
    
    // MARK: - Static auxiliars
    
    /**
     This method creates the ball node of a given color in a given point.
     
     - parameter color: The color of the node.
     - parameter point: The point on wich the node will be created.
     */
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
        node.physicsBody?.categoryBitMask = GRPhysicsCategory.ball.bitMask
        node.physicsBody?.collisionBitMask = GRPhysicsCategory.floor.bitMask | GRPhysicsCategory.obstacle.bitMask
        node.physicsBody?.contactTestBitMask = GRPhysicsCategory.floor.bitMask | GRPhysicsCategory.obstacle.bitMask
        
        node.position = point
        
        return node
    }
    
    // MARK: - Enums
    
    ///Enum representing the states of the ball.
    public enum State {
        case stopped
        case stopping
        case rolling
        case jumping
        case jumpingRolling
        case jumpingForever
    }
}
