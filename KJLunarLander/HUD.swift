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

    private static let fontSize: CGFloat = Constant.sceneSize.height / 32

    private static let linePitch: CGFloat = fontSize * 1.25
    
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

        let sceneSize = scene!.size
        let upperRightCorner = CGPoint(x: sceneSize.width,
                                       y: sceneSize.height)
        let rightInset = 5 * HUD.fontSize
        var nextPosition = CGPoint(x: upperRightCorner.x - rightInset,
                                   y: upperRightCorner.y - HUD.linePitch)

        altitude = makeValueNode()
        addNodes(valueNode: altitude,
                 labelText: NSLocalizedString("Altitude",
                                              comment: "Altitude"),
                 position: nextPosition)

        nextPosition.y -= HUD.linePitch

        horizontalSpeed = makeValueNode()
        addNodes(valueNode: horizontalSpeed,
                 labelText: NSLocalizedString("Horizontal Speed",
                                              comment: "Horizontal Speed"),
                 position: nextPosition)

        nextPosition.y -= HUD.linePitch

        verticalSpeed = makeValueNode()
        addNodes(valueNode: verticalSpeed,
                 labelText: NSLocalizedString("Vertical Speed",
                                              comment: "Vertical Speed"),
                 position: nextPosition)

        nextPosition.y -= HUD.linePitch

        thrust = makeValueNode()
        addNodes(valueNode: thrust,
                 labelText: "Thrust",
                 position: nextPosition)
    }

    /// Update the values displayed in the HUD
    func updateDisplayValues(lander: LanderSprite) {
        // TODO: determine altitude relative to surface, not absolute altitude
        altitude.text = format(value: lander.position.y - 34)

        if let body = lander.physicsBody {
            // TODO: Display directional arrows
            horizontalSpeed.text = format(value: body.velocity.dx)
            verticalSpeed.text = format(value: body.velocity.dy)
        }

        thrust.text = format(value: lander.thrustLevel * 100)
    }

    /// Format a value for display in the HUD
    private func format(value: CGFloat) -> String {
        return String(format: "%d", Int(roundf(Float(value))))
    }

    /// Add a node to display a value, along with a label node.
    ///
    /// - parameter valueNode: The value node.
    /// - parameter labelText: Static text to be displayed to the left of the value.
    /// - parameter position: The center of the left edge of the valueNode.
    private func addNodes(valueNode: SKLabelNode, labelText: String, position: CGPoint) {
        let valuePosition = position
        let labelPosition = position.pointToLeft(by: 6)
        let label = makeLabelNode(text: labelText)

        valueNode.position = valuePosition
        valueNode.zPosition = ZPosition.hud
        label.position = labelPosition
        label.zPosition = ZPosition.hud

        addChild(label)
        addChild(valueNode)
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
