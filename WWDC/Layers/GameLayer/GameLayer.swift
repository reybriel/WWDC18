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
}

public class GameLayer: ScreenSizeNode, SKPhysicsContactDelegate, ControlableLayer {
    
    // MARK: - LayerProtocol properties
    
    public var layerNode: SKNode {
        zPosition = 10
        return self
    }
    
    // MARK: - Properties
    
    public var listener: GameListener?
    
    private var ball: GRBall!
    private var floor: GRFloor!
    private var phase = 1
    
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
        
        floor = GRFloor(worldFrame: frame)
        
        floor.createObstacle(
            ofSize: CGSize(
                width: 20.0,
                height: 100.0
            ),
            atPosition: 0.0
        )
        
        ball = GRBall(
            color: .red,
            placedAt: CGPoint(
                x: frame.midX / 2,
                y: frame.midY
            )
        )
        
        addChild(floor.node)
        addChild(ball.node)
    }
    
    // MARK: - Methods
    
    private func triggerPhaseStart() {
        listener?.started(phase: phase)
    }
    
    private func triggerPhaseEnd() {
        listener?.finished(phase: phase)
        phase += phase <= 3 ? 1 : 0
    }
    
    // MARK: - "Lifecycle"
    
    public func wasAdded(to scene: SKScene) {
        triggerPhaseStart()
    }
    
    // MARK: - Controlable
    
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
    
    // MARK: - SKPhysicsContactDelegate methods
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let moduleBody = GRPhysicsCategory.module
        
        if moduleBody.collided(with: .floor, in: contact) {
            
            ball.fall()
            
            switch ball.screenSide(onFrame: frame) {
                
            case .left:
                
                break
                
            case .right:
                triggerPhaseEnd()
                break
            }
        }
            
        else if moduleBody.collided(with: .obstacle, in: contact) {
            ball.fall()
        }
    }
}
