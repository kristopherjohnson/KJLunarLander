//
//  SurfaceNode.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Sprite for the lunar surface (the ground).

final class SurfaceNode: SKShapeNode {
    static let spriteName = "surface"

    /// Constructor
    convenience override init() {
        self.init(path: SurfaceNode.createSurfacePath())
    }

    /// Constructor
    ///
    /// - parameter path: Core Graphics path, relative to the scene
    init(path: CGPath) {
        super.init()

        self.name = SurfaceNode.spriteName
        self.path = path
        self.fillColor = Color.surface

        let body = SKPhysicsBody(polygonFrom: path)
        body.isDynamic = false
        body.affectedByGravity = false
        body.allowsRotation = false
        body.categoryBitMask = Category.surface
        body.contactTestBitMask = Category.lander
        body.collisionBitMask = Category.lander
        body.friction = Constant.surfaceFriction

        self.physicsBody = body
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Construct a path to be provided to the SurfaceNode constructor.
    ///
    /// - todo: Construct the surface algorithmically.
    private class func createSurfacePath() -> CGPath {

        // Points are in counterclockwise order, starting with
        // the upper-left edge mountaintop.
        //
        // The coordinates are normalized to the range 0.0...1.0,
        // and are later scaled to the size of the scene.  The
        // corner points are deliberately placed outside of the
        // scene so that the side and bottom edges are not visible.

        let normalizedPoints: [(CGFloat, CGFloat)] = [
            (-0.05,  0.30),    // upper-left corner
            (-0.05, -0.05),    // lower-left corner
            ( 1.05, -0.05),    // lower-right corner
            ( 1.05,  0.30),    // upper-right corner

            ( 0.95,  0.05),    // landing site right edge
            ( 0.85,  0.05),    // landing site left edge

            ( 0.83,  0.10),    // landing site right edge
            ( 0.80,  0.10),    // landing site left edge

            ( 0.78,  0.05),    // landing site left edge
            ( 0.68,  0.05),    // landing site right edge

            ( 0.63,  0.15),    // landing site left edge
            ( 0.58,  0.15),    // landing site right edge

            ( 0.50,  0.30),
            ( 0.38,  0.40),    // central peak

            ( 0.34,  0.30),    // landing site left edge
            ( 0.31,  0.30),    // landing site right edge

            ( 0.22,  0.05),
            ( 0.20,  0.20),

            ( 0.12,  0.10),    // landing site left edge
            ( 0.07,  0.10),    // landing site right edge

            ( 0.05,  0.05)
        ]
        let scale = Constant.sceneSize.width
        let points = normalizedPoints.map { CGPoint(x: $0.0 * scale,
                                                    y: $0.1 * scale) }
        return closedCGPath(points: points)
    }
}
