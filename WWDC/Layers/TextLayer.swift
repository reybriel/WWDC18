//
//  TextLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

class TextLayer: SKNode, TextLayerProtocol {
    
    // MARK: - LayerProtocol properties
    
    var layerNode: SKNode {
        zPosition = 15
        return self
    }
    
    // MARK: - Properties
    
    override var frame: CGRect {
        return UIScreen.main.bounds
    }
    
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
        
    }
    
    // MARK: - TextLayerProtocol methods
    
    public func displayTexts(ofPhase phase: Int) {
        
        switch phase {
            
        case 1:
            textPhase1()
            break
        default: break
        }
    }
    
    public func displayInstruction(ofPhase phase: Int) {
        
        switch phase {
            
        case 1: break
        default: break
        }
    }
    
    // MARK: - Text layer methods
    
    private func textPhase1() {
        
        let label = SKLabelNode(text: "Pass the ball to the other side")
        label.fontColor = .black
        label.position = CGPoint(x: frame.midX, y: frame.height + label.frame.height + 30.0)
        
        let action = SKAction.moveTo(y: frame.height - label.frame.height - 30.0, duration: 0.8)
        
        addChild(label)
        label.run(action)
    }
}
