//
//  GameListener.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol GameListener {
    func finished(_ phase: Int)
}

public extension GameListener {
    public func finished(_ phase: Int) {}
}
