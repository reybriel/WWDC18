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
        
        leftButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: leftButton.size.width/2 + 10
                ),
                y: SKRange(
                    constantValue: leftButton.size.height/2 + 10
                )
            )
        ]
        
        addChild(leftButton)
        
        frontButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: leftButton.size.width + frontButton.size.width/2 + 20
                ),
                y: SKRange(
                    constantValue: frontButton.size.height/2 + 10
                )
            )
        ]
        
        addChild(frontButton)
        
        upButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: frame.size.width - upButton.size.width/2 - 10
                ),
                y: SKRange(
                    constantValue: upButton.size.height/2 + 10
                )
            )
        ]
        
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
    
    private func trackButton(by touch: UITouch, onButtonFound: GRButtonAction, onButtonMiss: (() -> Void)?) {
        
        let location = touch.location(in: self)
        
        if let button = nodes(at: location).first as? GRButton {
            onButtonFound(button)
        } else {
            onButtonMiss?()
        }
    }
}
