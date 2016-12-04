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
        self.init(color: .orange, size: Constant.landerSize)

        name = LanderSprite.spriteName

        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.isDynamic = true
        physicsBody!.usesPreciseCollisionDetection = true
        physicsBody!.allowsRotation = false
        physicsBody!.categoryBitMask = Category.lander
        physicsBody!.contactTestBitMask = Category.surface | Category.target
        physicsBody!.collisionBitMask = Category.surface
    }
}
