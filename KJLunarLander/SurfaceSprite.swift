//
//  LunarSurfaceSprite.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Sprite for the lunar surface (the ground).

class SurfaceSprite: SKSpriteNode {
    static let spriteName = "surface"

    convenience init() {
        let surfaceSize = CGSize(width: Constant.sceneSize.width,
                                 height: Constant.sceneSize.height / 20)
        self.init(color: Color.surface, size: surfaceSize)

        name = SurfaceSprite.spriteName

        let body = SKPhysicsBody(rectangleOf: size)
        body.isDynamic = false
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = Category.surface
        body.contactTestBitMask = Category.lander
        body.collisionBitMask = Category.lander

        physicsBody = body
    }
}
