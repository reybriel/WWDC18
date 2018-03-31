//
//  GameButton.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public typealias GRButtonAction = (_ button: GRButton) -> Void

private let showing      = SKAction.moveBy (x: 0.0, y:  kButtonAnimationOffset, duration: 0.8)
private let hiding       = SKAction.moveBy (x: 0.0, y: -kButtonAnimationOffset, duration: 0.8)
private let appearing    = SKAction.fadeIn (withDuration: 0.5)
private let disappearing = SKAction.fadeOut(withDuration: 0.5)

// MARK: - Constants

private let kButtonAnimationOffset: CGFloat = 80.0

///A button made of a sprite node.
public class GRButton: SKSpriteNode {
    
    // MARK: - GRButton Properties
    
    ///Texture used when the button is being pressed.
    private var focusedTexture: SKTexture? = nil
    ///Texture used when the button is not being pressed.
    private var unfocusedTexture: SKTexture? = nil
    
    ///Flag indicating if the button is pressed.
    private(set) var isPressed = false
    
    ///Flag indicating if the button is not pressed.
    public var isNotPressed: Bool {
        
        get {
            return !isPressed
        }
        
        set {
            isPressed = !newValue
        }
    }
    
    ///Flag indicating if the button is can be holded.
    public var holdingEnabled: Bool = true
    ///Flag indicating if the button is enabled.
    public var enabled: Bool = true
    
    ///Timer used to trigger the press action many times if the holding is enabled.
    private var holdingTimer: Timer? = nil
    
    // MARK: - Event handlers
    
    ///Block of code to be executed when the button is pressed.
    public var onButtonPressed: GRButtonAction?
    ///Block of code to be executed when the button is released.
    public var onButtonReleased: GRButtonAction?
    
    // MARK: - Initializers
    
    public init(imageNamed: String, focusedImageNamed: String) {
        
        let texture = SKTexture(
            imageNamed: imageNamed
        )
        
        super.init(texture: texture, color: .clear, size: texture.size())
        
        unfocusedTexture = texture
        
        focusedTexture = SKTexture(
            imageNamed: focusedImageNamed
        )
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - GRButton methods
    
    ///Presses the button.
    public func press() {
        
        if isNotPressed && enabled {
            texture = focusedTexture
            holdingUpdate()
            isNotPressed = false
        }
    }
    
    ///Unpressed the button.
    public func unpress() {
        
        if isPressed && enabled {
            texture = unfocusedTexture
            holdingTimer?.invalidate()
            holdingTimer = nil
            self.onButtonReleased?(self)
            isPressed = false
        }
    }
    
    ///Shows the button by making it comes up from bellow of the screen.
    public func show() {
        
        if isHidden {
            isHidden = false
            unpress()
            run(showing)
        }
    }
    
    ///Hides the button by making it comes down in the screen.
    public func hide() {
        
        if !isHidden {
            unpress()
            run(hiding) {
                self.isHidden = true
            }
        }
    }
    
    ///Makes the button apppear by fading it in.
    public func appear() {
        
        run(appearing)
    }
    
    ///Makes the button disappear by fading it out.
    public func disappear() {
        
        unpress()
        run(disappearing) {
            self.removeFromParent()
        }
    }
    
    /**
     This method is called for executing the action of the button pressing,
     whether it's one time or many.
     */
    private func holdingUpdate() {
        
        holdingTimer = Timer.scheduledTimer(
            withTimeInterval: 0.05,
            repeats: holdingEnabled,
            block: { _ in
                self.onButtonPressed?(self)
        }
        )
        holdingTimer?.fire()
    }
}
