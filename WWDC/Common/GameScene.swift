//
//  GameScene.swift
//  WWDC
//
//  Created by Gabriel Reynoso on 20/03/2018.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import SpriteKit

public class GameScene: SKScene {
    
    // MARK: - Scene layers
    
    ///Layer responsable for controlling the actions of the game.
    fileprivate let gameLayer = GameLayer()
    ///Layer responsable for displaying the texts.
    fileprivate let textLayer = TextLayer()
    ///Layer responsable for displaying the controls of the game.
    fileprivate var controlLayer = ControlLayer()
    
    ///All the layers of the scene.
    fileprivate lazy var layers: [LayerProtocol] = [gameLayer, textLayer, controlLayer]
    
    // MARK: - Lifecycle
    
    ///:nodoc:
    override public func didMove(to view: SKView) {
        
        backgroundColor = .white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = gameLayer
        
        gameLayer.listener = self
        textLayer.listener = self
        controlLayer.controlable = gameLayer
        
        addLayers(layers: layers)
    }
}

extension GameScene: GameListener {
    
    // MARK: - Game listener methods
    
    public func willStart(_ phase: Int) {
        textLayer.showInstruction(for: phase)
        controlLayer.presentButtons(ofPhase: phase)
    }
    
    public func finished(_ phase: Int) {
        textLayer.showMessage(for: phase)
        controlLayer.hideButtons()
    }
    
    public func willStartDisplayingMessage(_ phase: Int) {
    }
    
    public func finishedDisplayingMessage(_ phase: Int) {
        
        if phase != 3 {
            gameLayer.startPhase()
        } else {
            controlLayer.presentReplay()
        }
    }
    
    // MARK: - Game scene methods
    
    /**
     Adds an arrray of layers to scene.
     
     - parameter layers: The layers to be added to the scene.
     */
    private func addLayers(layers: [LayerProtocol]) {
        layers.forEach { (layer) in
            addLayer(layer: layer)
        }
    }
    
    /**
    Add a single layer to the scene.
     
     - parameter layer: The layer to be added to the scene.
     */
    private func addLayer(layer: LayerProtocol) {
        addChild(layer.layerNode)
        layer.wasAdded(to: self)
    }
    
    // MARK: - Update
    
    ///Updates all the layers of the scene.
    private func updateLayers(_ currentTime: TimeInterval) {
        layers.forEach { (layer) in
            layer.update(currentTime)
        }
    }
    
    ///:nodoc:
    public override func update(_ currentTime: TimeInterval) {
        updateLayers(currentTime)
    }
    
    // MARK: - Touches
    
    ///:nodoc:
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesBegan(touches, with: event)
    }
    
    ///:nodoc:
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesMoved(touches, with: event)
    }
    
    ///:nodoc:
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesEnded(touches, with: event)
    }
    
    ///:nodoc:
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesCancelled(touches, with: event)
    }
}
