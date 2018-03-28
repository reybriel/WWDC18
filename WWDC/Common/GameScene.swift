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
    
    fileprivate let gameLayer = GameLayer()
    fileprivate let textLayer = TextLayer()
    fileprivate var controlLayer = ControlLayer()
    
    fileprivate lazy var layers: [LayerProtocol] = [gameLayer, textLayer, controlLayer]
    
    // MARK: - Lifecycle
    
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
    
    public func finished(_ phase: Int) {
        textLayer.showMessage(for: phase)
        controlLayer.hideButtons()
    }
    
    public func finishedDisplayingMessage(_ phase: Int) {
        
        if phase != 3 {
            textLayer.showInstruction(for: gameLayer.phase)
            controlLayer.showButtons(ofPhase: gameLayer.phase)
            gameLayer.startPhase()
        }
    }
    
    // MARK: - Auxiliars
    
    private func addLayers(layers: [LayerProtocol]) {
        layers.forEach { (layer) in
            addLayer(layer: layer)
        }
    }
    
    private func addLayer(layer: LayerProtocol) {
        addChild(layer.layerNode)
        layer.wasAdded(to: self)
    }
    
    // MARK: - Touches
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesBegan(touches, with: event)
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesMoved(touches, with: event)
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesEnded(touches, with: event)
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        controlLayer.touchesCancelled(touches, with: event)
    }
    
    // MARK: - Update
    
    private func updateLayers(_ currentTime: TimeInterval) {
        layers.forEach { (layer) in
            layer.update(currentTime)
        }
    }
    
    public override func update(_ currentTime: TimeInterval) {
        updateLayers(currentTime)
    }
}
