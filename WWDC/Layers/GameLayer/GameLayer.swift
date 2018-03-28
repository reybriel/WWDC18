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
    private(set) var phase = 1
    
    private var triggerFlag = true
    
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
    
    public func startPhase() {
        triggerFlag = true
        
        if phase != 3 {
            floor.createObstacle(atPoint: 0.48)
        } else {
            floor.removeObstacles()
        }
    }
    
    private func triggerPhaseEnd() {
        
        if triggerFlag {
            listener?.finished(phase)
            changeScenario(phase: phase)
            phase += phase < 3 ? 1 : 0
            triggerFlag = false
        }
    }
    
    private func changeScenario(phase: Int) {
        
        let offset: CGFloat = -(ball.node.position.x - frame.width * 0.1)
        
        let action = SKAction.moveBy(
            x: offset,
            y: 0.0,
            duration: 1.2
        )
        
        action.timingMode = .easeInEaseOut
        
        switch phase {
            
        case 1:
            ball.run(action)
            floor.runOnObstacles(action) {
                self.floor.removeObstacles()
            }
            break
        case 2:
            ball.run(action)
            break
        case 3:
            break
        default:
            break
        }
    }
    
    public func wasAdded(to scene: SKScene) {
        startPhase()
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
    
    public func onHelpButtonPressed() {
        triggerPhaseEnd()
    }
    
    // MARK: - Layer protocol
    
    public func update(_ currentTime: TimeInterval) {
        
        if ball.hasPassed(xPoint: frame.width * 0.65) {
            triggerPhaseEnd()
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
