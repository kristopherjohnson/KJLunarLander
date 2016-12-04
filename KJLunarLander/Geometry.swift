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
