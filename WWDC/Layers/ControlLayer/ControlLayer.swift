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
    
    ///The layer that is being controlled by this control layer.
    public var controlable: ControlableLayer?
    
    ///Left button.
    private var leftButton: GRButton!
    ///Right button.
    private var rightButton: GRButton!
    ///Up button.
    private var upButton: GRButton!
    
    ///Control buttons.
    private var controlButtons: [GRButton] {
        return [leftButton, rightButton, upButton]
    }
    
    ///Help button.
    private var helpButton: GRButton!
    
    ///The button that is being pressed.
    private var pressedButton: GRButton? {
        
        return controlButtons.first(
            where: { $0.isPressed }
        )
    }
    
    // MARK: - Initializers
    
    ///:nodoc:
    override public init() {
        super.init()
        commonInit()
    }
    
    ///:nodoc:
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    ///A common initialization for the layer.
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
        
        rightButton = GRButton(
            imageNamed: "right",
            focusedImageNamed: "right focus"
        )
        
        rightButton.onButtonPressed = {
            _ in
            self.controlable?.onRightButtonPressed()
        }
        
        rightButton.onButtonReleased = {
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
        
        helpButton = GRButton(
            imageNamed: "help",
            focusedImageNamed: "help focus"
        )
        
        helpButton.holdingEnabled = false
        
        helpButton.onButtonPressed = {
            _ in
            self.controlable?.onHelpButtonPressed()
        }
        
        layoutButtons()
    }
    
    ///Organize the button in the right positions.
    private func layoutButtons() {
        
        leftButton.position = CGPoint(
            x: leftButton.frame.width/2 + 10.0,
            y: leftButton.frame.height/2 + 10.0
        )
        
        addChild(leftButton)
        
        rightButton.position = CGPoint(
            x: leftButton.frame.maxX + rightButton.frame.width/2 + 10.0,
            y: rightButton.frame.height/2 + 10.0
        )
        
        addChild(rightButton)
        
        upButton.position = CGPoint(
            x: frame.width - (upButton.frame.width/2 + 10.0),
            y: upButton.frame.height/2 + 10.0
        )
        
        addChild(upButton)
        
        helpButton.position = CGPoint(
            x: frame.width - (helpButton.frame.width/2 + 10.0),
            y: -(helpButton.frame.height/2 + 10.0)
        )
        helpButton.isHidden = true
        
        addChild(helpButton)
    }
}

public extension ControlLayer {
    
    // MARK: - Touches
    
    ///:nodoc:
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.press() },
            onButtonMiss: nil
        )
    }
    
    ///:nodoc:
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.press() },
            onButtonMiss: { self.pressedButton?.unpress() }
        )
    }
    
    ///:nodoc:
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.unpress() },
            onButtonMiss: nil
        )
    }
    
    ///:nodoc:
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        trackButton(
            by: touches.first!,
            onButtonFound: { $0.unpress() },
            onButtonMiss: nil
        )
    }
    
    // MARK: - Control layer methods
    
    /**
     Presents the buttons that are required for a given phase.
     
     - parameter phase: The phase that requires the buttons.
     */
    public func presentButtons(ofPhase phase: Int) {
        
        switch phase {
            
        case 1:
            controlButtons.forEach { $0.show() }
            break
        
        case 2:
            leftButton.show()
            rightButton.show()
            Timer.scheduledTimer(withTimeInterval: 8.5, repeats: false) { _ in self.helpButton.show() }
            break
        
        case 3:
            leftButton.show()
            rightButton.show()
            break
            
        default: break
        }
    }
    
    ///Hides all the buttons of the layer.
    public func hideButtons() {
        controlButtons.forEach { $0.hide() }
        helpButton.hide()
    }
    
    ///Presents the replay button by the end of the game.
    public func presentReplay() {
        
        let replayButton = GRButton(
            imageNamed: "replay",
            focusedImageNamed: "replay focus"
        )
        
        replayButton.position = CGPoint(
            x: frame.midX,
            y: frame.midY + 60.0
        )
        
        replayButton.holdingEnabled = false
        
        replayButton.onButtonPressed = {
            _ in
            self.controlable?.onReplayButtonPressed()
            replayButton.disappear()
        }
        replayButton.alpha = 0.0
        addChild(replayButton)
        replayButton.appear()
    }
    
    /**
     Tracks a button with a given touch.
     
     - parameter touch: The touch used to track the button.
     - parameter onButtonFound: A block of code to be executed in case a button is found.
     - parameter onButtonMiss: A block of code to be executed in case no button is found.
     */
    private func trackButton(by touch: UITouch, onButtonFound: GRButtonAction, onButtonMiss: (() -> Void)?) {
        
        let location = touch.location(in: self)
        
        if let button = nodes(at: location).first as? GRButton {
            onButtonFound(button)
        } else {
            onButtonMiss?()
        }
    }
}
