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

    fileprivate let lander: LanderSprite
    fileprivate let surface: SurfaceSprite

    weak var controlInput: ControlInput?
    
    public init(view: SKView) {
        self.view = view

        scene = SKScene(size: Constant.sceneSize)
        scene.backgroundColor = .black
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

        surface = SurfaceSprite()
        surface.position = CGPoint(x: surface.size.width / 2,
                                   y: surface.size.height / 2)
        scene.addChild(surface)

        lander = LanderSprite()
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
        // If lander goes off left or right edge, wrap around to opposite edge.
        let sceneWidth = scene.size.width
        while lander.position.x > sceneWidth {
            lander.position.x -= sceneWidth
        }
        while lander.position.x < 0 {
            lander.position.x += sceneWidth
        }

        // Apply control inputs
        
        guard let controlInput = controlInput else { return }
        guard let landerBody = lander.physicsBody else { return }

        if controlInput.thrustInput != 0 {
            let thrustForce = controlInput.thrustInput * Constant.landerThrust
            let thrustDirection = Float(lander.zRotation) + Float(M_PI_2)
            let thrustVector = CGVector(dx: thrustForce * CGFloat(cosf(thrustDirection)),
                                        dy: thrustForce * CGFloat(sinf(thrustDirection)))
            landerBody.applyForce(thrustVector)
        }

        if controlInput.rotationInput != 0 {
            let torque = controlInput.rotationInput * Constant.landerTorque
            landerBody.applyTorque(torque)
        }
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
