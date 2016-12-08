//
//  Geometry.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

import CoreGraphics

extension CGRect {
    /// Get the center point.
    ///
    /// - returns: `CGPoint`
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
