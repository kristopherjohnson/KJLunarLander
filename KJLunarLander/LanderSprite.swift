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
/// to the main body.

class LanderSprite: SKSpriteNode {
    /// Name used for all instances of `HeroSprite`.
    static let spriteName = "lander"

    private var ascentHull: SKSpriteNode?
    private var leftFoot: SKSpriteNode?
    private var rightFoot: SKSpriteNode?

    /// Create a sprite for the lander at the specified position in the scene.
    ///
    /// This also creates the sprites attached to the main hull.
    class func sprite(scene: SKScene, position: CGPoint) -> LanderSprite {

        // Create the main body

        let lander = LanderSprite()
        lander.position = position
        scene.addChild(lander)

        // Create and attach ascent-stage hull to the top.

        let ascentHull = makeAscentHullSprite()
        lander.ascentHull = ascentHull
        ascentHull.position = CGPoint(x: position.x,
                                      y: position.y + lander.size.height / 2 + ascentHull.size.height / 2)
        scene.addChild(ascentHull)

        let ascentHullConnectPoint = CGPoint(x: position.x,
                                             y: position.y + lander.size.height / 2)
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
}
