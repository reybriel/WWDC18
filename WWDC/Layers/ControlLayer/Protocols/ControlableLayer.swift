//
//  ControlableLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 24/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

///This protocols defines the control events to be handled by the game.
public protocol ControlableLayer: LayerProtocol {
    
    ///This method is triggered when the left button is pressed.
    func onLeftButtonPressed()
    ///This method is triggered when the left button is released.
    func onLeftButtonUnpressed()
    ///This method is triggered when the right button is pressed.
    func onRightButtonPressed()
    ///This method is triggered when the right button is released.
    func onRightButtonUnpressed()
    ///This method is triggered when the jump button is pressed.
    func onJumpButtonPressed()
    ///This method is triggered when the help button is pressed.
    func onHelpButtonPressed()
    ///This method is triggered when the replay button is pressed.
    func onReplayButtonPressed()
}

public extension ControlableLayer {
    
    public func onLeftButtonPressed() {}
    public func onLeftButtonUnpressed() {}
    public func onRightButtonPressed() {}
    public func onRightButtonUnpressed() {}
    public func onJumpButtonPressed() {}
    public func onHelpButtonPressed() {}
    public func onReplayButtonPressed() {}
}
