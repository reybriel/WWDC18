//
//  MessageListener.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 27/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol MessageListener {
    
    func finishedDisplayingMessage(_ phase: Int)
}

public extension MessageListener {
    
    func finishedDisplayingMessage(_ phase: Int) {}
}
