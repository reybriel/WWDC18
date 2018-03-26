//
//  SKPhysicsBody+Extension.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 24/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public extension SKPhysicsBody {
    
    public var dxVelocityValue: CGFloat {
        return velocity.dx
    }
    
    public var dyVelocityValue: CGFloat {
        return velocity.dy
    }
}
