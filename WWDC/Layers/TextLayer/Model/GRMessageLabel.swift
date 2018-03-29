//
//  GRMessageLabel.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 28/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let kMessageLabelHidingOffset: CGFloat = 150.0

public typealias Block = () -> Void

public class GRMessageLabel: SKLabelNode {
    
    private var worldFrame: CGRect
    private var currentMessage = 1
    private var messages: [String]!
    private var finishedMessaging = false
    
    private lazy var initialPosition = CGPoint(
        x: worldFrame.maxX + kMessageLabelHidingOffset,
        y: worldFrame.midY + 60.0
    )
    
    private lazy var moveIn  = SKAction.moveTo(
        x: worldFrame.midX,
        duration: 1.2
    )
    
    private var moveOut = SKAction.moveTo(
        x: -kMessageLabelHidingOffset,
        duration: 1.2
    )
    
    private var appear   = SKAction.fadeIn (withDuration: 0.5)
    private var disapear = SKAction.fadeOut(withDuration: 0.5)
    
    private var wait     = SKAction.wait   ( forDuration: 2.5)
    
    private var messageSequence: SKAction {
        
        if atFirstMessage {
            
            return SKAction.sequence(
                [moveIn, wait, disapear]
            )
        }
            
        else {
            
            return SKAction.sequence(
                [appear, wait, disapear]
            )
        }
    }
    
    private lazy var forEachMessage = {
        
        self.nextMessage()
        
        if self.finishedMessaging {
            self.onLastMessageConclusion()
            self.restore()
        }
        
        else {
            self.display(message: self.messages[self.currentIndex])
        }
    }
    
    private var onLastMessageConclusion: Block!
    
    private var currentIndex: Int {
        return currentMessage - 1
    }
    
    public var atFirstMessage: Bool {
        return currentMessage == 1
    }
    
    public var atLastMessage: Bool {
        return currentMessage == messages.count
    }
    
    public init(worldFrame: CGRect) {
        
        self.worldFrame = worldFrame
        
        super.init()
        
        fontColor = .black
        position = initialPosition
        
        if #available(iOS 11, *) {
            numberOfLines = 0
        }
        
        moveIn.timingMode = .easeInEaseOut
        moveOut.timingMode = .easeInEaseOut
    }
    
    required public init?(coder aDecoder: NSCoder) {
        
        self.worldFrame = aDecoder.decodeCGRect(forKey: "frame")
        
        super.init(coder: aDecoder)
    }
    
    private func startCounting() {
        currentMessage = 1
        finishedMessaging = false
    }
    
    private func nextMessage() {
        currentMessage += 1
        finishedMessaging = currentMessage > messages.count
    }
    
    private func restore() {
        position = initialPosition
        alpha = 1.0
    }
    
    private func display(message: String) {
        
        text = message
        
        print(message)
        run(messageSequence) {
            self.forEachMessage()
        }
    }
    
    public func deliver(messages: [String], completion: @escaping Block) {
        self.messages = messages
        startCounting()
        onLastMessageConclusion = completion
        
        display(message: messages[currentIndex])
    }
    
    deinit {
        removeFromParent()
    }
}
