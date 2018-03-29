//
//  TextLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

class TextLayer: ScreenSizeNode, LayerProtocol {
    
    // MARK: - LayerProtocol properties
    
    var layerNode: SKNode {
        zPosition = 15
        return self
    }
    
    // MARK: - Properties
    
    private let instructionLabel = GRInstructionLabel()
    private lazy var messageLabel = GRMessageLabel(worldFrame: frame)
    
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

    private func commonInit() {
        instructionLabel.fontColor = .black
        instructionLabel.position = CGPoint(
                x: frame.midX,
                y: frame.height + instructionLabel.frame.height + 10.0
        )
        addChild(instructionLabel)
        addChild(messageLabel)
    }
    
    func wasAdded(to scene: SKScene) {
        
    }
    
    // MARK: - Methods
    
    public func showInstruction(for phase: Int) {
        
        instructionLabel.text = instructions[phase - 1]
        instructionLabel.show()
    }
    
    private func hideInstruction() {
        instructionLabel.hide()
    }
    
    public func showMessage(for phase: Int) {
        hideInstruction()
        
        messageLabel.deliver(messages: messages[phase - 1]) {
            
            self.listener?.finishedDisplayingMessage(phase)
        }
    }
}
