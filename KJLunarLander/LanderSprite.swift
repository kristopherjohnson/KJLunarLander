//
//  LanderSprite.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Sprite for the player-controlled lander.

class LanderSprite: SKSpriteNode {
    /// Name used for all instances of `HeroSprite`.
    static let spriteName = "lander"

    convenience init() {
        self.init(color: Color.lander, size: Constant.landerSize)

        name = LanderSprite.spriteName

        let body = SKPhysicsBody(rectangleOf: size)

        body.isDynamic = true
        body.usesPreciseCollisionDetection = true
        body.allowsRotation = true

        body.mass = Constant.landerMass
        body.linearDamping = 0.0
        body.angularDamping = 4.0

        body.categoryBitMask = Category.lander
        body.contactTestBitMask = Category.surface | Category.target
        body.collisionBitMask = Category.surface

        physicsBody = body
    }
}
