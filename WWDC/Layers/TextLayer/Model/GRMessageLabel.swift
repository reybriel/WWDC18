//
//  GRMessageLabel.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 28/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let kMessageLabelHidingOffset: CGFloat = 100.0

public class GRMessageLabel: SKLabelNode {
    
    private var worldFrame = CGRect()
    private var messageCount = 0
    private var messages: [String]!
    
    private var countMax: Int {
        return messages.count - 1
    }
    
    private lazy var moveIn = SKAction.moveTo(
        x: worldFrame.midX,
        duration: 1.2
    )
    
    private lazy var moveOut = SKAction.moveTo(
        x: -kMessageLabelHidingOffset,
        duration: 1.2
    )
    
    private lazy var appear = SKAction.fadeIn(withDuration: 0.5)
    private lazy var disapear = SKAction.fadeOut(withDuration: 0.5)
    private lazy var wait = SKAction.wait(forDuration: 2.0)
    
    private lazy var iteration = {
        
        self.display(message: self.messages[self.messageCount], lastOne: self.messageCount == self.countMax)
    }
    
    private var conclusion: (() -> Void)!
    
    init(worldFrame: CGRect) {
        super.init()
        
        self.worldFrame = worldFrame
        
        fontColor = .black
        position = CGPoint(
            x: worldFrame.maxX + kMessageLabelHidingOffset,
            y: worldFrame.midY
        )
        
        moveIn.timingMode = .easeInEaseOut
        moveOut.timingMode = .easeInEaseOut
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func deliver(messages: [String], completion: @escaping () -> Void) {
        self.messages = messages
        self.messageCount = 0
        self.conclusion = completion
        
        display(message: messages[messageCount], lastOne: messageCount == countMax)
    }
    
    private func display(message: String, lastOne: Bool) {
        
        var sequence: SKAction = SKAction()
        
        if messageCount == 0 {
            
            if lastOne {
                
                sequence = SKAction.sequence(
                    [moveIn, wait, moveOut]
                )
            } else {
                
                sequence = SKAction.sequence(
                    [moveIn, wait, disapear]
                )
            }
            
        } else if lastOne {
            
            sequence = SKAction.sequence(
                [appear, wait, moveOut]
            )
            
        } else {
            
            sequence = SKAction.sequence(
                [appear, wait, disapear]
            )
        }
        
        text = message
        run(sequence) {
            self.messageCount += 1
            
            if lastOne {
                self.conclusion()
            } else {
                self.iteration()
            }
        }
    }
    
    deinit {
        removeFromParent()
    }
}
