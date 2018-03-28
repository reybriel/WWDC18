//
//  InstructionLabel.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let kInstructionOffset: CGFloat = 30.0

public class GRInstructionLabel: SKLabelNode {
    
    private lazy var showing: SKAction = SKAction.moveBy(
        x: 0.0,
        y: -(frame.height + kInstructionOffset),
        duration: 0.8
    )
    
    private lazy var hiding: SKAction = SKAction.moveBy(
        x: 0.0,
        y: frame.height + kInstructionOffset,
        duration: 0.2
    )
    
    public override init() {
        super.init()
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        fontColor = .black
    }
    
    public func show() {
        run(showing)
    }
    
    public func hide() {
        run(hiding)
    }
}
