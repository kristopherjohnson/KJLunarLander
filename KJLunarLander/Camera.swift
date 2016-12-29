//
//  Camera.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import SpriteKit

/// SKCameraNode subclass specialized for this app.
final class Camera: SKCameraNode {

    /// Time interval for zoom actions.
    private let zoomTimeInterval: TimeInterval = 0.1

    /// Scale for zoom-in.
    private let zoomInScale: CGFloat = 0.5

    private let zoomMoveActionKey = "zoomMove"
    private let zoomScaleActionKey = "zoomScale"

    /// Is camera currently zoomed in?
    private var isZoomedIn = false

    /// Follow an object at a given position at the given altitude.
    ///
    /// If the object is at a high altitude, then zoom out to show
    /// the entire scene.
    ///
    /// If the object is at a low altitude, then zoom in and position
    /// the camera so that the object and the surface are visible.
    /// As the object moves, move the camera if it gets close to
    /// an edge.
    ///
    /// - parameter focusPosition: Object position in scene coordinates.
    /// - parameter altitude: Altitude of object above surface.
    public func follow(focusPosition: CGPoint, altitude: CGFloat) {

        // Altitude at which the camera will zoom in for closer view.
        let zoomAltitude = Constant.sceneSize.height * 0.33
        
        if isZoomedIn {
            if altitude > zoomAltitude {
                zoomCameraOut()
            }
            else {
                let newPosition = zoomedFollowPosition(focusPosition: focusPosition,
                                                       altitude: altitude)
                if newPosition != position {
                    moveCamera(focusPosition: newPosition)
                }
            }
        }
        else {
            if altitude < zoomAltitude {
                let newPosition = zoomedFollowPosition(focusPosition: focusPosition,
                                                       altitude: altitude)
                zoomCameraIn(focusPosition: newPosition)
            }
        }
    }

    private func zoomedFollowPosition(focusPosition: CGPoint, altitude: CGFloat) -> CGPoint {
        var newPosition = position
        let sceneSpan = Constant.sceneSize.height
        let cameraSpan = yScale * sceneSpan
        let halfCameraSpan = cameraSpan * 0.5
        let quarterCameraSpan = cameraSpan * 0.25

        newPosition.y = focusPosition.y - altitude + 0.4 * cameraSpan
        newPosition.y = max(newPosition.y, 0.2 * cameraSpan)

        // Set horizontal position so that lander is within camera.
        let leftLimit = focusPosition.x - quarterCameraSpan
        let rightLimit = focusPosition.x + quarterCameraSpan
        newPosition.x = newPosition.x.clamped(to: leftLimit...rightLimit)

        // Clamp horizontal position to scene edges.
        let screenXRange = halfCameraSpan...(sceneSpan - halfCameraSpan)
        newPosition.x = newPosition.x.clamped(to: screenXRange)

        return newPosition
    }

    private func zoomCameraOut() {
        isZoomedIn = false
        let focusPosition = scene?.frame.centerPoint ?? CGPoint.zero
        run(SKAction.move(to: focusPosition, duration: zoomTimeInterval),
            withKey: zoomMoveActionKey)
        run(SKAction.scale(to: 1.0, duration: zoomTimeInterval),
            withKey: zoomScaleActionKey)
    }

    private func zoomCameraIn(focusPosition: CGPoint) {
        isZoomedIn = true
        position = focusPosition
        run(SKAction.move(to: focusPosition, duration: zoomTimeInterval),
            withKey: zoomMoveActionKey)
        run(SKAction.scale(to: zoomInScale, duration: zoomTimeInterval),
            withKey: zoomScaleActionKey)
    }

    private func moveCamera(focusPosition: CGPoint) {
        removeAction(forKey: zoomMoveActionKey)
        position = focusPosition
    }
}
