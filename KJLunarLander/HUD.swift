//
//  HUD.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Node that displays text at the top of the screen

class HUD: SKNode {
    static let spriteName = "hud"

    private static let fontName = "Orbitron-Light"
    private static let fontSize: CGFloat = 10

    private static let linePitch: CGFloat = 32

    private var altitude: SKLabelNode!
    private var horizontalSpeed: SKLabelNode!
    private var verticalSpeed: SKLabelNode!
    private var thrust: SKLabelNode!

    /// Constructor for HUD.
    ///
    /// This constructor automatically adds the HUD nodes to the
    /// specified parent node.
    convenience init(parent: SKNode) {
        self.init()

        name = HUD.spriteName

        self.position = CGPoint()
        parent.addChild(self)

        if let skView = self.scene?.view {
            let upperRightCorner = CGPoint(x: skView.frame.size.width,
                                           y: 0)
            print("upperRightCorner: \(upperRightCorner)")
            var nextPosition = CGPoint(x: upperRightCorner.x - 100,
                                       y: upperRightCorner.y + HUD.linePitch)
            print("nextPosition: \(nextPosition)")

            altitude = makeValueNode()
            addNodes(valueNode: altitude,
                     labelText: "Altitude",
                     viewPosition: nextPosition)

            nextPosition.y += HUD.linePitch
            print("nextPosition: \(nextPosition)")

            horizontalSpeed = makeValueNode()
            addNodes(valueNode: horizontalSpeed,
                     labelText: "Horizontal Speed",
                     viewPosition: nextPosition)

            nextPosition.y += HUD.linePitch
            print("nextPosition: \(nextPosition)")

            verticalSpeed = makeValueNode()
            addNodes(valueNode: verticalSpeed,
                     labelText: "Vertical Speed",
                     viewPosition: nextPosition)

            nextPosition.y += HUD.linePitch
            print("nextPosition: \(nextPosition)")

            thrust = makeValueNode()
            addNodes(valueNode: thrust,
                     labelText: "Thrust",
                     viewPosition: nextPosition)
        }
    }

    /// Update the values displayed in the HUD
    func updateDisplayValues(lander: LanderSprite, thrust thrustValue: CGFloat) {
        // TODO: subtract surface altitude and 1/2 lander height
        altitude.text = format(value: lander.position.y - 34)

        if let body = lander.physicsBody {
            // TODO: Display directional arrows
            horizontalSpeed.text = format(value: body.velocity.dx)
            verticalSpeed.text = format(value: body.velocity.dy)
        }

        thrust.text = format(value: thrustValue * 100)
    }

    /// Format a value for display in the HUD
    private func format(value: CGFloat) -> String {
        return String(format: "%d", Int(roundf(Float(value))))
    }

    /// Add a node to display a value, along with a label node.
    ///
    /// - parameter valueNode: The value node.
    /// - parameter labelText: Static text to be displayed to the left of the value.
    /// - parameter viewPosition: The center of the left edge of the valueNode, in SKView coordinates.
    private func addNodes(valueNode: SKLabelNode, labelText: String, viewPosition: CGPoint) {
        if let skView = self.scene?.view {
            let valueScenePosition = skView.convert(viewPosition, to: self.scene!)
            let labelScenePosition = skView.convert(viewPosition.pointToLeft(by: 6), to: self.scene!)
            let label = makeLabelNode(text: labelText)

            valueNode.position = valueScenePosition
            label.position = labelScenePosition

            addChild(label)
            addChild(valueNode)
        }
    }

    /// Create a text node to be used as a label.
    ///
    /// Labels are right-aligned.
    private func makeLabelNode(text: String) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: HUD.fontName)
        node.fontSize = HUD.fontSize
        node.fontColor = Color.hud
        node.horizontalAlignmentMode = .right
        node.text = text
        return node
    }

    /// Create a text node to be used to display a value.
    ///
    /// Values are left-aligned.
    private func makeValueNode() -> SKLabelNode {
        let node = SKLabelNode(fontNamed: HUD.fontName)
        node.fontSize = HUD.fontSize
        node.fontColor = Color.hud
        node.horizontalAlignmentMode = .left
        return node
    }
}
