//
//  ReporterLayer.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

public protocol ReporterLayer: LayerProtocol {
    
    func displayTexts(ofPhase phase: Int)
    func displayInstruction(ofPhase phase: Int)
}

public extension ReporterLayer {
    
    public func displayTexts(ofPhase phase: Int) {}
    public func displayInstruction(ofPhase phase: Int) {}
}
