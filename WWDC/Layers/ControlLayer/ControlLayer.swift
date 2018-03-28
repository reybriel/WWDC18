//
//  ControlLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class ControlLayer: ScreenSizeNode, LayerProtocol {
    
    // MARK: - LayerProtocol attributes
    
    public var layerNode: SKNode {
        zPosition = 20
        return self
    }
    
    // MARK: - Properties
    
    public var controlable: ControlableLayer?
    
    private var leftButton: GRButton!
    private var frontButton: GRButton!
    private var upButton: GRButton!
    
    private var buttons: [GRButton] {
        return [leftButton, frontButton, upButton]
    }
    
    private var pressedButton: GRButton? {
        
        return buttons.first(
            where: { $0.isPressed }
        )
    }
    
    // MARK: - Initializers
    
    override public init() {
        super.init()
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        leftButton = GRButton(
            imageNamed: "left",
            focusedImageNamed: "left focus"
        )
        
        leftButton.onButtonPressed = {
            _ in
            self.controlable?.onLeftButtonPressed()
        }
        
        leftButton.onButtonReleased = {
            _ in
            self.controlable?.onLeftButtonUnpressed()
        }
        
        frontButton = GRButton(
            imageNamed: "right",
            focusedImageNamed: "right focus"
        )
        
        frontButton.onButtonPressed = {
            _ in
            self.controlable?.onRightButtonPressed()
        }
        
        frontButton.onButtonReleased = {
            _ in
            self.controlable?.onRightButtonUnpressed()
        }
        
        upButton = GRButton(
            imageNamed: "up",
            focusedImageNamed: "up focus"
        )
        
        upButton.holdingEnabled = false
        
        upButton.onButtonPressed = {
            _ in
            self.controlable?.onJumpButtonPressed()
        }
        
        upButton.onButtonReleased = {
            _ in
            self.controlable?.onJumpButtonUnpressed()
        }
        
        layoutButtons()
    }
    
    private func layoutButtons() {
        
        leftButton.position = CGPoint(
            x: leftButton.frame.width/2 + 10.0,
            y: leftButton.frame.height/2 + 10.0
        )
        
        addChild(leftButton)
        
        frontButton.position = CGPoint(
            x: leftButton.frame.maxX + frontButton.frame.width/2 + 10.0,
            y: frontButton.frame.height/2 + 10.0
        )
        
        addChild(frontButton)
        
        upButton.position = CGPoint(
            x: frame.width - (upButton.frame.width/2 + 10.0),
            y: upButton.frame.height/2 + 10.0
        )
        
        addChild(upButton)
    }
}

public extension ControlLayer {
    
    // MARK: - Touches
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.press() },
            onButtonMiss: nil
        )
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.press() },
            onButtonMiss: { self.pressedButton?.unpress() }
        )
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.unpress() },
            onButtonMiss: nil
        )
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.unpress() },
            onButtonMiss: nil
        )
    }
    
    // MARK: - Control layer methods
    
    public func hideButtons() {
        
        let hiding = SKAction.moveBy(
            x: 0.0,
            y: -80.0,
            duration: 0.8
        )
        
        buttons.forEach { (button) in
            button.unpress()
            button.enabled = false
            button.run(hiding)
        }
    }
    
    private func trackButton(by touch: UITouch, onButtonFound: GRButtonAction, onButtonMiss: (() -> Void)?) {
        
        let location = touch.location(in: self)
        
        if let button = nodes(at: location).first as? GRButton {
            onButtonFound(button)
        } else {
            onButtonMiss?()
        }
    }
}
