//
//  GameLayer+SKPhysicsContactDelegate.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 23/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

///The physic categories of the game.
public struct GRPhysicsCategory {
    
    ///Ball physics category.
    static let ball: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 0)
    ///Floor physics category.
    static let floor: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 1)
    ///Obstacle physics category.
    static let obstacle: GRPhysicsCategory = GRPhysicsCategory(bitMask: 0x1 << 2)
    
    ///Physics category bitMask.
    public let bitMask: UInt32
    
    /**
     This method checks if a body collided with another body of a given category in a given contact.
     
     - parameter category: The category used to test if there was a collision between.
     - parameter contact: The physics contact that contains the bodies.
     */
    public func collided(with category: GRPhysicsCategory, in contact: SKPhysicsContact) -> Bool {
        
        return (contact.bodyA.categoryBitMask == bitMask && contact.bodyB.categoryBitMask == category.bitMask) ||
            (contact.bodyB.categoryBitMask == bitMask && contact.bodyA.categoryBitMask == category.bitMask)
    }
}
