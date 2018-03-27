//
//  TextLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

class TextLayer: ScreenSizeNode, GameListenerLayer {
    
    // MARK: - LayerProtocol properties
    
    var layerNode: SKNode {
        zPosition = 15
        return self
    }
    
    // MARK: - Properties
    
    private let instructionLabel = SKLabelNode()
    
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
    
    // MARK: - Game listener methods
    
    func started(phase: Int) {
        
        instructionLabel.text = instructions[phase - 1]
        
        instructionLabel.run(
            SKAction.moveBy(
                x: 0.0,
                y: -50.0,
                duration: 0.8
            )
        )
    }
    
    func finished(phase: Int) {
        hideInstruction()
    }
    
    // MARK: - Methods
    
    private func hideInstruction() {
        
        let hide = SKAction.moveBy(
            x: 0.0,
            y: 50.0,
            duration: 0.2
        )
        instructionLabel.run(hide)
    }
}
