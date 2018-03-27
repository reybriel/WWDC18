//
//  GameButton.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public typealias GRButtonAction = (_ button: GRButton) -> Void

public class GRButton: SKSpriteNode {
    
    // MARK: - GRButton Properties
    
    private var focusedTexture: SKTexture? = nil
    private var unfocusedTexture: SKTexture? = nil
    
    private(set) var isPressed = false
    
    public var isNotPressed: Bool {
        
        get {
            return !isPressed
        }
        
        set {
            isPressed = !newValue
        }
    }
    
    public var holdingEnabled: Bool = true
    
    private var holdingTimer: Timer? = nil
    
    // MARK: - Event handlers
    
    public var onButtonPressed: GRButtonAction?
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
    
    public func press() {
        
        if isNotPressed {
            texture = focusedTexture
            holdingUpdate()
            isNotPressed = false
        }
    }
    
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
    
    public func unpress() {
        
        if isPressed {
            texture = unfocusedTexture
            holdingTimer?.invalidate()
            holdingTimer = nil
            self.onButtonReleased?(self)
            isPressed = false
        }
    }
}
