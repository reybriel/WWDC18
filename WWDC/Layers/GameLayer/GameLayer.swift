//
//  GameLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let kFloorY: CGFloat = 75.0

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
    
    private var triggerFlag = false
    
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
        
        floor = GRFloor(
            frame: CGRect(
                x: 0.0,
                y: kFloorY,
                width: frame.width,
                height: 5.0
            )
        )
        
        floor.createObstacle(atPoint: 0.5)
        
        ball = GRBall(
            color: .red,
            placedAt: CGPoint(
                x: frame.midX / 2,
                y: frame.midY
            )
        )
        
        addChild(floor.node)
        addChild(ball.node)
        magicBox()
    }
    
    // MARK: - Tricks
    
    private func magicBox() {
        
        let magicNode = SKShapeNode(
            rect: CGRect(
                x: 0.0,
                y: 0.0,
                width: frame.width,
                height: kFloorY
            )
        )
        
        magicNode.fillColor = .white
        magicNode.strokeColor = .white
        
        addChild(magicNode)
    }
    
    // MARK: - Methods
    
    private func triggerPhaseStart() {
        
        if !triggerFlag {
            listener?.started(phase: phase)
            triggerFlag = true
        }
    }
    
    private func triggerPhaseEnd() {
        
        if triggerFlag {
            listener?.finished(phase: phase)
            phase += phase < 3 ? 1 : 0
            triggerFlag = false
        }
    }
    
    // MARK: - "Layer Lifecycle"
    
    public func wasAdded(to scene: SKScene) {
        listener?.started(phase: phase)
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
    
    // MARK: - Layer protocol
    
    public func update(_ currentTime: TimeInterval) {
        
        switch ball.screenSide(onFrame: frame) {
            
        case .left:
            triggerPhaseStart()
            break
            
        case .right:
            triggerPhaseEnd()
            break
        }
    }
    
    // MARK: - SKPhysicsContactDelegate methods
    
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let moduleBody = GRPhysicsCategory.module
        
        if moduleBody.collided(with: .floor, in: contact) || moduleBody.collided(with: .obstacle, in: contact) {
            ball.fall()
        }
    }
}
