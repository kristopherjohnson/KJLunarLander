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

    private var ascentHull: SKShapeNode?
    private var ascentHullJoint: SKPhysicsJointFixed?

    private var leftFoot: SKSpriteNode?
    private var leftFootJoint: SKPhysicsJointFixed?

    private var rightFoot: SKSpriteNode?
    private var rightFootJoint: SKPhysicsJointFixed?

    private var thrustEmitter: SKEmitterNode?
    private var thrustMaxParticleLifetime: CGFloat = 0.0
    private var thrustMaxParticleScale: CGFloat = 0.0
    private var thrustMaxParticleBirthRate: CGFloat = 0.0
    private var thrustMaxParticleSpeed: CGFloat = 0.0

    /// Lander's thrust level.
    ///
    /// When set, adjusts the parameters of the thrust emitter.
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
    class func sprite(scene: SKScene, position: CGPoint, velocity: CGVector) -> LanderSprite {

        // Create the main body

        let lander = LanderSprite()
        lander.position = position
        lander.zPosition = ZPosition.lander
        lander.physicsBody?.velocity = velocity
        scene.addChild(lander)

        let landerHeight = lander.size.height
        let landerHalfHeight = landerHeight / 2

        // Create and attach ascent-stage hull to the top.

        let ascentHull = makeAscentHullSprite()
        lander.ascentHull = ascentHull
        ascentHull.position = CGPoint(x: position.x,
                                      y: position.y + landerHalfHeight + Constant.ascentHullRadius)
        ascentHull.zPosition = ZPosition.lander
        ascentHull.physicsBody?.velocity = velocity
        scene.addChild(ascentHull)
        lander.ascentHullJoint = addFixedJoint(lander, ascentHull, toScene: scene)

        // Create and attach the left foot.

        let leftFoot = makeFootSprite()
        lander.leftFoot = leftFoot
        leftFoot.position = CGPoint(x: position.x - Constant.landerSize.width / 2 - Constant.footSize.width / 2,
                                    y: position.y - Constant.legHeight - Constant.footSize.height / 2)
        leftFoot.zPosition = ZPosition.lander
        leftFoot.physicsBody?.velocity = velocity
        scene.addChild(leftFoot)
        lander.leftFootJoint = addFixedJoint(lander, leftFoot, toScene: scene)

        // Create and attach the right foot.
        
        let rightFoot = makeFootSprite()
        lander.rightFoot = rightFoot
        rightFoot.position = CGPoint(x: position.x + Constant.landerSize.width / 2 + Constant.footSize.width / 2,
                                     y: position.y - Constant.legHeight - Constant.footSize.height / 2)
        rightFoot.zPosition = ZPosition.lander
        rightFoot.physicsBody?.velocity = velocity
        scene.addChild(rightFoot)
        lander.rightFootJoint = addFixedJoint(lander, rightFoot, toScene: scene)

        // Create and attach the thrust particle emitter.

        if let thrustEmitter = makeThrustEmitter() {
            lander.thrustEmitter = thrustEmitter

            lander.thrustMaxParticleLifetime = thrustEmitter.particleLifetime
            lander.thrustMaxParticleScale = thrustEmitter.particleScale
            lander.thrustMaxParticleBirthRate = thrustEmitter.particleBirthRate
            lander.thrustMaxParticleSpeed = thrustEmitter.particleSpeed

            thrustEmitter.particleZPosition = ZPosition.thrust
            thrustEmitter.particleBirthRate = 0

            thrustEmitter.position = CGPoint(x: 0, y: -landerHeight)
            thrustEmitter.zPosition = ZPosition.thrust
            lander.addChild(thrustEmitter)
        }

        return lander
    }

    /// Instantaneously move the lander to a new X coordinate.
    func wraparoundX(to newX: CGFloat) {
        let dx = newX - position.x
        self.moveRight(by: dx)
        ascentHull?.moveRight(by: dx)
        leftFoot?.moveRight(by: dx)
        rightFoot?.moveRight(by: dx)
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

    private class func makeAscentHullSprite() -> SKShapeNode {
        let ascentHull = SKShapeNode(circleOfRadius: Constant.ascentHullRadius)
        ascentHull.fillColor = Color.ascentHull
        ascentHull.strokeColor = UIColor.clear

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

    /// Create a new fixed joint and add it to the scene's physics world.
    ///
    /// Has no effect if nodeA or nodeB has no physics body.
    ///
    /// - parameter nodeA: A node.
    /// - parameter nodeB: Another node.
    /// - parameter scene: The SKScene to which the joint is to be added.
    ///
    /// - returns: The newly created SKPhysicsJoint, or nil if either node has no physicsBody.
    private class func addFixedJoint(_ nodeA: SKNode, _ nodeB: SKNode, toScene scene: SKScene) -> SKPhysicsJointFixed? {
        guard let bodyA = nodeA.physicsBody else { return nil }
        guard let bodyB = nodeB.physicsBody else { return nil }
        let anchor = nodeB.position
        let joint = SKPhysicsJointFixed.joint(withBodyA: bodyA, bodyB: bodyB, anchor: anchor)
        scene.physicsWorld.add(joint)
        return joint
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
