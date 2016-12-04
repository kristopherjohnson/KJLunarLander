//
//  LunarSurfaceSprite.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Sprite for the lunar surface

class SurfaceSprite: SKSpriteNode {
    static let spriteName = "surface"

    convenience init() {
        let surfaceSize = CGSize(width: Constant.sceneSize.width,
                                 height: Constant.sceneSize.height / 20)
        self.init(color: .gray, size: surfaceSize)

        name = SurfaceSprite.spriteName

        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.isDynamic = false
        physicsBody!.affectedByGravity = false
        physicsBody!.allowsRotation = false
        physicsBody!.categoryBitMask = Category.surface
        physicsBody!.contactTestBitMask = Category.lander
        physicsBody!.collisionBitMask = Category.lander
    }
}
