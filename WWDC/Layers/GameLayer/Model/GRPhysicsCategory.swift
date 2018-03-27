//
//  GameLayer+SKPhysicsContactDelegate.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 23/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public struct GRPhysicsCategory {
    
    static let floor: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 0)
    static let module: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 1)
    static let obstacle: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 2)
    
    public let bitMask: UInt32
    
    public func collided(with category: GRPhysicsCategory, in contact: SKPhysicsContact) -> Bool {
        
        return (contact.bodyA.categoryBitMask == bitMask && contact.bodyB.categoryBitMask == category.bitMask) ||
            (contact.bodyB.categoryBitMask == bitMask && contact.bodyA.categoryBitMask == category.bitMask)
    }
}
