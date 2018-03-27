//
//  ReporterLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol GameListenerLayer: LayerProtocol {
    
    func started(phase: Int)
    func finished(phase: Int)
}

public extension GameListenerLayer {
    
    public func started(phase: Int) {}
    public func finished(phase: Int) {}
}
