//
//  Geometry.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics
import SpriteKit

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
