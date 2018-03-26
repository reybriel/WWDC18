//
//  ControlDelegate.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 24/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol ControlableLayer: LayerProtocol {
    
    func onLeftButtonPressed()
    func onLeftButtonUnpressed()
    func onRightButtonPressed()
    func onRightButtonUnpressed()
    func onJumpButtonPressed()
    func onJumpButtonUnpressed()
}

public extension ControlableLayer {
    
    public func onLeftButtonPressed() {}
    public func onLeftButtonUnpressed() {}
    public func onRightButtonPressed() {}
    public func onRightButtonUnpressed() {}
    public func onJumpButtonPressed() {}
    public func onJumpButtonUnpressed() {}
}
