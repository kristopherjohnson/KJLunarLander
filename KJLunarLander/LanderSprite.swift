//
//  LanderSprite.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Sprite for the player-controlled lander.
///
/// The lander sprite's main body consists of the
/// descent stage at the bottom.  The ascent stage
/// and lander feet are separate sprites, attached
/// to the main body.  The lander also has a
/// particle emitter for rocket thrust.

class LanderSprite: SKSpriteNode {
    /// Name used for all instances of `HeroSprite`.
    static let spriteName = "lander"

    private var ascentHull: SKSpriteNode?
    private var leftFoot: SKSpriteNode?
    private var rightFoot: SKSpriteNode?

    private var thrustEmitter: SKEmitterNode?
    private var thrustMaxParticleLifetime: CGFloat = 0.0
    private var thrustMaxParticleScale: CGFloat = 0.0
    private var thrustMaxParticleBirthRate: CGFloat = 0.0
    private var thrustMaxParticleSpeed: CGFloat = 0.0

    /// Lander's thrust level.
    ///
    /// When set, adjusts the parameters of the thrust emitter
    /// to indicate thrust level.
    var thrustLevel: CGFloat = 0.0 {
        didSet {
            if let thrustEmitter = thrustEmitter {
                if thrustLevel > 0.0 {
                    thrustEmitter.particleBirthRate = thrustLevel * thrustMaxParticleBirthRate
                    thrustEmitter.particleScale = thrustLevel * thrustMaxParticleScale
                    thrustEmitter.particleLifetime = thrustLevel * thrustMaxParticleLifetime
                    thrustEmitter.particleSpeed = thrustLevel * thrustMaxParticleSpeed
                }
                else {
                    thrustEmitter.particleBirthRate = 0
                }
            }
        }
    }
    /// Create a sprite for the lander at the specified position in the scene.
    ///
    /// This also creates the sprites attached to the main hull.
    class func sprite(scene: SKScene, position: CGPoint) -> LanderSprite {

        // Create the main body

        let lander = LanderSprite()
        lander.position = position
        scene.addChild(lander)

        let landerHeight = lander.size.height
        let landerHalfHeight = landerHeight / 2

        // Create and attach ascent-stage hull to the top.

        let ascentHull = makeAscentHullSprite()
        lander.ascentHull = ascentHull
        ascentHull.position = CGPoint(x: position.x,
                                      y: position.y + landerHalfHeight + ascentHull.size.height / 2)
        scene.addChild(ascentHull)

        let ascentHullConnectPoint = CGPoint(x: position.x,
                                             y: position.y + landerHalfHeight)
        let ascentHullJoint = SKPhysicsJointFixed.joint(withBodyA: lander.physicsBody!,
                                                        bodyB: ascentHull.physicsBody!,
                                                        anchor: ascentHullConnectPoint)
        scene.physicsWorld.add(ascentHullJoint)

        // Create and attach the left foot.

        let leftFoot = makeFootSprite()
        lander.leftFoot = leftFoot
        leftFoot.position = CGPoint(x: position.x - Constant.landerSize.width / 2 - Constant.footSize.width / 2,
                                    y: position.y - Constant.legHeight - Constant.footSize.height / 2)
        scene.addChild(leftFoot)

        let leftFootJoint = SKPhysicsJointFixed.joint(withBodyA: lander.physicsBody!,
                                                      bodyB: leftFoot.physicsBody!,
                                                      anchor: leftFoot.position)
        scene.physicsWorld.add(leftFootJoint)

        // Create and attach the right foot.
        
        let rightFoot = makeFootSprite()
        lander.rightFoot = leftFoot
        rightFoot.position = CGPoint(x: position.x + Constant.landerSize.width / 2 + Constant.footSize.width / 2,
                                     y: position.y - Constant.legHeight - Constant.footSize.height / 2)
        scene.addChild(rightFoot)

        let rightFootJoint = SKPhysicsJointFixed.joint(withBodyA: lander.physicsBody!,
                                                       bodyB: rightFoot.physicsBody!,
                                                       anchor: rightFoot.position)
        scene.physicsWorld.add(rightFootJoint)

        // Create and attach the thrust particle emitter.

        if let thrustEmitter = makeThrustEmitter() {
            lander.thrustEmitter = thrustEmitter

            lander.thrustMaxParticleLifetime = thrustEmitter.particleLifetime
            lander.thrustMaxParticleScale = thrustEmitter.particleScale
            lander.thrustMaxParticleBirthRate = thrustEmitter.particleBirthRate
            lander.thrustMaxParticleSpeed = thrustEmitter.particleSpeed

            thrustEmitter.particleBirthRate = 0

            thrustEmitter.position = CGPoint(x: 0, y: -landerHeight)
            lander.addChild(thrustEmitter)
        }

        return lander
    }

    private convenience init() {
        self.init(color: Color.lander,
                  size: Constant.landerHullSize)

        name = LanderSprite.spriteName

        let body = SKPhysicsBody(rectangleOf: size)
        physicsBody = body

        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.allowsRotation = true

        body.mass = Constant.landerMass * 0.6
        body.linearDamping = 0.0
        body.angularDamping = 4.0

        body.categoryBitMask = Category.lander
        body.contactTestBitMask = Category.surface
        body.collisionBitMask = Category.surface
    }

    private class func makeAscentHullSprite() -> SKSpriteNode {
        let ascentHull = SKSpriteNode(color: Color.ascentHull,
                                      size: CGSize(width: Constant.ascentHullRadius * 2,
                                                   height: Constant.ascentHullRadius * 2))

        let body = SKPhysicsBody(circleOfRadius: Constant.ascentHullRadius)
        ascentHull.physicsBody = body

        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.allowsRotation = true

        body.mass = Constant.landerMass * 0.3
        body.linearDamping = 0.0
        body.angularDamping = 4.0

        body.categoryBitMask = Category.lander
        body.contactTestBitMask = Category.surface
        body.collisionBitMask = Category.surface

        return ascentHull
    }

    private class func makeFootSprite() -> SKSpriteNode {
        let foot = SKSpriteNode(color: Color.ascentHull,
                                size: Constant.footSize)

        let body = SKPhysicsBody(rectangleOf: Constant.footSize)
        foot.physicsBody = body

        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.allowsRotation = true

        body.mass = Constant.landerMass * 0.05
        body.linearDamping = 0.0
        body.angularDamping = 4.0

        body.categoryBitMask = Category.foot
        body.contactTestBitMask = Category.surface | Category.target
        body.collisionBitMask = Category.surface
        
        return foot
    }

    private class func makeThrustEmitter() -> SKEmitterNode? {
        if let path = Bundle.main.path(forResource: "ThrustParticle",
                                       ofType: "sks") {
            if let emitter = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? SKEmitterNode {
                return emitter
            }
            else {
                NSLog("Unable to unarchive ThrustParticle.sks")
            }
        }
        else {
            NSLog("Unable to find ThrustParticlePath.sks")
        }

        return nil
    }
}
