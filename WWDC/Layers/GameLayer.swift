//
//  GameLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public enum ScreenSide: CGFloat {
    case right = 1.0
    case left = -1.0
    
    public static func side(xPosition x: CGFloat) -> ScreenSide {
        return x < 0 ? .left : .right
    }
}

public class GameLayer: SKNode, SKPhysicsContactDelegate, GameLayerProtocol {
    
    // MARK: - LayerProtocol properties
    
    public var layerNode: SKNode {
        zPosition = 10
        return self
    }
    
    // MARK: - Properties
    
    public var textLayer: TextLayerProtocol?
    public var controlLayer: LayerProtocol?
    
    private var ball: GRBall!
    private var phase = 1
    
    public var center: CGPoint {
        
        return CGPoint(
            x: frame.midX / 2,
            y: frame.midY
        )
    }
    
    override public var frame: CGRect {
        return UIScreen.main.bounds
    }
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        ball = GRBall(color: .red, placedAt: center)
        addChild(ball.node)
        createFloor()
        createObstacle()
        textLayer?.displayTexts(ofPhase: phase)
    }
    
    // MARK: - Control Delegate
    
    public func onLeftButtonPressed() {
        ball.roll(.left)
    }
    
    public func onLeftButtonUnpressed() {
        ball.stopRolling()
    }
    
    public func onRightButtonPressed() {
        ball.roll(.right)
    }
    
    public func onRightButtonUnpressed() {
        ball.stopRolling()
    }
    
    public func onJumpButtonPressed() {
        ball.jump()
    }
    
    // MARK: - LayerProtocol methods
    
    public func update(_ currentTime: TimeInterval) {
    }
    
    // MARK: - SKPhysicsContactDelegate methods
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let moduleBody = PhysicsCategory.module
        
        if moduleBody.collided(with: .floor, in: contact) {
            
            ball.fall()
            switch ball.screenSide {
            
            case .left: break
            case .right:
                print("chegou do lado direito")
                break
            }
        }
        
        else if moduleBody.collided(with: .obstacle, in: contact) {
            ball.fall()
        }
    }
    
    // MARK: - Creators
    
    private func createObstacle() {
        
        let obstacleSize = CGSize(
            width: 20.0,
            height: 110.0
        )
        
        let obstacle = SKShapeNode(
            rectOf: obstacleSize,
            cornerRadius: 5.0
        )
        
        obstacle.fillColor = .blue
        
        obstacle.position = CGPoint(
            x: frame.midX,
            y: 125.0
        )
        
        obstacle.physicsBody = SKPhysicsBody(
            rectangleOf: obstacleSize
        )
        
        obstacle.physicsBody?.allowsRotation = false
        obstacle.physicsBody?.affectedByGravity = false
        obstacle.physicsBody?.isDynamic = false
        obstacle.physicsBody?.categoryBitMask = PhysicsCategory.obstacle.bitMask
        obstacle.physicsBody?.collisionBitMask = PhysicsCategory.module.bitMask
        obstacle.physicsBody?.contactTestBitMask = PhysicsCategory.module.bitMask
        
        addChild(obstacle)
    }
    
    private func createFloor() {
        
        let floorSize = CGSize(
            width: frame.width,
            height: 80.0
        )
        
        let floor = SKShapeNode(
            rectOf: floorSize
        )
        
        floor.fillColor = .blue
        
        floor.position = CGPoint(
            x: frame.midX,
            y: 40.0
        )
        
        floor.physicsBody = SKPhysicsBody(
            rectangleOf: floorSize
        )
        
        floor.physicsBody?.allowsRotation = false
        floor.physicsBody?.affectedByGravity = false
        floor.physicsBody?.isDynamic = false
        floor.physicsBody?.categoryBitMask = PhysicsCategory.floor.bitMask
        floor.physicsBody?.collisionBitMask = PhysicsCategory.module.bitMask
        floor.physicsBody?.contactTestBitMask = PhysicsCategory.module.bitMask
        
        addChild(floor)
    }
}