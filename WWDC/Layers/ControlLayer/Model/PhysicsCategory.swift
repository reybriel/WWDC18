//
//  GameLayer+SKPhysicsContactDelegate.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 23/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public struct PhysicsCategory {
    
    static let floor: PhysicsCategory = PhysicsCategory(bitMask: 0x1 << 0)
    static let module: PhysicsCategory = PhysicsCategory(bitMask: 0x1 << 1)
    static let obstacle: PhysicsCategory = PhysicsCategory(bitMask: 0x1 << 2)
    
    public let bitMask: UInt32
    
    public func collided(with category: PhysicsCategory, in contact: SKPhysicsContact) -> Bool {
        
        return (contact.bodyA.categoryBitMask == bitMask && contact.bodyB.categoryBitMask == category.bitMask) ||
            (contact.bodyB.categoryBitMask == bitMask && contact.bodyA.categoryBitMask == category.bitMask)
    }
}
