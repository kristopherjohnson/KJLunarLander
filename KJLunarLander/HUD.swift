//
//  HUD.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// Node that displays text over the screen.
final class HUD: SKNode {
    static let spriteName = "hud"

    private static let fontName = "Orbitron-Light"

    private static let fontSize: CGFloat = Constant.sceneSize.height / 36

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

        self.zPosition = ZPosition.hud
        parent.addChild(self)

        // Create SKLabelNodes for text elements.

        let altitudeLabel = addLabelNode(
            text: NSLocalizedString("Altitude",
                                    comment: "Altitude"))
        altitude = addValueNode()

        let horizontalSpeedLabel = addLabelNode(
            text: NSLocalizedString("Horizontal Speed",
                                    comment: "Horizontal Speed"))
        horizontalSpeed = addValueNode()

        let verticalSpeedLabel = addLabelNode(
                 text: NSLocalizedString("Vertical Speed",
                                         comment: "Vertical Speed"))
        verticalSpeed = addValueNode()

        let thrustLabel = addLabelNode(
            text: NSLocalizedString("Thrust",
                                    comment: "Thrust"))
        thrust = addValueNode()

        // Lay out the labels.

        let sceneSize = Constant.sceneSize
        let upperRightCorner = CGPoint(x: sceneSize.width / 2,
                                       y: sceneSize.height / 2)
        let columnLayouts: [ColumnLayout] = [
            .right(width: 100), // label
            .right(width: 50),  // value
            .left(width: 20)    // optional additional indicator
        ]
        let rows: [[SKLabelNode]] = [
            [altitudeLabel,        altitude],
            [horizontalSpeedLabel, horizontalSpeed],
            [verticalSpeedLabel,   verticalSpeed],
            [thrustLabel,          thrust]
        ]
        let _ = layoutGrid(left: upperRightCorner.x - 200,
                           top: upperRightCorner.y - 2 * HUD.fontSize,
                           horizontalPadding: 6,
                           verticalPadding: 6,
                           rowHeight: HUD.fontSize,
                           columnLayouts: columnLayouts,
                           rows: rows)
    }

    /// Update the values displayed in the HUD
    func updateDisplayValues(lander: LanderSprite, altitude: CGFloat) {
        self.altitude.text = format(value: altitude)

        if let body = lander.physicsBody {
            // TODO: Display directional arrows instead of +/-
            horizontalSpeed.text = format(value: body.velocity.dx)
            verticalSpeed.text = format(value: body.velocity.dy)
        }

        thrust.text = format(value: lander.thrustLevel * 100)
    }

    /// Format a value for display in the HUD
    private func format(value: CGFloat) -> String {
        return String(format: "%d", Int(roundf(Float(value))))
    }

    /// Create a text node to be used as a label.
    private func addLabelNode(text: String) -> SKLabelNode {
        let node = SKLabelNode(fontNamed: HUD.fontName)
        node.fontSize = HUD.fontSize
        node.fontColor = Color.hud
        node.text = text
        addChild(node)
        return node
    }

    /// Create a text node to be used to display a value.
    private func addValueNode() -> SKLabelNode {
        let node = SKLabelNode(fontNamed: HUD.fontName)
        node.fontSize = HUD.fontSize
        node.fontColor = Color.hud
        addChild(node)
        return node
    }
}
