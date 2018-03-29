//
//  GameListener.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol GameListener {
    func willStart(_ phase: Int)
    func finished(_ phase: Int)
    func willStartDisplayingMessage(_ phase: Int)
    func finishedDisplayingMessage(_ phase: Int)
}

public extension GameListener {
    public func willStart(_ phase: Int) {}
    public func finished(_ phase: Int) {}
    public func willStartDisplayingMessage(_ phase: Int) {}
    public func finishedDisplayingMessage(_ phase: Int) {}
}
