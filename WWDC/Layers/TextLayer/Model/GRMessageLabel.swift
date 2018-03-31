//
//  GRMessageLabel.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 28/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let disapear = SKAction.fadeOut(withDuration: 0.5)
private let appear   = SKAction.fadeIn (withDuration: 0.5)
private var wait     = SKAction.wait   ( forDuration: 2.5)

private let kMessageLabelHidingOffset: CGFloat = 250.0

public typealias Block = () -> Void

public class GRMessageLabel: SKLabelNode {
    
    // MARK: - Properties
    
    ///The frame of the node wich the label is in.
    private var worldFrame: CGRect
    ///The current message that is being displayed.
    private var currentMessage = 1
    ///The messages to be displayed.
    private var messages: [String]!
    ///The label has finished diplaying the messages.
    private var finishedMessaging = false
    
    ///The initial position of the label.
    private lazy var initialPosition = CGPoint(
        x: worldFrame.maxX + kMessageLabelHidingOffset,
        y: worldFrame.midY + 60.0
    )
    
    ///The move in animation.
    private lazy var moveIn  = SKAction.moveTo(
        x: worldFrame.midX,
        duration: 1.2
    )
    
    ///The move out animation.
    private var moveOut = SKAction.moveTo(
        x: -kMessageLabelHidingOffset,
        duration: 1.2
    )
    
    ///The animation sequence of the label.
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
    
    ///A block of code to be executed after each message is displayed.
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
    
    ///A block of code to be executed once the label finishes displaying all of the messages.
    private var onLastMessageConclusion: Block!
    
    ///The index of the current message in the messages array.
    private var currentIndex: Int {
        return currentMessage - 1
    }
    
    ///The label is displaying the first message.
    public var atFirstMessage: Bool {
        return currentMessage == 1
    }
    
    ///The label is displaying the last message.
    public var atLastMessage: Bool {
        return currentMessage == messages.count
    }
    
    // MARK: - Initializers
    
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
    
    // MARK: - Methods
    
    ///Begins to display the messages.
    private func startDisplayingMessages() {
        currentMessage = 1
        finishedMessaging = false
    }
    
    ///Moves to the next message to be displayed.
    private func nextMessage() {
        currentMessage += 1
        finishedMessaging = currentMessage > messages.count
    }
    
    ///Restores the label to it's initial values.
    private func restore() {
        position = initialPosition
        alpha = 1.0
    }
    
    /**
     Displays a message.
     
     - parameter: message: The message to be displayed.
     */
    private func display(message: String) {
        
        text = message
        
        run(messageSequence) {
            self.forEachMessage()
        }
    }
    
    /**
     Displays an array of messages.
     
     - parameter messages: The messages to be displayed.
     - parameter completion: A block of code to be executed once the messages have been displayed.
     */
    public func displays(messages: [String], completion: @escaping Block) {
        self.messages = messages
        startDisplayingMessages()
        onLastMessageConclusion = completion
        
        display(message: messages[currentIndex])
    }
    
    deinit {
        removeFromParent()
    }
}
