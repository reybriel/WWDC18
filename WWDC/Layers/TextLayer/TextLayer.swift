//
//  TextLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let instructions = [
    "Pass the ball to the other side",
    "What if you couldn't jump anymore?",
    "Try now!"
]

private let messages = [
    ["Pretty easy, isn`t it?", "But..."],
    ["It gets hard, doesn't it?", "Let me help you!"],
    ["This teaches us an important lesson...", "Addapting for the ones who need is not a fad,\nis a necessity!", "Be inclusive"]
]

class TextLayer: ScreenSizeNode, LayerProtocol {
    
    // MARK: - LayerProtocol properties
    
    var layerNode: SKNode {
        zPosition = 15
        return self
    }
    
    // MARK: - Properties
    
    ///The label that appears when the phase is being played.
    private let instructionLabel = GRInstructionLabel()
    ///The label that shows the message when a phase is ended.
    private lazy var messageLabel = GRMessageLabel(worldFrame: frame)
    
    ///The listener of the game.
    public var listener: GameListener?
    
    // MARK: - Initializers
    
    override init() {
        super.init()
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    /// A common initializer for the layer.
    private func commonInit() {
        instructionLabel.fontColor = .black
        instructionLabel.position = CGPoint(
                x: frame.midX,
                y: frame.height + instructionLabel.frame.height + 10.0
        )
        addChild(instructionLabel)
        addChild(messageLabel)
    }
    
    // MARK: - Methods
    
    /**
     Show the instruction for a given phase.
     
     - parameter phase: The phase that requires the instruction.
     */
    public func showInstruction(for phase: Int) {
        
        instructionLabel.text = instructions[phase - 1]
        instructionLabel.show()
    }
    
    ///Hides the instruction.
    private func hideInstruction() {
        instructionLabel.hide()
    }
    
    /**
     Shows the message of the ending phase.
     
     - parameter phase: The phase that is ending.
     */
    public func showMessage(for phase: Int) {
        hideInstruction()
        
        messageLabel.displays(messages: messages[phase - 1]) {
            
            self.listener?.finishedDisplayingMessage(phase)
        }
    }
}
