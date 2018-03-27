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
                y: frame.height + instructionLabel.frame.height
        )
        addChild(instructionLabel)
    }
    
    // MARK: - Methods
    
    public func showInstruction(for phase: Int) {
        
        instructionLabel.text = instructions[phase - 1]
        instructionLabel.show()
    }
    
    public func hideInstruction() {
        instructionLabel.hide()
    }
    
    public func showMessage(for phase: Int) {
        hideInstruction()
    }
    
}
