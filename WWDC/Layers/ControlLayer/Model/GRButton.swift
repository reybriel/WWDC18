//
//  GameButton.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public typealias GRButtonAction = (_ button: GRButton) -> Void

private let kButtonAreaHeight: CGFloat = 80.0

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
    public var enabled: Bool = true
    
    private var holdingTimer: Timer? = nil
    
    private lazy var showing = SKAction.moveBy(
        x: 0.0,
        y: kButtonAreaHeight,
        duration: 0.8
    )
    
    private lazy var hiding = SKAction.moveBy(
        x: 0.0,
        y: -kButtonAreaHeight,
        duration: 0.8
    )
    
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
        
        if isNotPressed && enabled {
            texture = focusedTexture
            holdingUpdate()
            isNotPressed = false
        }
    }
    
    public func unpress() {
        
        if isPressed && enabled {
            texture = unfocusedTexture
            holdingTimer?.invalidate()
            holdingTimer = nil
            self.onButtonReleased?(self)
            isPressed = false
        }
    }
    
    public func show() {
        
        enabled = true
        run(showing)
    }
    
    public func hide() {
        unpress()
        enabled = false
        run(hiding)
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
}
