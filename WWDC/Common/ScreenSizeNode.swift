//
//  ScreenSizeNode.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class ScreenSizeNode: SKNode {
    
    override public var frame: CGRect {
        return UIScreen.main.bounds
    }
    
    public var center: CGPoint {
        
        return CGPoint(
            x: frame.midX,
            y: frame.midY
        )
    }
}
