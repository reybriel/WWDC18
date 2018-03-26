//
//  ControlLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class ControlLayer: SKNode, LayerProtocol {
    
    // MARK: - LayerProtocol attributes
    
    public var layerNode: SKNode {
        zPosition = 20
        return self
    }
    
    // MARK: - Properties
    
    public var gameLayer: GameLayerProtocol?
    
    private let backButton = GRButton(
        imageNamed: "left",
        focusedImageNamed: "left focus"
    )
    
    private let frontButton = GRButton(
        imageNamed: "right",
        focusedImageNamed: "right focus"
    )
    
    private let jumpButton = GRButton(
        imageNamed: "up",
        focusedImageNamed: "up focus"
    )
    
    private var buttons: [GRButton] {
        return [backButton, frontButton, jumpButton]
    }
    
    private var pressedButton: GRButton? {
        
        return buttons.first(
            where: { $0.isPressed }
        )
    }
    
    override public var frame: CGRect {
        return UIScreen.main.bounds
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
        
        jumpButton.holdingEnabled = false
        
        backButton.onButtonPressed = { _ in self.gameLayer?.onLeftButtonPressed() }
        backButton.onButtonReleased = { _ in self.gameLayer?.onLeftButtonUnpressed() }
        frontButton.onButtonPressed = { _ in self.gameLayer?.onRightButtonPressed() }
        frontButton.onButtonReleased = { _ in self.gameLayer?.onRightButtonUnpressed() }
        jumpButton.onButtonPressed = { _ in self.gameLayer?.onJumpButtonPressed() }
        jumpButton.onButtonReleased = { _ in self.gameLayer?.onJumpButtonUnpressed() }
        
        layoutButtons()
    }
    
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
    
    private func layoutButtons() {
        
        backButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: backButton.size.width/2 + 10
                ),
                y: SKRange(
                    constantValue: backButton.size.height/2 + 10
                )
            )
        ]
        
        addChild(backButton)
        
        frontButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: backButton.size.width + frontButton.size.width/2 + 20
                ),
                y: SKRange(
                    constantValue: frontButton.size.height/2 + 10
                )
            )
        ]
        
        addChild(frontButton)
        
        jumpButton.constraints = [
            SKConstraint.positionX(
                SKRange(
                    constantValue: frame.size.width - jumpButton.size.width/2 - 10
                ),
                y: SKRange(
                    constantValue: jumpButton.size.height/2 + 10
                )
            )
        ]
        
        addChild(jumpButton)
    }
}
