//
//  Category.swift
//  KJLunarLander
//
//  Copyright © 2016 Kristopher Johnson. All rights reserved.
//

/// Physics body category bitmasks
///
/// Values defined here are assigned to the `SKSpriteNode`
/// `categoryBitMask` property.
struct Category {
    /// Player's lander
    static let lander  = UInt32(1 << 0)

    /// Lunar surface
    static let surface = UInt32(1 << 1)

    /// Landing target
    static let target  = UInt32(1 << 2)
}
