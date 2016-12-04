//
//  LanderSceneController.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Implements the lander game.

class LanderSceneController: NSObject {
    private let view: SKView
    private let scene: SKScene

    weak var controlInput: ControlInput?
    
    public init(view: SKView) {
        self.view = view

        scene = SKScene(size: Constant.sceneSize)
        scene.scaleMode = .aspectFit

        scene.physicsWorld.gravity = CGVector(dx: 0,
                                              dy: Constant.lunarGravity)

        view.presentScene(scene)

        view.ignoresSiblingOrder = true

        if true {
            view.showsFPS = true
            view.showsDrawCount = true
            view.showsNodeCount = true
            view.showsQuadCount = true
            view.showsPhysics = true
            view.showsFields = true
        }

        let surface = SurfaceSprite()
        surface.position = CGPoint(x: surface.size.width / 2,
                                   y: surface.size.height / 2)
        scene.addChild(surface)

        let lander = LanderSprite()
        lander.position = Constant.landerInitialPosition
        scene.addChild(lander)

        super.init()

        scene.delegate = self
        scene.physicsWorld.contactDelegate = self
    }
}

// MARK: - SKSceneDelegate
extension LanderSceneController: SKSceneDelegate {
    public func update(_ currentTime: TimeInterval, for scene: SKScene) {

    }

    public func didEvaluateActions(for scene: SKScene) {

    }

    public func didSimulatePhysics(for scene: SKScene) {

    }

    public func didApplyConstraints(for scene: SKScene) {

    }

    public func didFinishUpdate(for scene: SKScene) {
        
    }
}

// MARK: - SKPhysicsContactDelegate
extension LanderSceneController: SKPhysicsContactDelegate {

    public func didBegin(_ contact: SKPhysicsContact) {

    }

    public func didEnd(_ contact: SKPhysicsContact) {

    }
}
