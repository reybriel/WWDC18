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
    
    // MARK: - Layer protocol properties
    
    public var layerNode: SKNode {
        zPosition = 10
        return self
    }
    
    // MARK: - Properties
    
    ///The listener of the game.
    public var listener: GameListener?
    
    ///The ball.
    private var ball: GRBall!
    ///The floor.
    private var floor: GRFloor!
    ///The current phase.
    private(set) var phase = 1
    
    ///A flag tha indicates if the end of phase can be triggered.
    private var canTriggerPhaseEnd = true
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    ///A common initialization for the layer.
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
        
        addChild(ball.node)
        addChild(floor.node)
        magicBox()
    }
    
    // MARK: - Tricks
    
    /**
     This "magic box" is a whtie node that is placed under the floor.
     The goal of this node is to create the impression that the
     obstacles are rising from the floor.
     */
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
    
    ///Starts a new phase.
    public func startPhase() {
        canTriggerPhaseEnd = true
        
        listener?.willStart(phase)
        
        if phase != 3 {
            floor.createObstacle(atPoint: 0.49)
        } else {
            floor.removeObstacles()
        }
    }
    
    ///Starts the game from phase one.
    private func startGame() {
        
        phase = 1
        startPhase()
    }
    
    ///Triggers the end of a phase.
    private func triggerPhaseEnd() {
        
        if canTriggerPhaseEnd {
            listener?.finished(phase)
            changeScenario(phase: phase)
            phase += phase < 3 ? 1 : 0
            canTriggerPhaseEnd = false
        }
    }
    
    /**
     Positions the nodes of the game for the start of a new phase.
     
     - parameter phase: The phase that is ending.
     */
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
            ball.run(action)
            break
        default:
            break
        }
    }
    
    // MARK: - Layer protocol methods
    
    public func wasAdded(to scene: SKScene) {
        startGame()
    }
    
    // MARK: - Controlable layer methods
    
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
    
    public func onReplayButtonPressed() {
        startGame()
    }
    
    // MARK: - Layer protocol
    
    public func update(_ currentTime: TimeInterval) {
        
        if ball.hasPassed(xPoint: frame.width * 0.65) {
            triggerPhaseEnd()
        }
    }
    
    // MARK: - SKPhysicsContactDelegate methods
    
    ///:nodoc:
    public func didBegin(_ contact: SKPhysicsContact) {
        
        let moduleBody = GRPhysicsCategory.ball
        
        if moduleBody.collided(with: .floor, in: contact) || moduleBody.collided(with: .obstacle, in: contact) {
            ball.fall()
        }
    }
}
