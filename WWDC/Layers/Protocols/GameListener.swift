//
//  GameListener.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 26/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

/**
 This protocol defines all the behaviors of the game that can be observed.
 */
public protocol GameListener {
    
    // MARK: - Game layer actions
    
    /**
     This method is trigerred when the game layer will start a new phase.
     
     - parameter phase: The phase that is about to be started.
     */
    func willStart(_ phase: Int)
    
    /**
     This method is triggered when the game layer finishes a phase.
     
     - parameter phase: The phase that was finished.
     */
    func finished(_ phase: Int)
    
    /**
     This method is triggered when the text layer will start displaying a message.
     
     - parameter phase: The phase of the game that is ending.
     */
    func willStartDisplayingMessage(_ phase: Int)
    
    /**
     This method is triggered when the text layer finishes to diplay a message.
     
     - parameter phase: The phase of the game that is ending.
     */
    func finishedDisplayingMessage(_ phase: Int)
}

public extension GameListener {
    public func willStart(_ phase: Int) {}
    public func finished(_ phase: Int) {}
    public func willStartDisplayingMessage(_ phase: Int) {}
    public func finishedDisplayingMessage(_ phase: Int) {}
}
