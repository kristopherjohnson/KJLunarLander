//
//  LanderSceneController.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Implements the lander game.

class LanderSceneController: NSObject {
    fileprivate enum State {
        case start
        case inProgress
        case landed
        case destroyed
    }

    private let view: SKView
    private let scene: SKScene

    fileprivate var state = State.start

    fileprivate let lander: LanderSprite
    fileprivate let surface: SurfaceSprite
    fileprivate var hud: HUD?

    fileprivate var lastHUDUpdateTime: TimeInterval = 0

    weak var controlInput: ControlInput?
    
    init(view: SKView) {
        self.view = view

        scene = SKScene(size: Constant.sceneSize)
        scene.backgroundColor = .black
        scene.scaleMode = .aspectFit

        scene.physicsWorld.gravity = CGVector.zero

        view.presentScene(scene)

        view.ignoresSiblingOrder = true

        // Show SpriteKit diagnostics
        if true {
            view.showsFPS = true
            view.showsDrawCount = true
            view.showsNodeCount = true
            view.showsQuadCount = true
            //view.showsPhysics = true
            //view.showsFields = true
        }

        hud = HUD(parent: scene)

        surface = SurfaceSprite()
        surface.position = CGPoint(x: surface.size.width / 2,
                                   y: surface.size.height / 2)
        surface.zPosition = ZPosition.surface
        scene.addChild(surface)

        lander = LanderSprite.sprite(scene: scene,
                                     position: Constant.landerInitialPosition,
                                     velocity: Constant.landerInitialVelocity)

        super.init()

        scene.delegate = self
        scene.physicsWorld.contactDelegate = self
    }

    func viewDidLayoutSubviews() {
        // Recreate the HUD
        hud?.removeFromParent()
        hud = HUD(parent: scene)
    }
}

// MARK: - SKSceneDelegate
extension LanderSceneController: SKSceneDelegate {
    public func update(_ currentTime: TimeInterval, for scene: SKScene) {
        guard let controlInput = controlInput else { return }
        guard let landerBody = lander.physicsBody else { return }

        // If lander goes off left or right edge, wrap around to opposite edge.

        let sceneWidth = scene.size.width
        let landerX = lander.position.x
        if landerX < 0 {
            lander.wraparoundX(to: sceneWidth - 1)
        }
        else if landerX > sceneWidth {
            lander.wraparoundX(to: 1)
        }

        // Apply control inputs.
        
        let thrustLevel = controlInput.thrustInput
        lander.thrustLevel = thrustLevel
        if thrustLevel > 0 {
            let thrustForce = controlInput.thrustInput * Constant.landerThrust
            let thrustDirection = lander.zRotation + pi2
            let thrustVector = CGVector(angle: thrustDirection, length: thrustForce)
            landerBody.applyForce(thrustVector)
        }

        if controlInput.rotationInput != 0 {
            let torque = controlInput.rotationInput * Constant.landerTorque
            landerBody.applyTorque(torque)
        }

        // Update HUD.

        if let hud = hud {
            if (currentTime - lastHUDUpdateTime) > 0.1 {
                hud.updateDisplayValues(lander: lander)
                lastHUDUpdateTime = currentTime
            }
        }

        // State-specific handling

        switch state {
        case .start:
            if thrustLevel > 0.0 {
                scene.physicsWorld.gravity = CGVector(dx: 0, dy: Constant.lunarGravity)
                state = .inProgress
            }

        default:
            break
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
