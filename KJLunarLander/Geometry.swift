//
//  Geometry.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics
import SpriteKit

/// pi as CGFloat
let pi = CGFloat(M_PI)

/// pi/2 as CGFloat
let pi2 = CGFloat(M_PI_2)

/// pi/4 as CGFloat
let pi4 = CGFloat(M_PI_4)

/// Calculate cosine for a CGFloat angle.
func cos(_ radians: CGFloat) -> CGFloat {
    return CGFloat(cos(radians.native))
}

/// Calculate sine for a CGFloat angle.
func sin(_ radians: CGFloat) -> CGFloat {
    return CGFloat(sin(radians.native))
}

extension CGVector {
    
    /// Construct CGVector from angle and magnitude.
    ///
    /// - parameter angle: Angle in radians.
    /// - parameter length: Magnitude.
    init(angle: CGFloat, length: CGFloat) {
        self.init(dx: cos(angle) * length,
                  dy: sin(angle) * length)
    }
}

extension CGRect {
    
    /// Get the center point of a CGRect.
    var centerPoint: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGPoint {

    /// Return a CGPoint with this point's coordinates rounded to nearest whole coordinates.
    ///
    /// - returns: `CGPoint` with non-fractional coordinates
    var roundedCoordinates: CGPoint {
        return CGPoint(x: round(self.x),
                       y: round(self.y))
    }

    /// Return a point that is offset to the left of
    /// this point by the specified amount.
    func pointToLeft(by dx: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - dx,
                       y: self.y)
    }

    /// Calculate the distance to another point.
    ///
    /// - parameter point: A point.
    ///
    /// - returns: Non-negative distance.
    func distanceTo(point: CGPoint) -> CGFloat {
        return CGFloat(hypot(self.x - point.x,
                             self.y - point.y))
    }

    /// Calculate Y-axis distance between a point and a line segment.
    ///
    /// - parameter endpointA: One endpoint of the line segment.
    /// - parameter endpointB: The other endpoint of the line segment.
    ///
    /// - returns: Distance, or `nil` if this point's x-coordinate is not between those of the endpoints.
    func distanceAboveLineSegment(endpointA: CGPoint,
                                  endpointB: CGPoint) -> CGFloat?
    {
        // Fail if endpoints are on a vertical line.
        if endpointA.x == endpointB.x {
            return nil
        }

        // Swap endpoints if necessary so that endpointLeft is the leftmost point.
        var endpointLeft = endpointA
        var endpointRight = endpointB
        if endpointLeft.x > endpointRight.x {
            swap(&endpointLeft, &endpointRight)
        }

        let x = self.x

        // If not over the line segment, fail.
        if x < endpointLeft.x || endpointRight.x < x {
            return nil
        }

        // Find the y-coordinate where a vertical line crosses the line segment.
        let slope = (endpointRight.y - endpointLeft.y) / (endpointRight.x - endpointLeft.x)
        let dx = x - endpointLeft.x
        let dy = slope * dx
        let yIntercept = endpointLeft.y + dy

        // Return distance.
        return self.y - yIntercept
    }
}

/// Create a CGPath from an array of CGPoint.
///
/// - parameter points: Array of CGPoint.
/// - returns: CGPath
func closedCGPath(points: [CGPoint]) -> CGPath {
    let path = CGMutablePath()

    let count = points.count
    assert(count >= 3, "closedCGPath requires at least 3 points")

    path.move(to: points[0])
    for i in 1..<count {
        path.addLine(to: points[i])
    }
    path.closeSubpath()

    return path
}

extension CGPath {
    /// Call the given closure on each element of the path.
    func forEach(_ body: @escaping (CGPathElement) -> Void) {
        var info = body
        self.apply(info: &info) { (infoPtr, elementPtr) in
            let opaquePtr = OpaquePointer(infoPtr!)
            let body = UnsafeMutablePointer<(CGPathElement) -> Void>(opaquePtr).pointee
            body(elementPtr.pointee)
        }
    }
}

extension Comparable {

    /// Return value clamped to specified range.
    ///
    /// - parameter range: Minimum and maximum values.
    ///
    /// - returns: value
    func clamped(to range: ClosedRange<Self>) -> Self {
        return min(max(self, range.lowerBound), range.upperBound)
    }
}

extension SKNode {

    /// Add the specified offset to the node's position.x coordinate.
    /// 
    /// dx may be negative, which results in a move to the left.
    ///
    /// - parameter dx: Distance to move.
    func moveRight(by dx: CGFloat) {
        var pos = position
        pos.x = pos.x + dx
        position = pos
    }
}
