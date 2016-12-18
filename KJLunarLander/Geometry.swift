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
    return CGFloat(cos(Double(radians)))
}

/// Calculate sine for a CGFloat angle.
func sin(_ radians: CGFloat) -> CGFloat {
    return CGFloat(sin(Double(radians)))
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
    var center: CGPoint {
        return CGPoint(x: midX, y: midY)
    }
}

extension CGPoint {

    /// Return a point that is offset to the left of
    /// this point by the specified amount.
    func pointToLeft(by dx: CGFloat) -> CGPoint {
        return CGPoint(x: self.x - dx, y: self.y)
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
