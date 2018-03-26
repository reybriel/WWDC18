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
    
    private let gameLayer = GameLayer()
    private let textLayer = TextLayer()
    private var controlLayer = ControlLayer()
    
    private lazy var layers: [LayerProtocol] = [gameLayer, textLayer, controlLayer]
    
    // MARK: - Lifecycle
    
    override public func didMove(to view: SKView) {
        
        backgroundColor = .white
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = gameLayer
        
        controlLayer.controlable = gameLayer
        
        addLayers(layers: layers)
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
    
    public override func update(_ currentTime: TimeInterval) {
        updateLayers(currentTime)
    }
    
    private func updateLayers(_ currentTime: TimeInterval) {
        layers.forEach { (layer) in
            layer.update(currentTime)
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
    }
}
