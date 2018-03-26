//
//  LayerProtocol.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 24/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

// MARK: - Layer protocol

public protocol LayerProtocol {
    var layerNode: SKNode { get }
    func update(_ currentTime: TimeInterval)
}

public extension LayerProtocol {
    func update(_ currentTime: TimeInterval) {}
}
