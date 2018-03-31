//
//  InstructionLabel.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

private let showing = SKAction.moveBy(x: 0.0, y: -kInstructionAnimationOffset, duration: 0.8)
private let hiding  = SKAction.moveBy(x: 0.0, y:  kInstructionAnimationOffset, duration: 0.2)

private let kInstructionAnimationOffset: CGFloat = 60.0

public class GRInstructionLabel: SKLabelNode {
    
    // MARK: - Initializers
    
    public override init() {
        super.init()
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    ///A common init to the label.
    private func commonInit() {
        fontColor = .black
    }
    
    ///Shows the label.
    public func show() {
        run(showing)
    }
    
    ///Hides the label.
    public func hide() {
        run(hiding)
    }
    
    deinit {
        removeFromParent()
    }
}
