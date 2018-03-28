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
    
    private let instructionLabel = InstructionLabel()
    
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
    
    public var listener: MessageListener?
    
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
    }
    
    func wasAdded(to scene: SKScene) {
        showInstruction(for: 1)
    }
    
    // MARK: - Methods
    
    private func showInstruction(for phase: Int) {
        
        instructionLabel.text = instructions[phase - 1]
        instructionLabel.show()
    }
    
    private func hideInstruction() {
        instructionLabel.hide()
    }
    
    public func showMessage(for phase: Int) {
        hideInstruction()
        
        let label = SKLabelNode(text: messages[phase - 1][0])
        
        label.fontColor = .black
        label.position = CGPoint(
            x: frame.maxX + label.frame.width/2,
            y: frame.midY
        )
        
        let action = SKAction.sequence(
            [
                SKAction.moveTo(
                    x: frame.midX,
                    duration: 1.2
                ),
                SKAction.wait(forDuration: 2.0)
            ]
        )
        
        action.timingMode = .easeOut
        
        addChild(label)
        
        label.run(action) {
            self.listener?.finishedDisplayingMessage(phase)
        }
    }
}
